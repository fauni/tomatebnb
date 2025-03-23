import 'dart:async';
import 'dart:typed_data';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tomatebnb/bloc/export_blocs.dart';
import 'package:tomatebnb/config/constants/environment.dart';
import 'package:tomatebnb/models/accommodation/accommodation_response_complete_model.dart';
import 'package:tomatebnb/models/reserve/reserve_response_model.dart';
import 'package:tomatebnb/ui/widgets/item_list_instruction_anuncio.dart';
import 'package:tomatebnb/ui/widgets/item_list_rule_anuncio.dart';
import 'package:tomatebnb/ui/widgets/skeleton_image_widget.dart';
import 'package:tomatebnb/utils/dark_lightmode.dart';
import 'package:tomatebnb/utils/static_map_image.dart';

import '../../../models/accommodation/accommodation_servicec_response_model.dart';

class ReserveDetailPage extends StatefulWidget {
  const ReserveDetailPage({super.key});

  @override
  State<ReserveDetailPage> createState() => _ReserveDetailPageState();
}

class _ReserveDetailPageState extends State<ReserveDetailPage> {
  bool _pinned = true;
  bool _snap = false;
  bool _floating = false;

  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  bool end = false;
  String imgsUrl = Environment.UrlImg;
  @override
  void initState() {
    getdarkmodepreviousstate();
    super.initState();
  }

  int _accommodationId = 0;
  int nights=0;
  late ColorNotifire notifire;
  late AccommodationResponseCompleteModel accommodation =
      AccommodationResponseCompleteModel();
  late ReserveResponseModel _reserve = ReserveResponseModel(); 
  List<AccommodationServicecResponseModel> services = [];
  final String _imgsUrl = Environment.UrlImg;
  @override
  Widget build(BuildContext context) {
    _reserve = GoRouterState.of(context).extra as ReserveResponseModel;
    if (_reserve.startDate != null && _reserve.endDate != null) {
      nights = (_reserve.endDate!.difference(_reserve.startDate!).inDays)+1;
    } else {
      nights = 0;
    }
    // _accommodationId = GoRouterState.of(context).extra as int;
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    context
        .read<AccommodationBloc>()
        .add(AccommodationGetByIdEvent(_reserve.accommodationId??0));
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
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
              if(state is AccommodationGetByIdSuccess){
                return SizedBox(
                  height: 70,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Text(
                      //   (accommodation.prices != null &&
                      //           accommodation.prices!.isNotEmpty &&
                      //           accommodation.prices!.first.priceNight != null &&
                      //           accommodation.prices!.first.priceNight != 0)
                      //       ? "Bs. ${accommodation.prices!.first.priceNight.toString()} noche"
                      //       : "Sin precio",
                      //   style: TextStyle(
                      //     fontSize: 16,
                      //     color: Theme.of(context).colorScheme.primary,
                      //     fontFamily: "Gilroy Bold",
                      //     decoration: TextDecoration.underline,
                      //   ),
                      // ),
                      SizedBox(
                        width: 10,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          //  context.push('/select_date', extra: accommodation);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).colorScheme.error,
                          foregroundColor:
                              Theme.of(context).colorScheme.onPrimary,
                          minimumSize: Size(150, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text('CHECK IN'),
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
      backgroundColor: notifire.getbgcolor,
      body: BlocConsumer<AccommodationBloc, AccommodationState>(
        listener: (context, state) {
          if (state is AccommodationGetByIdSuccess) {
            accommodation = state.responseAccommodation;
      context
                .read<AccommodationServiceBloc>()
                .add(AccommodationServicecGetEvent(state.responseAccommodation.id!));
            // setState(() {});
            // print (_accommodationId);
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
          } else if (state is AccommodationGetByIdSuccess){
            // accommodation = state.responseAccommodation;
            return CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  elevation: 0,
                  backgroundColor: notifire.getbgcolor,
                  leading: Padding(
                    padding: const EdgeInsets.only(top: 8, left: 12),
                    child: CircleAvatar(
                      backgroundColor: notifire.getlightblackcolor,
                      child: BackButton(
                        color: notifire.getdarkwhitecolor,
                      ),
                    ),
                  ),
                  actions: [
                    Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: Row(
                        children: [
                          
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
                      background:  CarouselSlider(
                  options: CarouselOptions(
                    autoPlay: true,
                    enlargeCenterPage: true,
                    aspectRatio: 16 / 9,
                    viewportFraction: 1, // Muestra una imagen a la vez
                  ),
                  items: state.responseAccommodation.photos!.isNotEmpty
                      ? state.responseAccommodation.photos!.map((photo) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Container(
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.symmetric(horizontal: 0.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: FadeInImage.memoryNetwork(
                                    placeholder: Uint8List(0),
                                    placeholderErrorBuilder: (context, error, stackTrace) => SkeletonImageWidget(),
                                    image: '$imgsUrl/accommodations/${photo.photoUrl}',
                                    fit: BoxFit.cover, // Para que la imagen cubra el contenedor
                                  ),
                                ),
                              );
                            },
                          );
                        }).toList()
                      : [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.asset("assets/images/BoutiqueHotel.jpg", fit: BoxFit.cover,),
                            ),
                          )
                        ],
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
                                  state.responseAccommodation.title ?? "Sin título",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: notifire.getwhiteblackcolor,
                                    fontFamily: "Gilroy Bold",
                                  ),
                                ),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.015),
                                ReadMoreText(
                                  state.responseAccommodation.description != null
                                      ? '${accommodation.type!.name}: ${accommodation.description}'
                                      : "Sin descripción",
                                  trimLines: 2,
                                  trimMode: TrimMode.Line,
                                  style: TextStyle(
                                      color: notifire.getgreycolor,
                                      fontFamily: "Gilroy Medium"),
                                  trimCollapsedText: 'Mas',
                                  trimExpandedText: 'Menos',
                                  lessStyle: TextStyle(
                                      color: notifire.getdarkbluecolor),
                                  moreStyle: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: notifire.getdarkbluecolor),
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
                                          color: notifire.getdarkbluecolor,
                                        ),
                                        Text(
                                          "${state.responseAccommodation.city ?? "Sin ciudad"}/${state.responseAccommodation.country ?? 'Sin país'}",
                                          style: TextStyle(
                                              color: notifire.getgreycolor,
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
                                          _reserve.numberGuests ?? 0,
                                          "Huespedes"),
                                      itemCapacity(
                                          nights,
                                          "Noches"),
                                      itemCapacity(
                                          _reserve.totalPrice?.round() ?? 0,
                                          "Costo Bs."),
                                      
                                    ],
                                  ),
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
                                      itemDate(
                                          "Desde",
                                          _reserve.startDate?? DateTime(2000),),
                                      itemDate(
                                          "Hasta",
                                          _reserve.endDate?? DateTime(2000),),
                                      
                                    ],
                                  ),
                                ),
                                 Divider(),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.015),
                                Text(
                                  'Lo que este lugar ofrece',
                                  style: TextStyle(
                                      fontSize: 18, fontFamily: "Gilroy Bold"),
                                ),

                                BlocConsumer<AccommodationServiceBloc,
                                    AccommodationServiceState>(
                                  listener: (context, state) {
                                    if (state
                                        is AccommodationServicecGetSuccess) {
                                      services =
                                          state.responseAccommodationServices;
                                    }
                                    if (state
                                        is AccommodationServicecGetError) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text(state.message),
                                      ));
                                      services = [];
                                    }
                                  },
                                  builder: (context, state) {
                                    if (state
                                        is AccommodationServicecGetLoading) {
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                    if (state
                                        is AccommodationServicecGetError) {
                                      return Center(
                                        child: Text(state.message),
                                      );
                                    }

                                    return Container(
                                      child: ListView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        padding: EdgeInsets.zero,
                                        itemCount: services.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return ListTile(
                                            title: Text(
                                              services[index].service?.name ??
                                                  "Sin nombre",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: notifire.getgreycolor,
                                                  fontFamily: "Gilroy Medium"),
                                            ),
                                            leading: Image.asset(
                                              "assets/images/wifi.png",
                                              height: 20,
                                              color:
                                                  notifire.getwhiteblackcolor,
                                            ),
                                          );
                                        
                                        },
                                      ),
                                    );
                                  },
                                ),

                                SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.025),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Ubicación",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontFamily: "Gilroy Bold",
                                          color: notifire.getwhiteblackcolor),
                                    ),
                                   
                                  ],
                                ),
                                Card(
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 8),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        StaticMapImage(
                                            latitude:
                                                accommodation.latitude ?? 0,
                                            longitude:
                                                accommodation.longitude ?? 0,
                                            zoom: 15,
                                            size:
                                                '${MediaQuery.of(context).size.width.toInt()}x200',
                                            apiKey:
                                                'AIzaSyAbYyLahsC3aGr0X3nkuWOXcLjrAZMRSbc'),
                                        SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.01,
                                        ),
                                        Row(
                                          children: [
                                            Image.asset(
                                              "assets/images/Maplocation.png",
                                              height: 20,
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.01,
                                            ),
                                            Text(
                                              "${state.responseAccommodation.address ?? ''}  "
                                              "${state.responseAccommodation.city ?? ""}, ${state.responseAccommodation.country ?? ""}",
                                              style: TextStyle(
                                                  color: notifire.getgreycolor,
                                                  fontFamily: "Gilroy Medium"),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.03,
                                ),

                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Reglas",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: "Gilroy Bold",
                                          color: notifire.getwhiteblackcolor),
                                    ),
                                  ],
                                ),

                                ListView.builder(
                                    scrollDirection: Axis.vertical,
                                     physics:const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount:
                                        (state.responseAccommodation.rules ?? []).length,
                                    itemBuilder: (context, index) {
                                      return ItemListRuleAnuncio(
                                          rule: state.responseAccommodation.rules![index]);
                                    }),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.035),
                                 Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Instrucciones",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: "Gilroy Bold",
                                          color: notifire.getwhiteblackcolor),
                                    ),
                                  ],
                                ),
                                
                                 ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    physics: const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount:
                                        (state.responseAccommodation.instructions ?? []).length,
                                    itemBuilder: (context, index) {
                                      return ItemListInstructionAnuncio(
                                          rule: state.responseAccommodation.instructions![index]);
                                    }),
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
          }
          return Center(child: Text('Sin Datos'),);
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
                  color: notifire.getgreycolor,
                  fontFamily: "Gilroy Medium")),
          Text(
            item,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: TextStyle(
                fontSize: 12,
                color: notifire.getgreycolor,
                fontFamily: "Gilroy Medium"),
          )
        ],
      ),
    );
  }
 Widget itemDate(String item, DateTime date) {
    return SizedBox(
      width: 100.0,
      child: Column(
        children: [
          Text(
            item,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: TextStyle(
                fontSize: 12,
                color: notifire.getgreycolor,
                fontFamily: "Gilroy Medium"),
          ),
          Text("${date.day}/${date.month}/${date.year}",
              style: TextStyle(
                  fontSize: 20,
                  color: notifire.getgreycolor,
                  fontFamily: "Gilroy Medium")),
        ],
      ),
    );
  }
  getdarkmodepreviousstate() async {
    final prefs = await SharedPreferences.getInstance();
    bool? previusstate = prefs.getBool("setIsDark");
    if (previusstate == null) {
      notifire.setIsDark = false;
    } else {
      notifire.setIsDark = previusstate;
    }
  }
}
