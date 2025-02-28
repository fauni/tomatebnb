import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tomatebnb/bloc/export_blocs.dart';
import 'package:tomatebnb/models/accommodation/accommodation_discount_request_model.dart';
import 'package:tomatebnb/models/accommodation/accommodation_price_request_model.dart';
import 'package:tomatebnb/models/accommodation/accommodation_response_model.dart';
import 'package:tomatebnb/utils/Colors.dart';
import 'package:tomatebnb/utils/customwidget.dart';
import 'package:tomatebnb/utils/dark_lightmode.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});
  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  late ColorNotifire notifire;
  @override
  void initState() {
    getdarkmodepreviousstate();
    super.initState();
  }

  late AccommodationResponseModel accommodationResponseModel;

  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    return Scaffold(
        backgroundColor: notifire.getbgcolor,
        body: BlocConsumer<AccommodationDiscountBloc, AccommodationDiscountState>(
          listener: (context, state) {
            if(state is AccommodationDiscountCreateSuccess){
              context.push('/describe',
                        extra: accommodationResponseModel.id);
              
            }
            if(state is AccommodationDiscountCreateError){
               ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(state.message)));
            }
          },
          builder: (context, state) {
            if(state is AccommodationDiscountCreateLoading){
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child:
                  BlocConsumer<AccommodationPriceBloc, AccommodationPriceState>(
                listener: (context, state) {
                  if (state is AccommodationPriceCreateSuccess) {
                    context.push('/describe',
                        extra: accommodationResponseModel.id);
                     context.read<AccommodationDiscountBloc>().add(
                              AccommodationDiscountCreateEvent(
                                  AccommodationDiscountRequestModel(
                                      accommodationId:accommodationResponseModel.id ?? 0,
                                      discountValuea: 0,
                                      discountValueb: 0,
                                      discountValuec: 0,
                                      discountValued: 0,
                                      status: true)));
                  } else if (state is AccommodationPriceCreateError) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(state.message),
                    ));
                  }
                },
                builder: (context, state) {
                  if (state is AccommodationPriceCreateLoading) {
                    Center(child: CircularProgressIndicator());
                  }
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 12.0, bottom: 12.0, top: 12.0),
                        child: Text(
                          "Empieza a utilizar TomateBnB, es muy sencillo",
                          style: TextStyle(
                              fontSize: 20,
                              color: notifire.getwhiteblackcolor,
                              fontFamily: "Gilroy Bold"),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          itemCount: 3,
                          itemBuilder: (BuildContext context, int index) {
                            return Column(
                              children: [
                                Row(
                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  // crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 12.0),
                                      child: Text(
                                          instructions1[index]["order"]
                                              .toString(),
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontFamily: "Gilroy Bold",
                                            color: notifire.getwhiteblackcolor,
                                          )),
                                    ),
                                    const SizedBox(width: 12),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.70,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8),
                                                child: SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.61,
                                                  child: Text(
                                                    instructions1[index]
                                                            ["title"]
                                                        .toString(),
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      fontFamily: "Gilroy Bold",
                                                      color: notifire
                                                          .getwhiteblackcolor,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Spacer(),
                                            ],
                                          ),
                                        ),
                                       
                                        SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.10,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.65,
                                          child: Text(
                                              instructions1[index]["subtitle"]
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: greyColor,
                                                  fontFamily: "Gilroy Medium")),
                                        ),
                                      ],
                                    ),
                                    CircleAvatar(
                                      backgroundColor: WhiteColor,
                                      backgroundImage: AssetImage(
                                          instructions1[index]["img"]
                                              .toString()),
                                      radius: 25,
                                    ),
                                  ],
                                ),
                                Divider(
                                  color: greyColor,
                                )
                              ],
                            );
                          },
                        ),
                      ),
                      BlocConsumer<AccommodationBloc, AccommodationState>(
                          builder: (context, state) {
                        if (state is AccommodationCreateLoading) {
                          return Center(
                              child: const CircularProgressIndicator());
                        }
                        return Padding(
                            padding: EdgeInsets.all(12.0),
                            child: AppButton(
                              buttontext: "Empezar",
                              onclick: () {
                                context
                                    .read<AccommodationBloc>()
                                    .add(AccommodationCreateEvent());
                                //  context.push('/describe',
                                //         extra: 147);
                              },
                              context: context
                            ));
                      }, listener: (context, state) {
                        if (state is AccommodationCreateSuccess) {
                          accommodationResponseModel =
                              state.responseAccommodation;
                          context.read<AccommodationPriceBloc>().add(
                              AccommodationPriceCreateEvent(
                                  AccommodationPriceRequestModel(
                                      accommodationId:
                                          accommodationResponseModel.id ?? 0,
                                      priceNight: 0,
                                      priceWeekend: 0,
                                      type: 'normal',
                                      status: true)));
                        } else if (state is AccommodationCreateError) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(state.message),
                            backgroundColor: Colors.red,
                          ));
                        }
                      }),
                    ],
                  );
                },
              ),
            );
          },
        ),
        appBar: AppBar(
          leading: BackButton(
            color: notifire.getwhiteblackcolor,
          ),
          actions: [],
          elevation: 0,
          backgroundColor: notifire.getbgcolor,
          centerTitle: true,
        ));
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
