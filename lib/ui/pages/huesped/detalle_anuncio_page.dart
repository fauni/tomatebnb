import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tomatebnb/bloc/export_blocs.dart';
import 'package:tomatebnb/config/constants/environment.dart';
import 'package:tomatebnb/models/accommodation/accommodation_response_complete_model.dart';
import 'package:tomatebnb/ui/widgets/item_list_rule_anuncio.dart';
import 'package:tomatebnb/utils/Colors.dart';
import 'package:tomatebnb/utils/dark_lightmode.dart';

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

  @override
  void initState() {
    getdarkmodepreviousstate();
    super.initState();
  }
  int _accommodationId = 0;
  late ColorNotifire notifire;
  late AccommodationResponseCompleteModel accommodation =
      AccommodationResponseCompleteModel();
  List<AccommodationServicecResponseModel> services = [];
  final String _imgsUrl = Environment.UrlImg;
  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    _accommodationId = GoRouterState.of(context).extra as int;
     context
        .read<AccommodationBloc>()
        .add(AccommodationGetByIdEvent(_accommodationId));
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: notifire.getdarkmodecolor,
          boxShadow: [
            BoxShadow(
              color: notifire.getdarkmodecolor,
              blurRadius: 10,
              spreadRadius: 10,
              blurStyle: BlurStyle.normal,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 70,
                child: CircleAvatar(
                  radius: 33,
                  // ignore: sort_child_properties_last
                  child: Image.asset(
                    "assets/images/Chat.png",
                    height: 35,
                    color: notifire.getwhitebluecolor,
                  ),
                  backgroundColor: notifire.getbgcolor,
                ),
              ),
              InkWell(
                onTap: () {
                  // Navigator.of(context)
                  //     .push(MaterialPageRoute(
                  //         builder: (context) => const chackout()))
                  //     .then((value) => print('ok Navigat'));
                  context.push('/select_date',extra: accommodation);
                },
                child: Container(
                  height: 63,
                  width: MediaQuery.of(context).size.width / 1.3,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15), color: Theme.of(context).primaryColor),
                  child: Center(
                    child: Text(
                      "Reservar",
                      style: TextStyle(
                        color: WhiteColor,
                        fontSize: 18,
                        fontFamily: "Gilroy Bold",
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      backgroundColor: notifire.getbgcolor,
      body: BlocConsumer<AccommodationBloc, AccommodationState>(
        listener: (context, state) {
          if(state is AccommodationGetByIdSuccess){
          accommodation = state.responseAccommodation;
            context
                    .read<AccommodationServiceBloc>()
                    .add(AccommodationServicecGetEvent(accommodation.id!));
          // setState(() {});
          // print (_accommodationId);
          }
          if(state is AccommodationGetByIdError){
             ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text(state.message),
                                        backgroundColor: Theme.of(context).colorScheme.error,));
          }
        },
        builder: (context, state) {
          if(state is AccommodationGetByIdLoading){
            return Center(child: CircularProgressIndicator(),);
          }
          if(state is AccommodationGetByIdError){
            return Center (child:Text(state.message));
          }else{
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
                        CircleAvatar(
                          radius: 22,
                          backgroundColor: notifire.getlightblackcolor,
                          child: Image.asset(
                            "assets/images/share.png",
                            color: notifire.getdarkwhitecolor,
                            height: 30,
                          ),
                        ),
                        const SizedBox(width: 20),
                        CircleAvatar(
                          radius: 22,
                          backgroundColor: notifire.getlightblackcolor,
                          child: Image.asset(
                            "assets/images/heart.png",
                            color: notifire.getdarkwhitecolor,
                            height: 25,
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
                  background:(accommodation.photos??[]).isNotEmpty 
              ?PageView.builder(
                    itemCount: (accommodation.photos??[]).length,
                    itemBuilder: (context,index){
                        return  FadeInImage.assetNetwork(
                            placeholder: 'assets/images/load.gif',
                            image:'$_imgsUrl/accommodations/${accommodation.photos![index].photoUrl}',
                          );
                      
                  })
                :Image.asset("assets/images/SagamoreResort.jpg")
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
                                accommodation.title??"Sin título",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: notifire.getwhiteblackcolor,
                                  fontFamily: "Gilroy Bold",
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
                                        color: notifire.getdarkbluecolor,
                                      ),
                                      Text(
                                        "${accommodation.city??"Sin ciudad"}/${accommodation.country??'Sin país'}",
                                        style: TextStyle(
                                            color: notifire.getgreycolor,
                                            fontSize: 14,
                                            fontFamily: "Gilroy Medium"),
                                      )
                                    ],
                                  ),
                                  // Row(
                                  //   children: [
                                  //     Image.asset("assets/images/star.png",
                                  //         height: 18),
                                  //     Text(
                                  //       "4.2",
                                  //       style: TextStyle(
                                  //         fontSize: 16,
                                  //         color: notifire.getdarkbluecolor,
                                  //         fontFamily: "Gilroy Bold",
                                  //       ),
                                  //     ),
                                  //     Text(
                                  //       "(84 Reviews)",
                                  //       style: TextStyle(
                                  //         fontSize: 14,
                                  //         color: notifire.getgreycolor,
                                  //         fontFamily: "Gilroy Medium",
                                  //       ),
                                  //     ),
                                  //   ],
                                  // ),
                                ],
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.015,
                              ),
                              Row(
                                children: [
                                  Text(
                                    ((accommodation.prices)?.first.priceNight??0)!=0
                                    ? "Bs. ${accommodation.prices!.first.priceNight.toString()}"
                                    :"Sin precio",
                                    
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: notifire.getdarkbluecolor,
                                      fontFamily: "Gilroy Bold",
                                    ),
                                  ),

                                  Text(
                                    " Por noche",
                                    style: TextStyle(
                                      fontFamily: "Gilroy Medium",
                                      fontSize: 14,
                                      color: notifire.getwhiteblackcolor,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.015),
                                Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    accommodation.describe?.describe??"",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: "Gilroy Bold",
                                        color: notifire.getwhiteblackcolor),
                                  ),
                                  
                                 Text(
                                    accommodation.type?.name??"",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: "Gilroy Bold",
                                        color: notifire.getwhiteblackcolor),
                                  ),
                                ],
                              ),
                               SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.025),
                              SizedBox(
                                height: 60,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    itemCapacity(accommodation.guestCapacity ?? 0,"Huespedes"),
                                    itemCapacity(accommodation.numberRooms ?? 0,"Recamaras"),
                                    itemCapacity(accommodation.numberBeds ?? 0,"Camas"),
                                    itemCapacity(accommodation.numberBathrooms ?? 0,"Baños"),
                                    
                                  ],
                                ),
                              ),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.015),
                              ReadMoreText(
                                accommodation.description??"Sin descripción",
                                trimLines: 2,
                                trimMode: TrimMode.Line,
                                style: TextStyle(
                                    color: notifire.getgreycolor,
                                    fontFamily: "Gilroy Medium"),
                                trimCollapsedText: 'Mas',
                                trimExpandedText: 'Menos',
                                lessStyle:
                                    TextStyle(color: notifire.getdarkbluecolor),
                                moreStyle: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: notifire.getdarkbluecolor),
                              ),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.03),
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

                                    return SizedBox(
                                      height: 60.0,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: services.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return SizedBox(
                                            width: 100.0,
                                            child: Column(
                                              children: [
                                                Image.asset(
                                                    "assets/images/wifi.png",
                                                    height: 30,
                                                    color: notifire
                                                        .getwhiteblackcolor),
                                                Text(
                                                  services[index]
                                                          .service
                                                          ?.name ??
                                                      "Sin nombre",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color:
                                                          notifire.getgreycolor,
                                                      fontFamily:
                                                          "Gilroy Medium"),
                                                )
                                              ],
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
                                        fontSize: 16,
                                        fontFamily: "Gilroy Bold",
                                        color: notifire.getwhiteblackcolor),
                                  ),
                                  Text(
                                    "View Detail",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: notifire.getdarkbluecolor,
                                        fontFamily: "Gilroy Medium"),
                                  ),
                                ],
                              ),
                             
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.02,
                              ),
                              Card(
                                elevation: 0,
                                color: notifire.getdarkmodecolor,
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
                                      Image.asset(
                                          "assets/images/googlemap.png"),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
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
                                            "${accommodation.address??''}  "
                                            "${accommodation.city??""}, ${accommodation.country??""}",
                                            style: TextStyle(
                                                color: notifire.getgreycolor,
                                                fontFamily: "Gilroy Medium"),
                                          )
                                        ],
                                      ),
                                      const SizedBox(height: 6),
                                     
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
                                  shrinkWrap: true,
                                  itemCount: (accommodation.rules??[]).length, 
                                  itemBuilder: (context,index){
                                     return ItemListRuleAnuncio(rule: accommodation.rules![index]);
                                 }
                                  
                                  ),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.035),
                            
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
        },
      ),
    );
  }

  Widget itemCapacity(int quanitity,String item){
    return SizedBox(
                                            width: 65.0,
                                            child: Column(
                                              children: [
                                                Text("$quanitity",
                                                 style: TextStyle(
                                                      fontSize: 20,
                                                      color:
                                                          notifire.getgreycolor,
                                                      fontFamily:
                                                          "Gilroy Medium")
                                                ),
                                                Text(item
                                                 ,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color:
                                                          notifire.getgreycolor,
                                                      fontFamily:
                                                          "Gilroy Medium"),
                                                )
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
