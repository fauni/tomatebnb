import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tomatebnb/provider/navigation_provider.dart';
import 'package:tomatebnb/ui/widgets/empty_data_widget.dart';

import '../../../bloc/export_blocs.dart';

class FavoritoPage extends StatefulWidget {
  const FavoritoPage({super.key});

  @override
  State<FavoritoPage> createState() => _FavoritoPageState();
}

class _FavoritoPageState extends State<FavoritoPage> {
  @override
  void initState() {
    super.initState();
    cargarAnunciosFavoritos();
  }

  void cargarAnunciosFavoritos(){
    context.read<AccommodationFavoriteBloc>().add(GetAccommodationFavoriteEvent());
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
        ),
        actions: [
          IconButton(onPressed: ()=> cargarAnunciosFavoritos(), icon: Icon(Icons.refresh)),
          SizedBox(width: 10,)
        ],
      ),
      body: BlocConsumer<AccommodationFavoriteBloc, AccommodationFavoriteState>(
        builder: (context, state) {
          if (state is AccommodationFavoriteLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AccommodationFavoriteLoaded) {
            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              itemCount: state.accommodationList.length,
              itemBuilder: (context, index) {
                final accommodation = state.accommodationList[index];
                return InkWell(
                  onTap: () async {
                    await context.push('/detail_ads', extra: accommodation.id);
                    cargarAnunciosFavoritos();
                  },
                  child: Container(
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surfaceContainer,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Container(
                            height: 75,
                            width: 75,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                accommodation.photos![0].url,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Icon(Icons.error);
                                },
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  accommodation.title!,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: "Gilroy Bold",
                                    color: Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  accommodation.description!,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: "Gilroy",
                                    color: Theme.of(context).colorScheme.secondary,
                                    overflow: TextOverflow.ellipsis
                                  ),
                                  maxLines: 2,
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '${accommodation.prices![0].priceNight} BS/Noche',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Theme.of(context).colorScheme.primary
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Image.asset(
                                          "assets/images/star.png",
                                          height: 20,
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          '4.5',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Theme.of(context).colorScheme.inversePrimary,
                                            fontWeight: FontWeight.bold
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else if (state is AccommodationFavoriteError) {
            return EmptyDataWidget(
              message: state.message,
              image: 'assets/images/heart.png',
              onPush: () {
                context.read<NavigationProvider>().setPage(0);
              },
            );
          } else {
            return const Center(child: Text('No hay favoritos'));
          }
        },
        listener: (context, state) {},
      ),
    );
  }
}