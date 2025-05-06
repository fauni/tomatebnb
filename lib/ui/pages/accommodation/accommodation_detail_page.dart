import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tomatebnb/bloc/export_blocs.dart';
import 'package:tomatebnb/config/app_colors.dart';
import 'package:tomatebnb/config/constants/environment.dart';
import 'package:tomatebnb/models/accommodation/accommodation_request_model.dart';
import 'package:tomatebnb/models/accommodation/accommodation_response_complete_model.dart';
import 'package:tomatebnb/models/accommodation/accommodation_servicec_response_model.dart';
import 'package:tomatebnb/models/user/user_response_model.dart';
import 'package:tomatebnb/utils/Colors.dart';
import 'package:tomatebnb/utils/dark_lightmode.dart';

class AccommodationDetailPage extends StatefulWidget {
  const AccommodationDetailPage({super.key});

  @override
  State<AccommodationDetailPage> createState() =>
      _AccommodationDetailPageState();
}

class _AccommodationDetailPageState extends State<AccommodationDetailPage> {
  bool _pinned = true;
  bool _snap = false;
  bool _floating = false;
  @override
  void initState() {
    super.initState();
    getdarkmodepreviousstate();
  }
  

  int _accommodationId = 0;
  final String _imgsUrl = Environment.UrlImg;
  late ColorNotifire notifire;
  late AccommodationResponseCompleteModel accommodation=AccommodationResponseCompleteModel();
  List<AccommodationServicecResponseModel> services = [];
  UserResponseModel user = UserResponseModel();
  AccommodationRequestModel requestModel =AccommodationRequestModel();

  
  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    _accommodationId = GoRouterState.of(context).extra as int;
    context.read<AccommodationBloc>().add(AccommodationGetByIdEvent(_accommodationId));
    return Scaffold(
      backgroundColor: notifire.getbgcolor,
      body: CustomScrollView(
        slivers: <Widget>[
          BlocConsumer<AccommodationBloc, AccommodationState>(
            listener: (context, state) {
              if (state is AccommodationGetByIdSuccess) {
                accommodation = state.responseAccommodation;
                context.read<AccommodationServiceBloc>().add(AccommodationServicecGetEvent(accommodation.id!));
                context.read<UserBloc>().add(UserGetByIdEvent());
              }
            },
            builder: (context, state) {
              if (state is AccommodationGetByIdLoading) {
                return SliverToBoxAdapter(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              if (state is AccommodationGetByIdError) {
                return SliverToBoxAdapter(
                  child: Center(
                    child: Text(state.message),
                  ),
                );
              }
              if (state is AccommodationGetByIdSuccess) {
                accommodation = state.responseAccommodation;
                return SliverAppBar(
                  elevation: 0,
                  actions: [
                    IconButton(onPressed: (){
                      context.read<AccommodationBloc>().add(AccommodationGetByIdEvent(_accommodationId));
                    }, icon: Icon(Icons.refresh))
                  ],
                  leading: Padding(
                    padding: const EdgeInsets.only(top: 8, left: 12),
                    child: CircleAvatar(
                      backgroundColor: notifire.getlightblackcolor,
                      child: BackButton(
                        color: notifire.getdarkwhitecolor,
                      ),
                    ),
                  ),
                  pinned: _pinned,
                  snap: _snap,
                  floating: _floating,
                  expandedHeight: 250,
                  flexibleSpace: FlexibleSpaceBar(
                    background: accommodation.photos!.isNotEmpty
                        ? FadeInImage.assetNetwork(
                            placeholder: 'assets/images/load.gif',
                            image: accommodation.photos!.first.url,
                          )
                        : Image.asset("assets/images/SagamoreResort.jpg",
                            height: 20),
                  ),
                );
              }
              return SliverToBoxAdapter(
                child: Center(
                  child: Text("Sin Fotos"),
                ),
              );
            },
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                BlocBuilder<AccommodationBloc, AccommodationState>(
                  builder: (context, state) {
                    if (state is AccommodationGetByIdLoading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    if (state is AccommodationGetByIdSuccess) {
                      accommodation = state.responseAccommodation;
                      return Padding(
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
                                          "${accommodation.address ?? "sin dirección"}, ${accommodation.city ?? "Sin ciudad"}",
                                          style: TextStyle(
                                              color: notifire.getgreycolor,
                                              fontSize: 14,
                                              fontFamily: "Gilroy Medium"),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.015,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      accommodation.prices!.isNotEmpty
                                          ? "Bs. ${accommodation.prices![0].priceNight}"
                                          : "Precio no definido",
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
                                ReadMoreText(
                                  accommodation.description ??
                                      "Sin descripción",
                                  trimLines: 2,
                                  trimMode: TrimMode.Line,
                                  style: TextStyle(
                                      color: notifire.getgreycolor,
                                      fontFamily: "Gilroy Medium"),
                                  trimCollapsedText: 'Show more',
                                  trimExpandedText: 'Show less',
                                  lessStyle: TextStyle(
                                      color: notifire.getdarkbluecolor),
                                  moreStyle: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: notifire.getdarkbluecolor),
                                ),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.03),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        if(_accommodationId!=0){
                                        context.push('/rules',
                                            extra: _accommodationId);
                                        }
                                      },
                                      child: Text(
                                            "Ver Reglas",
                                            style: TextStyle(
                                                 fontSize: 16,
                                                fontFamily: "Gilroy Bold",
                                                color: notifire.getdarkbluecolor),
                                          ),
                                          
                                    ),
                                  ],
                                ),
                                SizedBox(height: 12.0,),
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
                                                FadeInImage.assetNetwork(
                                              placeholder:
                                                  'assets/images/load.gif',
                                              image:
                                                  // '$_imgsUrl/services/${services[index].icon}',
                                                   services[index].service!.icon,
                                              height: 30.0,
                                              width: 30.0,
                                            ),
                                               
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
                                      "Localización",
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
                                              "${accommodation.address}, ${accommodation.city}",
                                              style: TextStyle(
                                                  color: notifire.getgreycolor,
                                                  fontFamily: "Gilroy Medium"),
                                            )
                                          ],
                                        ),
                                        const SizedBox(height: 6),
                                        // Padding(
                                        //   padding:
                                        //       const EdgeInsets.only(left: 4),
                                        //   child: Text(
                                        //     "View Details",
                                        //     style: TextStyle(
                                        //       color: notifire.getdarkbluecolor,
                                        //       fontFamily: "Gilroy Medium",
                                        //     ),
                                        //   ),
                                        // )
                                      ],
                                    ),
                                  ),
                                ),
                                 SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.02,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        if(_accommodationId!=0){
                                        context.push('/instructions',
                                            extra: _accommodationId);
                                        }
                                      },
                                      child: Text(
                                            "Ver Instrucciones",
                                            style: TextStyle(
                                                 fontSize: 16,
                                                fontFamily: "Gilroy Bold",
                                                color: notifire.getdarkbluecolor),
                                          ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.03,
                                ),
                                SizedBox(
                                  height: 180.0,
                                  child: ListView.builder(
                                    itemCount: accommodation.photos!.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: FadeInImage.assetNetwork(
                                          placeholder: 'assets/images/load.gif',
                                          image: accommodation.photos![index].url,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                               
                                SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.035),
                              ],
                            ),
                          ],
                        ),
                      );
                    } else {
                      return Center(child: Text('No data'));
                    }
                  },
                ),
                Container(
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
                  child: BlocConsumer<AccommodationBloc, AccommodationState>(
                    listener: (context, state) {
                      if (state is AccommodationPublishError) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(state.message),
                          backgroundColor: Theme.of(context).colorScheme.error,
                        ));
                      }
                      if (state is AccommodationPublishSuccess) {
                        accommodation.priceNight = requestModel.priceNight;
                        
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: 
                          (accommodation.priceNight??0) ==0  
                          ?Text("Se quitó la publicación")
                          :Text("Anuncio Publicado"),
                          backgroundColor: Theme.of(context).colorScheme.primary,
                        ));
                        context.pop();
                        
                      }
                    },
                    builder: (context, state) {
                      if (state is AccommodationPublishLoading) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height: 70,
                              child: CircleAvatar(
                                radius: 33,
                                // ignore: sort_child_properties_last
                                child: IconButton(
                                  onPressed: () {
                                    context.replace('/describe',
                                     extra: _accommodationId);
                                  },
                                  color: AppColors().greyColor2,// Theme.of(context).colorScheme.secondary,
                                  icon: Icon(Icons.edit_document),
                                  iconSize: 35.0,
                                ),
                                backgroundColor: notifire.getbgcolor,
                              ),
                            ),
                            BlocConsumer<UserBloc, UserState>(
                              listener: (context, state) {
                                if (state is UserGetByIdSuccess) {
                                  user = state.responseUser;
                                }
                                if (state is UserGetByIdError) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text(state.message),
                                  ));
                                }
                              },
                              builder: (context, state) {
                                if (state is UserGetByIdLoading) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                                if (state is UserGetByIdSuccess) {
                                  return accommodation.published??false
                                  ?InkWell(
                                    onTap: () {
                                     
                                        requestModel.priceNight = 0;
                                            
                                        context.read<AccommodationBloc>().add(
                                            AccommodationPublishEvent(
                                                _accommodationId,
                                                requestModel.priceNight!,
                                                false));
                                      
                                    },
                                    child: Container(
                                      height: 63,
                                      width: MediaQuery.of(context).size.width /
                                          1.3,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary),
                                      child: Center(
                                        child: Text(
                                          "Quitar Publicacion",
                                          style: TextStyle(
                                            color: WhiteColor,
                                            fontSize: 18,
                                            fontFamily: "Gilroy Bold",
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                
                                  :InkWell(
                                    onTap: () {
                                      bool repacc = accommodationDataComplete();
                                      bool repuser = userDataComplete();
                                      if (!repacc && !repuser) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          duration: Duration(seconds: 3),
                                          content: Text(
                                              "Datos del alojamiento y usuario incompletos "),
                                          backgroundColor: Theme.of(context)
                                              .colorScheme
                                              .error,
                                        ));
                                      } else if (!repacc) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                                    "Complete los datos del anuncio"),
                                                backgroundColor:
                                                    Theme.of(context)
                                                        .colorScheme
                                                        .error));
                                      } else if (!repuser) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                                    "Complete sus datos personales"),
                                                backgroundColor:
                                                    Theme.of(context)
                                                        .colorScheme
                                                        .error));
                                      } else{
                                        
                                        requestModel.priceNight = accommodation
                                            .prices?.first.priceNight;
                                        context.read<AccommodationBloc>().add(
                                            AccommodationPublishEvent(
                                                _accommodationId,
                                                requestModel.priceNight!,
                                                true));
                                      }
                                    },
                                    child: Container(
                                      height: 63,
                                      width: MediaQuery.of(context).size.width /
                                          1.3,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary),
                                      child: Center(
                                        child: Text(
                                          "Publicar",
                                          style: TextStyle(
                                            color: WhiteColor,
                                            fontSize: 18,
                                            fontFamily: "Gilroy Bold",
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                
                                } else {
                                  return Text('No data');
                                }
                              },
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
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

  bool userDataComplete() {
    return user.name != null &&
        user.lastname != null &&
        user.phone != null &&
        user.email != null &&
        user.documentPhotoBack != null &&
        user.documentPhotoFront != null &&
        user.confirmPhoto != null &&
        user.documentType != null &&
        user.documentNumber != null;
  }

  bool accommodationDataComplete() {
    return accommodation.title != null &&
        accommodation.description != null &&
        accommodation.address != null &&
        accommodation.city != null &&
        accommodation.prices != null &&
        accommodation.prices!.isNotEmpty &&
        accommodation.photos!.isNotEmpty &&
        accommodation.guestCapacity != null &&
        accommodation.numberBathrooms != null &&
        accommodation.numberBeds != null &&
        accommodation.guestCapacity != null &&
        accommodation.latitude != null &&
        accommodation.longitude != null;
  }
}
