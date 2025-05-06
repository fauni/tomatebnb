import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tomatebnb/bloc/export_blocs.dart';
import 'package:tomatebnb/models/accommodation/accommodation_filter_request.dart';
import 'package:tomatebnb/models/accommodation/accommodation_response_complete_model.dart';
import 'package:tomatebnb/ui/widgets/empty_data_widget.dart';
import 'package:tomatebnb/ui/widgets/lista_anuncios_explore.dart';
import 'package:tomatebnb/ui/widgets/lista_describes_explore.dart';
import 'package:tomatebnb/ui/widgets/search_home_widget.dart';

class ExplorarPage extends StatefulWidget {
  const ExplorarPage({super.key});

  @override
  State<ExplorarPage> createState() => _ExplorarPageState();
}

class _ExplorarPageState extends State<ExplorarPage> {
  // Índice de la categoría seleccionada
  
  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  void _loadInitialData() {
    context.read<ExploreDescribeBloc>().add(GetDescribesForExploreEvent());
    context.read<ExploreAccommodationBloc>().add(NearbyAccommodationGetEvent());
  }

  void _loadByFilter(AccommodationFilterRequest dataFilter){
    context.read<ExploreAccommodationBloc>().add(GetAccommodationByFilterEvent(dataFilter));
  }

  @override
  Widget build(BuildContext context) {
    List<AccommodationResponseCompleteModel> accommodations = [];
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        onPressed: () {
          context.push('/explorar_mapa');
        },
        label: Text('Mapa'),
        icon: Icon(Icons.map),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          SearchHomeWidget(
            onSearch: () async {
              final result = await context.push<AccommodationFilterRequest>('/accommodation_filter');
              _loadByFilter(result!);
            },
          ),
          BlocConsumer<ExploreDescribeBloc, ExploreDescribeState>(
            listener: (context, state) {
              if (state is DescribesForExploreSuccess){
                // state.describes.forEach((element) {
                //   print(element.icon);
                // });
              }
            },
            builder: (context, state) {
              if(state is DescribesForExploreLoading){
                return Center(child: CircularProgressIndicator(),);
              }else if(state is DescribesForExploreError){
                return Center(child: Text(state.message),);
              }else if(state is DescribesForExploreSuccess){
                return ListaDescribesExplore(
                  listaDescribes: state.describes, 
                  onDescribeSelected: (p0) => context.read<ExploreAccommodationBloc>().add(GetAccommodationByDescribeEvent(p0.id!)),
                );
              } else {
                return SizedBox();
              }
            },
          ),
          Expanded(
            child: BlocConsumer<ExploreAccommodationBloc, ExploreAccommodationState>(
              listener: (context, state) {
                // TODO: implement listener
              },
              builder: (context, state) {
                accommodations = [];
                String errorMessage = 'Ocurrio un error al cargar los anuncios';
                String emptyMessage = 'No se encontraron anuncios';
                if (state is GetAccommodationNearbyLoading || state is GetAccommodationByDescribeLoading) {
                  return Center(child: CircularProgressIndicator(),);
                } else if (state is GetAccommodationNearbySuccess) {
                  accommodations = state.accommodations;
                  emptyMessage = 'No hay anuncios cercanos';
                } else if(state is GetAccommodationByDescribeSuccess){
                  accommodations = state.accommodations;
                  emptyMessage = 'No se encontraron anuncios para esta categoría';
                } else if(state is AccommodationFilterSuccess){
                  accommodations = state.accommodations;
                  emptyMessage = 'No se encontraron anuncios para esta búsqueda';
                }
                
                else if (state is GetAccommodationNearbyError || state is GetAccommodationByDescribeError) {
                  return EmptyDataWidget(
                    message: state is GetAccommodationNearbyError ? state.message : (state as GetAccommodationByDescribeError).message,
                    image: 'assets/images/empty-folder.png',
                    onPush: () => context.read<ExploreAccommodationBloc>().add(NearbyAccommodationGetEvent())
                  );
                } 
                return accommodations.isEmpty
                  ? EmptyDataWidget(
                    message: emptyMessage, 
                    image: 'assets/images/empty-folder.png', 
                    onPush: () => context.read<ExploreAccommodationBloc>().add(NearbyAccommodationGetEvent()))
                  : ListAnuncioExplore(accommodations: accommodations);
              },
            ),
          )
        ],
      ),
    );
  }
}
