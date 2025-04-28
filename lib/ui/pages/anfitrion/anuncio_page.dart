import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tomatebnb/bloc/export_blocs.dart';
import 'package:tomatebnb/models/accommodation/accommodation_response_complete_model.dart';
import 'package:tomatebnb/ui/widgets/empty_data_widget.dart';
import 'package:tomatebnb/ui/widgets/item_list_anuncio.dart';

class AnuncioPage extends StatefulWidget {
  const AnuncioPage({super.key});

  @override
  State<AnuncioPage> createState() => _AnuncioPageState();
}

class _AnuncioPageState extends State<AnuncioPage> {
  List<AccommodationResponseCompleteModel> ads = [];
  @override
  void initState() {
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    context.read<AccommodationBloc>().add(AccommodationGetEvent());
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.surface,
        surfaceTintColor: Theme.of(context).colorScheme.surface,
        automaticallyImplyLeading: false,
        title: Text("Mis Anuncios",style: TextStyle(fontFamily: "Gilroy Bold"),
      ),
      actions: [
        Ink(
          height: 40,
          decoration:ShapeDecoration(color: Colors.grey[300], shape: CircleBorder()),
          child: IconButton(onPressed: () {context.push('/startad');},
          icon: const Icon(Icons.add)),
        ),
        SizedBox(width: 10,)
      ],
    ),
    backgroundColor: Theme.of(context).colorScheme.surface,
    body: BlocConsumer<AccommodationBloc, AccommodationState>(
      listener:(context, state) {
        if (state is AccommodationGetSuccess) {
          ads = state.responseAccommodations;
        }
      },
        builder: (context, state) {
          if (state is AccommodationLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is AccommodationGetError) {
            return Center(
              child: Text(state.message),
            );
          }
          if (ads.isNotEmpty) {
            return ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(horizontal: 10),
              itemCount: ads.length,
              itemBuilder: (BuildContext context, int index) {
                return ItemListAnuncio(anuncio: ads[index],);
              },
            );
          } else {
            return EmptyDataWidget(
              message: 'Todavia no tienes anuncios creados', 
              image: "assets/images/empty-folder.png",
              textButton: "Crear Anuncio",
              iconButton: Icons.add_home_work_outlined,
              onPush: () => context.push('/startad'),
            );
          }
        },
      ),
    );
  }
}
