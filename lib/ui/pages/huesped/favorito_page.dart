import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tomatebnb/utils/customwidget.dart';

import '../../../bloc/export_blocs.dart';

class FavoritoPage extends StatefulWidget {
  const FavoritoPage({super.key});

  @override
  State<FavoritoPage> createState() => _FavoritoPageState();
}

class _FavoritoPageState extends State<FavoritoPage> {
  @override
  void initState() {
    context.read<AccommodationFavoriteBloc>().add(GetAccommodationFavoriteEvent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.surface,
        surfaceTintColor: Theme.of(context).colorScheme.surface,
        automaticallyImplyLeading: false,
        // leading: BackButton(color: notifire.getwhiteblackcolor),
        title: Text(
          "Favoritos",
          style: TextStyle(fontFamily: "Gilroy Bold"),
        )
      ),
      body: BlocConsumer<AccommodationFavoriteBloc, AccommodationFavoriteState>(
        builder: (context, state) {
          if (state is AccommodationFavoriteLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AccommodationFavoriteLoaded) {
            return ListView.builder(
              itemCount: state.accommodationList.length,
              itemBuilder: (context, index) {
                final accommodation = state.accommodationList[index];
                return ListTile(
                  title: Text(accommodation.title!),
                  subtitle: Text(accommodation.description!),
                );
              },
            );
          } else if (state is AccommodationFavoriteError) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: Text('No hay favoritos'));
          }
        }, 
        listener: (context, state) {
          
        },
      ),
    );
  }
}