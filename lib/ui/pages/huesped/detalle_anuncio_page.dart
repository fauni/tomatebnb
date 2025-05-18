import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:readmore/readmore.dart';
import 'package:tomatebnb/bloc/export_blocs.dart';
import 'package:tomatebnb/config/app_colors.dart';
import 'package:tomatebnb/config/constants/environment.dart';
import 'package:tomatebnb/models/accommodation/accommodation_response_complete_model.dart';
import 'package:tomatebnb/ui/widgets/item_list_rule_anuncio.dart';
import 'package:tomatebnb/ui/widgets/skeleton_image_widget.dart';
import 'package:tomatebnb/utils/static_map_image.dart';

import '../../../models/accommodation/accommodation_servicec_response_model.dart';

class DetalleAnuncioPage extends StatefulWidget {
  const DetalleAnuncioPage({super.key});

  @override
  State<DetalleAnuncioPage> createState() => _DetalleAnuncioPageState();
}

class _DetalleAnuncioPageState extends State<DetalleAnuncioPage> {
  bool _pinned = true;
  bool _snap = false;
  bool _floating = false;

  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  bool end = false;

  @override
  void initState() {
    super.initState();
  }

  int _accommodationId = 0;

  late AccommodationResponseCompleteModel accommodation =
      AccommodationResponseCompleteModel();
  List<AccommodationServicecResponseModel> services = [];
  final String _imgsUrl = Environment.UrlImg;

  @override
  Widget build(BuildContext context) {
    _accommodationId = GoRouterState.of(context).extra as int;

    context.read<AccommodationBloc>().add(AccommodationGetByIdEvent(_accommodationId));

    return Scaffold(
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onPrimary,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, -3), // changes position of shadow
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: BlocConsumer<AccommodationBloc, AccommodationState>(
            listener: (context, state) {
              // TODO: implement listener
            },
            builder: (context, state) {
              if (state is AccommodationGetByIdSuccess) {
                return SizedBox(
                  height: 70,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        (accommodation.prices != null && accommodation.prices!.isNotEmpty && accommodation.prices!.first.priceNight !=null && accommodation.prices!.first.priceNight != 0)
                            ? "Bs. ${accommodation.prices!.first.priceNight.toString()} noche"
                            : "Sin precio",
                        style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.primary,
                          fontFamily: "Gilroy Bold",
                          decoration: TextDecoration.none,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          context.push('/select_date', extra: accommodation);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).colorScheme.secondary,
                          foregroundColor:
                              Theme.of(context).colorScheme.onPrimary,
                          minimumSize: Size(150, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text('RESERVAR'),
                      ),
                    ],
                  ),
                );
              }
              return SizedBox();
            },
          ),
        ),
      ),
      body: BlocConsumer<AccommodationBloc, AccommodationState>(
        listener: (context, state) {
          if (state is AccommodationGetByIdSuccess) {
            accommodation = state.responseAccommodation;

            Timer.periodic(Duration(seconds: 5), (Timer timer) {
              if (_currentPage == (accommodation.photos?.length)!) {
                end = true;
              } else if (_currentPage == 0) {
                end = false;
              }

              if (end == false) {
                _currentPage++;
              } else {
                _currentPage--;
              }
              if (_pageController.hasClients) {
                _pageController.animateToPage(
                  _currentPage,
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeIn,
                );
              }
            });
            context
                .read<AccommodationServiceBloc>()
                .add(AccommodationServicecGetEvent(accommodation.id!));
          }
          if (state is AccommodationGetByIdError) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.message),
              backgroundColor: Theme.of(context).colorScheme.error,
            ));
          }
        },
        builder: (context, state) {
          if (state is AccommodationGetByIdLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is AccommodationGetByIdError) {
            return Center(child: Text(state.message));
          } else if (state is AccommodationGetByIdSuccess) {
            // accommodation = state.responseAccommodation;
            return CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  elevation: 0,
                  backgroundColor: AppColors().WhiteColor,
                  leading: Padding(
                    padding: const EdgeInsets.only(top: 8, left: 12),
                    child: BackButton(),
                  ),
                  actions: [
                    Padding(
                      padding: const EdgeInsets.only(top: 12, bottom: 5),
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              if (state.responseAccommodation.isFavorite!) {
                                context.read<AccommodationFavoriteBloc>().add(
                                    RemoveAccommodationFavoriteEvent(state.responseAccommodation.id!));
                              } else {
                                context.read<AccommodationFavoriteBloc>().add(
                                    AddAccommodationFavoriteEvent(state.responseAccommodation.id!));
                              }
                            },
                            child: BlocListener<AccommodationFavoriteBloc, AccommodationFavoriteState>(
                              listener: (context, state) {
                                setState(() {
                                  
                                });
                                // if (state is AccommodationFavoriteAdded) {
                                //   accommodation.isFavorite = true;
                                //   ScaffoldMessenger.of(context).showSnackBar(
                                //     SnackBar(
                                //       content: Text(state.message),
                                //       backgroundColor:
                                //           Theme.of(context).colorScheme.primary,
                                //     ),
                                //   );
                                // }
                                // if (state is AccommodationFavoriteRemoved) {
                                //   accommodation.isFavorite = false;
                                //   ScaffoldMessenger.of(context).showSnackBar(
                                //     SnackBar(
                                //       content: Text(state.message),
                                //       backgroundColor:
                                //           Theme.of(context).colorScheme.primary,
                                //     ),
                                //   );
                                // } 
                                if (state is AccommodationFavoriteError) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(state.message),
                                      backgroundColor:
                                          Theme.of(context).colorScheme.error,
                                    ),
                                  );
                                }
                              },
                              child: CircleAvatar(
                                radius: 18,
                                backgroundColor:
                                    state.responseAccommodation.isFavorite!
                                        ? Colors.red
                                        : AppColors().boxcolor,
                                child: Image.asset(
                                  "assets/images/heart.png",
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                  height: 25,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                        ],
                      ),
                    ),
                  ],
                  pinned: _pinned,
                  snap: _snap,
                  floating: _floating,
                  expandedHeight: 250,
                  flexibleSpace: FlexibleSpaceBar(
                    background:
                        (state.responseAccommodation.photos ?? []).isNotEmpty
                            ? PageView.builder(
                                controller: _pageController,
                                itemCount:
                                    state.responseAccommodation.photos!.length,
                                itemBuilder: (context, index) {
                                  return FadeInImage.memoryNetwork(
                                    placeholder: Uint8List(0),
                                    placeholderErrorBuilder:
                                        (context, error, stackTrace) =>
                                            SkeletonImageWidget(),
                                    image: state.responseAccommodation
                                        .photos![index].url,
                                    fit: BoxFit.cover,
                                  );
                                })
                            : Image.asset(
                                "assets/images/gallery.png",
                                color: Colors.black,
                              ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 12),
                        child: Stack(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  accommodation.title ?? "Sin título",
                                  style: TextStyle(
                                    fontSize: 20,
                                    // color: notifire.getwhiteblackcolor,
                                    fontFamily: "Gilroy Bold",
                                  ),
                                ),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.015),
                                ReadMoreText(
                                  accommodation.description != null
                                      ? '${accommodation.type!.name}: ${accommodation.description}'
                                      : "Sin descripción",
                                  trimLines: 2,
                                  trimMode: TrimMode.Line,
                                  style: TextStyle(
                                      // color: notifire.getgreycolor,
                                      fontFamily: "Gilroy Medium"),
                                  trimCollapsedText: 'Mas',
                                  trimExpandedText: 'Menos',
                                  lessStyle: TextStyle(
                                      // color: notifire.getdarkbluecolor
                                      ),
                                  moreStyle: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    // color: notifire.getdarkbluecolor
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Image.asset(
                                          "assets/images/Maplocation.png",
                                          height: 20,
                                          // color: notifire.getdarkbluecolor,
                                        ),
                                        Text(
                                          "${accommodation.city ?? "Sin ciudad"}/${accommodation.country ?? 'Sin país'}",
                                          style: TextStyle(
                                              // color: notifire.getgreycolor,
                                              fontSize: 14,
                                              fontFamily: "Gilroy Medium"),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                Divider(),

                                SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.015),
                                SizedBox(
                                  height: 60,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      itemCapacity(
                                          accommodation.guestCapacity ?? 0,
                                          "Huespedes"),
                                      itemCapacity(
                                          accommodation.numberRooms ?? 0,
                                          "Recamaras"),
                                      itemCapacity(
                                          accommodation.numberBeds ?? 0,
                                          "Camas"),
                                      itemCapacity(
                                          accommodation.numberBathrooms ?? 0,
                                          "Baños"),
                                    ],
                                  ),
                                ),
                                Divider(),
                                Text(
                                  'Lo que este lugar ofrece',
                                  style: TextStyle(fontSize: 18, fontFamily: "Gilroy Bold"),
                                ),

                                BlocConsumer<AccommodationServiceBloc, AccommodationServiceState>(
                                  listener: (context, state) {
                                    if (state is AccommodationServicecGetSuccess) {
                                      services = state.responseAccommodationServices;
                                    } else if (state is AccommodationServicecGetError) {
                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message),));
                                      services = [];
                                    }
                                  },
                                  builder: (context, state) {
                                    if (state is AccommodationServicecGetLoading) {
                                      return Center(child: CircularProgressIndicator(),);
                                    }
                                    if (state is AccommodationServicecGetError) {
                                      return Center( child: Text(state.message), );
                                    }

                                    return ListView.builder(
                                      physics: const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      padding: EdgeInsets.zero,
                                      itemCount: services.length,
                                      itemBuilder: (BuildContext context, int index) {
                                        return ListTile(
                                          title: Text( services[index].service?.name ?? "Sin nombre",
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontFamily: "Gilroy Medium"),
                                          ),
                                          // subtitle: Text(services[index].service!.icon),
                                          leading: FadeInImage.assetNetwork(
                                            placeholder:'assets/images/load.gif',
                                            image: services[index].service!.icon,
                                            height: 30.0,
                                            width: 30.0,
                                          )
                                        );
                                      },
                                    );
                                  },
                                ),

                                SizedBox(height: MediaQuery.of(context).size.height * 0.025),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Ubicación",
                                      style: TextStyle(fontSize: 18, fontFamily: "Gilroy Bold",),
                                    ),
                                  ],
                                ),
                                Card(
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0),),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        StaticMapImage(
                                            latitude: accommodation.latitude ?? 0,
                                            longitude: accommodation.longitude ?? 0,
                                            zoom: 15,
                                            size: '${MediaQuery.of(context).size.width.toInt()}x200',
                                            apiKey: 'AIzaSyAbYyLahsC3aGr0X3nkuWOXcLjrAZMRSbc'),
                                        SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                                        Row(
                                          children: [
                                            Image.asset("assets/images/Maplocation.png",height: 20,),
                                            SizedBox(width: MediaQuery.of(context).size.width *0.01,),
                                            Text(
                                              "${accommodation.address ?? ''}  "
                                              "${accommodation.city ?? ""}, ${accommodation.country ?? ""}",
                                              style: TextStyle(fontFamily: "Gilroy Medium"),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox( height: MediaQuery.of(context).size.height * 0.03,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Reglas",
                                      style: TextStyle(fontSize: 16,fontFamily: "Gilroy Bold",),
                                    ),
                                  ],
                                ),

                                ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemCount: (accommodation.rules ?? []).length,
                                    itemBuilder: (context, index) {
                                      return ItemListRuleAnuncio(rule: accommodation.rules![index]);
                                    }),
                                SizedBox(height: MediaQuery.of(context).size.height * 0.035),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return Center(
              child: Text("Error al cargar los datos"),
            );
          }
        },
      ),
    );
  }

  Widget itemCapacity(int quanitity, String item) {
    return SizedBox(
      width: 65.0,
      child: Column(
        children: [
          Text("$quanitity",
              style: TextStyle(
                  fontSize: 20,
                  // color: notifire.getgreycolor,
                  fontFamily: "Gilroy Medium")),
          Text(
            item,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: TextStyle(
                fontSize: 12,
                // color: notifire.getgreycolor,
                fontFamily: "Gilroy Medium"),
          )
        ],
      ),
    );
  }
}
