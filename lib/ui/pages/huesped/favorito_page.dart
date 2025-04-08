import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: BlocConsumer<AccommodationFavoriteBloc, AccommodationFavoriteState>(
            builder: (context, state) {
              if (state is AccommodationFavoriteLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is AccommodationFavoriteLoaded) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.accommodationList.length,
                  itemBuilder: (context, index) {
                    final accommodation = state.accommodationList[index];
                    return InkWell(
                      onTap: (){
                        context.push('/detail_ads', extra: accommodation.id);
                      },
                      child: Container(
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        decoration:  BoxDecoration(
                          color: Theme.of(context).colorScheme.surfaceContainer,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                              height: 75,
                              width: 75,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  accommodation.photos![0].url,
                                  errorBuilder: (context, error, stackTrace) {
                                    return const Icon(Icons.error);
                                  },
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Column(
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
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.65,
                                  child: Text(
                                    accommodation.description!,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: "Gilroy",
                                      color: Theme.of(context).colorScheme.secondary,
                                      overflow: TextOverflow.ellipsis
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        Text('${accommodation.prices![0].priceNight} BS', style: TextStyle(fontSize: 16, color: Theme.of(context).colorScheme.primary)),
                                        Text('/Noche', )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const SizedBox(width:12),
                                        Image.asset("assets/images/star.png", height: 20,),
                                        const SizedBox(width: 2),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 4),
                                          child: Row(
                                            children: [
                                              Text('4.5', style: TextStyle(fontSize: 16, color: Theme.of(context).colorScheme.inversePrimary, fontWeight: FontWeight.bold),)
                                            ],
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                                
                      ),
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
        ),
      ),
    );
  }
}