import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tomatebnb/bloc/export_blocs.dart';
import 'package:tomatebnb/models/accommodation/accommodation_response_complete_model.dart';
import 'package:tomatebnb/ui/widgets/empty_data_widget.dart';
import 'package:tomatebnb/ui/widgets/item_list_explore.dart';
import 'package:tomatebnb/ui/widgets/search_home_widget.dart';
import 'package:tomatebnb/ui/widgets/skeleton_icon_describe_widget.dart';

class ExplorarPage extends StatefulWidget {
  const ExplorarPage({super.key});

  @override
  State<ExplorarPage> createState() => _ExplorarPageState();
}

class _ExplorarPageState extends State<ExplorarPage> {
  // Índice de la categoría seleccionada
  int _selectedIndex = 0;


  @override
  void initState() {
    super.initState();
    obtenerAnunciosCercanos();
    obtenerDescribes();
  }

  void obtenerAnunciosCercanos() {
    context.read<ExploreAccommodationBloc>().add(NearbyAccommodationGetEvent());
  }

  void obtenerDescribes() {
    context.read<ExploreDescribeBloc>().add(GetDescribesForExploreEvent());
  }

  @override
  Widget build(BuildContext context) {
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
          SearchHomeWidget(),
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
                return Container(
                  // color: Theme.of(context).colorScheme.tertiary.withAlpha(128),
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: SizedBox(
                    height: 70,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: state.describes.length,
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          width: 20,
                        );
                      },
                      itemBuilder: (context, index) {
                        final describes = state.describes[index];
                        final isSelected = _selectedIndex == index;

                        return InkWell(
                          onTap: () {
                            setState(() {
                              _selectedIndex = index;
                            });
                            // Disparar evento para cargar alojamiento por categoría
                            context.read<ExploreAccommodationBloc>().add(
                              GetAccommodationByDescribeEvent(describes.id!),
                            );
                          },
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 200),
                            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? Theme.of(context).colorScheme.tertiary.withAlpha(50)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FadeInImage.memoryNetwork(
                                  placeholder: Uint8List(0),
                                  placeholderErrorBuilder: (context, error, stackTrace) => SkeletonIconDescribeWidget(),
                                  image: describes.icon!,
                                  height: 30,
                                  width: 30,
                                  color: isSelected
                                      ? Colors.black87
                                      : Theme.of(context).colorScheme.secondary,
                            
                                ),
                                Text(
                                  describes.describe!,
                                  style: TextStyle(
                                      fontFamily: "Gilroy-ThinItalic", fontSize: 10),
                                ),
                                // Barra negra debajo del ítem seleccionado
                                if (isSelected)
                                  Container(
                                    height: 2,
                                    width: 40,
                                    color: Colors.black,
                                  )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              } else {
                return SizedBox();
              }
            },
          ),
          // Divider(
          //   color: Theme.of(context).colorScheme.tertiary,
          //   thickness: 1,
          // ),
          Expanded(
            child: BlocConsumer<ExploreAccommodationBloc, ExploreAccommodationState>(
              listener: (context, state) {
                // TODO: implement listener
              },
              builder: (context, state) {
                if (state is GetAccommodationNearbyLoading || state is GetAccommodationByDescribeLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is GetAccommodationNearbySuccess || state is GetAccommodationByDescribeSuccess) {
                  final accommodations = state is GetAccommodationNearbySuccess
                      ? state.accommodations
                      : (state as GetAccommodationByDescribeSuccess).accommodations;
                  return accommodations.isEmpty 
                  ? EmptyDataWidget(
                    message: 'Todavia no existen anuncios para esta busqueda.',
                    image: 'assets/images/empty-folder.png',
                    onPush: () {
                      
                    },
                  )
                  : ListView.separated(
                      itemBuilder: (context, index) {
                        AccommodationResponseCompleteModel accommodation = accommodations[index];
                        return ItemListExplore(
                          accommodation: accommodation,
                          onTap: () {
                            context.push('/detail_ads', extra: accommodation.id);
                          },
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Divider();
                      },
                      itemCount: accommodations.length);
                } else if (state is GetAccommodationNearbyError || state is GetAccommodationByDescribeError) {
                  return EmptyDataWidget(
                    message: state is GetAccommodationNearbyError ? state.message : (state as GetAccommodationByDescribeError).message,
                    image: 'assets/images/empty-folder.png',
                    onPush: () {
                      
                    },
                  );
                  // return Center(
                  //   child: Text(state is GetAccommodationNearbyError 
                  //     ? state.message 
                  //     : (state as GetAccommodationByDescribeError).message),
                  // );
                } else {
                  return Center(child: Text('Seleccione una categoría'));
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
