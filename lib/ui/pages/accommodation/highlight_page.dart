import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tomatebnb/bloc/export_blocs.dart';
import 'package:tomatebnb/models/accommodation/accommodation_request_model.dart';
import 'package:tomatebnb/models/accommodation/accommodation_response_model.dart';

import 'package:tomatebnb/models/service_response_model.dart';
import 'package:tomatebnb/utils/Colors.dart';
import 'package:tomatebnb/utils/customwidget.dart';
import 'package:tomatebnb/utils/dark_lightmode.dart';

class HighlightPage extends StatefulWidget {
  const HighlightPage({super.key});

  @override
  State<HighlightPage> createState() => _HighlightPageState();
}

class _HighlightPageState extends State<HighlightPage> {
  @override
  void initState() {
    _pageController = PageController(initialPage: _currentPage);
    getdarkmodepreviousstate();
    super.initState();
    context.read<ServiceBloc>().add(ServiceGetEvent());

    accommodationRequestModel = AccommodationRequestModel();
    accommodationResponseModel = AccommodationResponseModel();
  }

  late ColorNotifire notifire;
  PageController _pageController = PageController();
  int _currentPage = 0;
  int? _accommodationId;
  List<ServiceResponseModel> services = [];

  static const List<String> _titles = [
    'Haz que tu espacion se destaque',
    'Cuentale a tus huéspedes todo lo que tu espacio tiene para ofrecer',
    'Agrega algunas fotos de tu alojamiento',
    'Ponle Título a tu alojamiento',
    'Vamos a describir tu alojamiento, elije hasta dos aspectos que lo distingan',
    'Crea tu descripción',
  ];
  List<bool> selectedServices = [];

  late AccommodationRequestModel? accommodationRequestModel;
  late AccommodationResponseModel? accommodationResponseModel;

  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    _accommodationId = GoRouterState.of(context).extra! as int;
    context
        .read<AccommodationBloc>()
        .add(AccommodationGetByIdEvent(_accommodationId ?? 0));
    return Scaffold(
      backgroundColor: WhiteColor,
      body: Stack(
        children: <Widget>[
          PageView(
            controller: _pageController,
            onPageChanged: _handlingOnPageChanged,
            physics: const BouncingScrollPhysics(),
            children: [
              BlocConsumer<AccommodationBloc, AccommodationState>(
                listener: (context, state) {
                  if (state is AccommodationGetByIdSuccess) {
                    accommodationResponseModel = state.responseAccommodation;
                    accommodationRequestModel =
                        accommodationResponseModel?.toRequestModel();
                  }
                },
                builder: (context, state) {
                  if (state is AccommodationGetByIdLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is AccommodationGetByIdError) {
                    return Center(
                      child: Text(state.message),
                    );
                  }
                  return _buildPage1();
                },
              ),
              _buildPage2(),
              _buildPage3(),
              _buildPage4(),
              _buildPage5()
            ],
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).size.height *
                      0.06, //indicator set screen
                ),
                _buildDots(index: _currentPage),
                SizedBox(
                  height: MediaQuery.of(context).size.height *
                      0.012, //indicator set screen
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 10.0,
                        width: MediaQuery.of(context).size.width * 0.22,
                        child: Container(
                            margin: EdgeInsetsDirectional.only(
                                start: 1.0, end: 10.0),
                            height: 5.0,
                            color: Colors.grey),
                      ),
                      SizedBox(
                        height: 10.0,
                        width: MediaQuery.of(context).size.width * 0.22,
                        child: Container(
                            margin: EdgeInsetsDirectional.only(
                                start: 1.0, end: 10.0),
                            height: 5.0,
                            color: Colors.black),
                      ),
                      SizedBox(
                        height: 10.0,
                        width: MediaQuery.of(context).size.width * 0.22,
                        child: Container(
                            margin: EdgeInsetsDirectional.only(
                                start: 1.0, end: 10.0),
                            height: 5.0,
                            color: Colors.grey),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDots({
    int? index,
  }) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int i = 0; i < 5; i++)
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    // borderRadius: const BorderRadius.all(
                    //   Radius.circular(50),
                    // ),
                    // color: Color(0xFF000000),
                    color: _currentPage == i ? Darkblue : greyColor,
                  ),
                  margin: const EdgeInsets.only(right: 8),
                  curve: Curves.easeIn,
                  width: _currentPage == i ? 12 : 8,
                  height: _currentPage == i ? 12 : 8,
                )
            ],
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.02,
        ),
      ],
    );
  }

  // handling the on page changed
  void _handlingOnPageChanged(int page) {
    setState(() => _currentPage = page);
  }

  Widget _buildPage1() {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    return SafeArea(
      child: Scaffold(
        backgroundColor: notifire.getbgcolor,
        body: Column(
          children: <Widget>[
            SizedBox(
                height: MediaQuery.of(context).size.height *
                    0.02), //upar thi jagiya mukeli che
            // ignore: sized_box_for_whitespace
            Container(
              height: MediaQuery.of(context).size.height / 1.9, //imagee size
              width: MediaQuery.of(context).size.width,
              child: Image.asset("assets/images/onbording12.png"),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(),
              child: Text(
                _titles[_currentPage],
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 24,
                    fontFamily: "Gilroy Bold",
                    color: notifire.getwhiteblackcolor), //heding Text
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Text(
                "En este paso agregarás algunos de los servicios que ofrece tu alojamiento y subiras un mínimo de 5 fotos luego crearas un título y una descripción ",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 15,
                    color: notifire.getgreycolor,
                    fontFamily: "Gilroy Medium"), //subtext
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: GestureDetector(
                      onTap: () {
                        context.pop();
                        //  _pageController.previousPage(
                        //             duration: const Duration(microseconds: 300),
                        //             curve: Curves.easeIn);
                      },
                      child: Text(
                        "Atras",
                        style: TextStyle(
                            fontSize: 18,
                            color: Darkblue,
                            fontFamily: "Gilroy Bold"),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: GestureDetector(
                    onTap: () {
                      _pageController.nextPage(
                          duration: const Duration(microseconds: 300),
                          curve: Curves.easeIn);
                    },
                    child: Container(
                        decoration: BoxDecoration(
                            color: Darkblue,
                            borderRadius: BorderRadius.circular(50)),
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: Center(
                          child: Text(
                            "Siguiente",
                            style: TextStyle(
                                fontSize: 16,
                                color: WhiteColor,
                                fontFamily: "Gilroy Bold"),
                          ),
                        )),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPage2() {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    return SafeArea(
      child: Scaffold(
        backgroundColor: notifire.getbgcolor,
        body: Column(
          children: <Widget>[
            SizedBox(
                height: MediaQuery.of(context).size.height *
                    0.02), //upar thi jagiya mukeli che
            // ignore: sized_box_for_whitespace

            Padding(
              padding: const EdgeInsets.symmetric(),
              child: Text(
                _titles[_currentPage],
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 24,
                    fontFamily: "Gilroy Bold",
                    color: notifire.getwhiteblackcolor), //heding Text
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: SizedBox(
                  child: BlocBuilder<ServiceBloc, ServiceState>(
                    builder: (context, state) {
                      if (state is ServiceGetLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (state is ServiceGetError) {
                        return Center(
                          child: Text(state.message),
                        );
                      }
                      if (state is ServiceGetSuccess) {
                        services = state.responseServices;
                        for (int i = 0; i < services.length; i++) {
                          selectedServices.add(false);
                        }
                      }
                      return SizedBox(
                        height: MediaQuery.of(context).size.height * 0.63,
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 15,
                            mainAxisSpacing: 10,
                            childAspectRatio: 1.2,
                          ),
                          // physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          itemCount: services.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 6),
                                child: BlocListener<AccommodationServiceBloc, AccommodationServiceState>(
                                    listener: (context, state) {
                                        // TODO: implement listener
                                        if (state is AccommodationServiceCreateSuccess) {
                                          if(state.responseAccommodationService.serviceId==services[index].id)
                                          {
                                            selectedServices[index]=true;
                                            setState(() {});
                                          }
                                          // _pageController.nextPage(
                                          //     duration: const Duration(microseconds: 300),
                                          //     curve: Curves.easeIn);
                                        } else if (state is AccommodationServiceDeleteSuccess) {
                                          if(state.responseAccommodationService.serviceId ==services[index].id){
                                          selectedServices[index]=false;
                                          setState(() {});}
                                        }else if (state is AccommodationServiceCreateError){
                                           ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                              content: Text(state.message ),
                                            ));
                                        } else if (state is AccommodationServiceDeleteError){
                                           ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                              content: Text(state.message),
                                            ));
                                        }
                                      
                                      },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: notifire.getdarkmodecolor),
                                    child: Column(
                                      children: [
                                        ListTile(
                                          onTap: () {
                                            if(!selectedServices[index]){
                                            context.read<AccommodationServiceBloc>().add(
                                            AccommodationServiceCreateEvent(
                                              _accommodationId ?? 0,
                                              services[index].id));
                                            }else{
                                              context.read<AccommodationServiceBloc>().add(
                                            AccommodationServiceDeleteEvent(
                                              _accommodationId ?? 0,
                                              services[index].id));
                                            }
                                              // selectedServices[index] =
                                            //     !selectedServices[index];
                                            // setState(() {});
                                          },
                                          // leading: Image.asset(
                                          //     "assets/images/home-2.png",
                                          //     height: 35),
                                          trailing: selectedServices[index]
                                              // || accommodationResponseModel?.describeId == describes[index].id
                                              ? Icon(Icons.check_circle,
                                                  color:
                                                      notifire.getdarkbluecolor)
                                              : SizedBox.shrink(),

                                          title: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 12.0),
                                            child: Icon(Icons.bed),
                                          ),
                                          subtitle: Text(
                                            services[index].name,
                                            style: TextStyle(
                                                fontFamily: "Gilroy Bold",
                                                fontSize: 16,
                                                color: notifire
                                                    .getwhiteblackcolor),
                                          ),
                                          // isThreeLine: true,
                                        ),
                                      ],
                                    ),
                                  ),
                                ));
                          },
                        ),
                      );
                    },
                  ),
                )),
            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: GestureDetector(
                      onTap: () {
                        // context.pop();
                        _pageController.previousPage(
                            duration: const Duration(microseconds: 300),
                            curve: Curves.easeIn);
                      },
                      child: Text(
                        "Atras",
                        style: TextStyle(
                            fontSize: 18,
                            color: Darkblue,
                            fontFamily: "Gilroy Bold"),
                      )),
                ),
                BlocBuilder<AccommodationServiceBloc,
                    AccommodationServiceState>(
                  builder: (context, state) {
                    if (state is AccommodationServiceCreateLoading) {
                      return Center(child: const CircularProgressIndicator());
                    }

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: GestureDetector(
                        onTap: () {
                                // context.read<AccommodationBloc>().add(
                                //     AccommodationUpdateEvent(
                                //         _accommodationId ?? 0,
                                //         accommodationRequestModel!));
                                _pageController.nextPage(
                                duration: const Duration(microseconds: 300),
                                curve: Curves.easeIn);
                              },
                        child: Container(
                            decoration: BoxDecoration(
                                color: Darkblue,
                                borderRadius: BorderRadius.circular(50)),
                            height: 50,
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: Center(
                              child: Text(
                                "Siguiente",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: WhiteColor,
                                    fontFamily: "Gilroy Bold"),
                              ),
                            )),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPage3() {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    return SafeArea(
      child: Scaffold(
        backgroundColor: notifire.getbgcolor,
        body: Column(
          children: <Widget>[
            SizedBox(
                height: MediaQuery.of(context).size.height *
                    0.02), //upar thi jagiya mukeli che
            // ignore: sized_box_for_whitespace

            Padding(
              padding: const EdgeInsets.symmetric(),
              child: Text(
                _titles[_currentPage],
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 24,
                    fontFamily: "Gilroy Bold",
                    color: notifire.getwhiteblackcolor), //heding Text
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: SizedBox(
                  child: BlocBuilder<AccommodationTypeBloc,
                      AccommodationTypeState>(
                    builder: (context, state) {
                      if (state is AccommodationTypeGetLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (state is AccommodationTypeGetError) {
                        return Center(
                          child: Text(state.message),
                        );
                      }
                      // if (state is AccommodationTypeGetSuccess) {
                      //   accommodationTypes = state.responseAccommodationTypes;
                      //   for (int i = 0; i < accommodationTypes.length; i++) {
                      //     selectedTypes.add(false);
                      //   }
                      // }
                      return SizedBox(
                        height: MediaQuery.of(context).size.height * 0.63,
                        child: ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          itemCount: 0,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 6),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: notifire.getdarkmodecolor),
                                  child: Column(
                                    children: [
                                      ListTile(
                                          onTap: () {
                                            setState(() {});
                                          },
                                          // leading: Image.asset(
                                          //     "assets/images/home-2.png",
                                          //     height: 35),
                                          trailing: true
                                              ? Icon(Icons.check_circle,
                                                  color:
                                                      notifire.getdarkbluecolor)
                                              : SizedBox.shrink(),
                                          leading: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 12.0),
                                            child: Icon(Icons.holiday_village),
                                          ),
                                          title: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 12.0),
                                            child: Text(
                                              // accommodationTypes[index].name,
                                              "aun",
                                              style: TextStyle(
                                                  fontFamily: "Gilroy Bold",
                                                  fontSize: 16,
                                                  color: notifire
                                                      .getwhiteblackcolor),
                                            ),
                                          ),
                                          subtitle: Padding(
                                            padding:
                                                const EdgeInsets.only(top: 8),
                                            child: SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.61,
                                                child: Text('descripción',
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        color: greyColor,
                                                        fontFamily:
                                                            "Gilroy Medium"))),
                                          )
                                          // isThreeLine: true,
                                          ),
                                    ],
                                  ),
                                ));
                          },
                        ),
                      );
                    },
                  ),
                )),
            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: GestureDetector(
                      onTap: () {
                        // context.pop();
                        _pageController.previousPage(
                            duration: const Duration(microseconds: 300),
                            curve: Curves.easeIn);
                      },
                      child: Text(
                        "Atras",
                        style: TextStyle(
                            fontSize: 18,
                            color: Darkblue,
                            fontFamily: "Gilroy Bold"),
                      )),
                ),
                BlocConsumer<AccommodationBloc, AccommodationState>(
                  listener: (context, state) {
                    // TODO: implement listener
                    if (state is AccommodationUpdateSuccess) {
                      _pageController.nextPage(
                          duration: const Duration(microseconds: 300),
                          curve: Curves.easeIn);
                      accommodationResponseModel?.typeId =
                          accommodationRequestModel?.typeId;
                    } else if (state is AccommodationUpdateError) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(state.message),
                      ));
                    }
                  },
                  builder: (context, state) {
                    if (state is AccommodationUpdateLoading) {
                      return Center(child: const CircularProgressIndicator());
                    }
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: GestureDetector(
                        onTap: accommodationRequestModel?.typeId == null
                            ? null
                            : () {
                                context.read<AccommodationBloc>().add(
                                    AccommodationUpdateEvent(
                                        _accommodationId ?? 0,
                                        accommodationRequestModel!));
                              },
                        child: Container(
                            decoration: BoxDecoration(
                                color: Darkblue,
                                borderRadius: BorderRadius.circular(50)),
                            height: 50,
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: Center(
                              child: Text(
                                "Siguiente",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: WhiteColor,
                                    fontFamily: "Gilroy Bold"),
                              ),
                            )),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPage4() {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    return SafeArea(
      child: Scaffold(
        backgroundColor: notifire.getbgcolor,
        body: Column(
          children: <Widget>[
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            Padding(
              padding: const EdgeInsets.symmetric(),
              child: Text(
                _titles[_currentPage],
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 24,
                    fontFamily: "Gilroy Bold",
                    color: notifire.getwhiteblackcolor), //heding Text
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            Padding(
              padding: EdgeInsets.all(12.0),
              child: AppButton(
                  buttontext: "Ingresa tu direccón", onclick: bottomsheet),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            BlocConsumer<LocalizationBloc, LocalizationState>(
              listener: (context, state) {
                if (state is LocalizationGetSuccess) {
                  accommodationRequestModel?.latitude = state.latitude;
                  accommodationRequestModel?.longitude = state.longitude;
                } else if (state is LocalizationGetError) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(state.message),
                    backgroundColor: Colors.red[800],
                  ));
                }
              },
              builder: (context, state) {
                if (state is LocalizationGetLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          context
                              .read<LocalizationBloc>()
                              .add(LocalizationGetEvent());
                        },
                        child: Container(
                            decoration: BoxDecoration(
                                color: Darkblue,
                                borderRadius: BorderRadius.circular(50)),
                            height: 50,
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: Center(
                              child: Text(
                                "Obtener mi ubicación",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: WhiteColor,
                                    fontFamily: "Gilroy Bold"),
                              ),
                            )),
                      ),
                      accommodationRequestModel?.latitude != null &&
                              accommodationRequestModel?.longitude != null
                          ? Icon(Icons.check_circle_outlined, color: Darkblue)
                          : Icon(Icons.circle_outlined, color: Colors.grey)
                    ],
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.50,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: GestureDetector(
                      onTap: () {
                        // context.pop();
                        _pageController.previousPage(
                            duration: const Duration(microseconds: 300),
                            curve: Curves.easeIn);
                      },
                      child: Text(
                        "Atras",
                        style: TextStyle(
                            fontSize: 18,
                            color: Darkblue,
                            fontFamily: "Gilroy Bold"),
                      )),
                ),
                BlocConsumer<AccommodationBloc, AccommodationState>(
                  listener: (context, state) {
                    if (state is AccommodationUpdateSuccess) {
                      accommodationResponseModel?.address =
                          accommodationRequestModel?.address;
                      accommodationResponseModel?.city =
                          accommodationRequestModel?.city;
                      accommodationResponseModel?.country =
                          accommodationRequestModel?.country;
                      accommodationResponseModel?.latitude =
                          accommodationRequestModel?.latitude;
                      accommodationResponseModel?.longitude =
                          accommodationRequestModel?.longitude;
                      _pageController.nextPage(
                          duration: const Duration(microseconds: 300),
                          curve: Curves.easeIn);
                      accommodationResponseModel?.typeId =
                          accommodationRequestModel?.typeId;
                    } else if (state is AccommodationUpdateError) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(state.message),
                      ));
                    }
                  },
                  builder: (context, state) {
                    if (state is AccommodationUpdateLoading) {
                      return Center(child: const CircularProgressIndicator());
                    }
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: GestureDetector(
                        // onTap: adressController.text.isEmpty ||
                        //         cityController.text.isEmpty ||
                        //         countryController.text.isEmpty
                        //     ? null
                        //     : () {
                        //         accommodationRequestModel?.address =
                        //             adressController.text;
                        //         accommodationRequestModel?.city =
                        //             cityController.text;
                        //         accommodationRequestModel?.country =
                        //             countryController.text;

                        //         context.read<AccommodationBloc>().add(
                        //             AccommodationUpdateEvent(
                        //                 _accommodationId ?? 0,
                        //                 accommodationRequestModel!));
                        // },
                        child: Container(
                            decoration: BoxDecoration(
                                color: Darkblue,
                                borderRadius: BorderRadius.circular(50)),
                            height: 50,
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: Center(
                              child: Text(
                                "Siguiente",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: WhiteColor,
                                    fontFamily: "Gilroy Bold"),
                              ),
                            )),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPage5() {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    return SafeArea(
      child: Scaffold(
        backgroundColor: notifire.getbgcolor,
        body: Column(
          children: <Widget>[
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            Padding(
              padding: const EdgeInsets.symmetric(),
              child: Text(
                _titles[_currentPage],
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 24,
                    fontFamily: "Gilroy Bold",
                    color: notifire.getwhiteblackcolor), //heding Text
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.50,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 8),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.025),
                        room(
                            text: "Cantidad de Huespedes",
                            titletext: "Minimum contains 4 people",
                            onclick1: () {
                              setState(() {
                                // _guestCounter--;
                              });
                            },
                            middeltext: "guestCounter",
                            onclick2: () {
                              setState(() {
                                // _guestCounter++;
                              });
                            }),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.025),
                        room(
                            text: "Cantidad de recamaras",
                            titletext: " ",
                            onclick1: () {
                              setState(() {
                                // _roomCounter--;
                              });
                            },
                            middeltext: "roomCounter",
                            onclick2: () {
                              setState(() {
                                // _roomCounter++;
                              });
                            }),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.025),
                        room(
                            text: "Cantidad de baños",
                            titletext: "",
                            onclick1: () {
                              setState(() {
                                // _bathCounter--;
                              });
                            },
                            middeltext: "bathCounter",
                            onclick2: () {
                              setState(() {
                                // _bathCounter++;
                              });
                            }),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.025),
                        room(
                            text: "Cantidad de camas",
                            titletext: "",
                            onclick1: () {
                              setState(() {
                                // _bedsCounter--;
                              });
                            },
                             middeltext: "bedsCounter",
                            onclick2: () {
                              setState(() {
                                // _bedsCounter++;
                              });
                            }),
                      ],
                    ),
                  ),
                )),
            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: GestureDetector(
                      onTap: () {
                        // context.pop();
                        _pageController.previousPage(
                            duration: const Duration(microseconds: 300),
                            curve: Curves.easeIn);
                      },
                      child: Text(
                        "Atras",
                        style: TextStyle(
                            fontSize: 18,
                            color: Darkblue,
                            fontFamily: "Gilroy Bold"),
                      )),
                ),
                BlocConsumer<AccommodationBloc, AccommodationState>(
                  listener: (context, state) {
                    if (state is AccommodationUpdateSuccess) {
                      accommodationResponseModel?.guestCapacity =
                          accommodationRequestModel?.guestCapacity;
                      accommodationResponseModel?.numberRooms =
                          accommodationRequestModel?.numberRooms;
                      accommodationResponseModel?.numberBathrooms =
                          accommodationRequestModel?.numberBathrooms;
                      accommodationResponseModel?.numberBeds =
                          accommodationRequestModel?.numberBeds;
                      _pageController.nextPage(
                          duration: const Duration(microseconds: 300),
                          curve: Curves.easeIn);
                    } else if (state is AccommodationUpdateError) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(state.message),
                      ));
                    }
                  },
                  builder: (context, state) {
                    if (state is AccommodationUpdateLoading) {
                      return Center(child: const CircularProgressIndicator());
                    }
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: GestureDetector(
                        // onTap: _guestCounter < 1 ||
                        //        _roomCounter < 1 ||
                        //        _bathCounter < 1 ||
                        //        _bedsCounter < 1
                        //     ? null
                        //     : () {
                        //         accommodationRequestModel?.guestCapacity = _guestCounter;
                        //         accommodationRequestModel?.numberRooms = _roomCounter;
                        //         accommodationRequestModel?.numberBathrooms = _bathCounter;
                        //         accommodationRequestModel?.numberBeds = _bedsCounter;
                        //         context.read<AccommodationBloc>().add(
                        //             AccommodationUpdateEvent(
                        //                 _accommodationId ?? 0,
                        //                 accommodationRequestModel!));
                        //       },
                        child: Container(
                            decoration: BoxDecoration(
                                color: Darkblue,
                                borderRadius: BorderRadius.circular(50)),
                            height: 50,
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: Center(
                              child: Text(
                                "Siguiente",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: WhiteColor,
                                    fontFamily: "Gilroy Bold"),
                              ),
                            )),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  bottomsheet() {
    return showModalBottomSheet(
        backgroundColor: notifire.getbgcolor,
        isScrollControlled: true,
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.90,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Datos de dirección ",
                          style: TextStyle(
                              fontSize: 18,
                              fontFamily: "Gilroy Bold",
                              color: notifire.getwhiteblackcolor),
                        ),
                        InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Icon(
                              Icons.close,
                              color: notifire.getwhiteblackcolor,
                            ))
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                    Text(
                      "Direccón",
                      style: TextStyle(
                          fontSize: 16,
                          color: notifire.getwhiteblackcolor,
                          fontFamily: "Gilroy Bold"),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: notifire.getdarkmodecolor),
                      child: TextField(
                        // controller: adressController,
                        decoration: InputDecoration(
                          hintText:
                              "Calle, Avenida, Nro.  Zona/ Barrio Piso dpto.",
                          hintStyle: TextStyle(
                            color: notifire.getgreycolor,
                            fontFamily: "Gilroy Medium",
                          ),
                          suffixIcon: Padding(
                            padding: const EdgeInsets.all(6),
                            child: Icon(
                              Icons.keyboard_arrow_down,
                              color: Darkblue,
                            ),
                          ),
                          border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color(0xffE2E4EA),
                              ),
                              borderRadius: BorderRadius.circular(15)),
                        ),
                      ),
                    ),
                    Divider(color: notifire.getgreycolor),
                    Text(
                      "Ciudad",
                      style: TextStyle(
                          fontSize: 16,
                          color: notifire.getwhiteblackcolor,
                          fontFamily: "Gilroy Bold"),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: notifire.getdarkmodecolor),
                      child: TextField(
                        // controller: cityController,
                        decoration: InputDecoration(
                          hintText: "La Paz, Santa Cruz, Montero.....",
                          hintStyle: TextStyle(
                            color: notifire.getgreycolor,
                            fontFamily: "Gilroy Medium",
                          ),
                          suffixIcon: Padding(
                            padding: const EdgeInsets.all(6),
                            child: Icon(
                              Icons.keyboard_arrow_down,
                              color: Darkblue,
                            ),
                          ),
                          border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color(0xffE2E4EA),
                              ),
                              borderRadius: BorderRadius.circular(15)),
                        ),
                      ),
                    ),
                    Divider(color: notifire.getgreycolor),
                    const SizedBox(height: 4),
                    Text(
                      "País",
                      style: TextStyle(
                          fontSize: 16,
                          color: notifire.getwhiteblackcolor,
                          fontFamily: "Gilroy Bold"),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: notifire.getdarkmodecolor),
                      child: TextField(
                        // controller: countryController,
                        decoration: InputDecoration(
                          hintText: "Bolivia .....",
                          hintStyle: TextStyle(
                            color: notifire.getgreycolor,
                            fontFamily: "Gilroy Medium",
                          ),
                          suffixIcon: Padding(
                            padding: const EdgeInsets.all(6),
                            child: Icon(
                              Icons.keyboard_arrow_down,
                              color: Darkblue,
                            ),
                          ),
                          border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color(0xffE2E4EA),
                              ),
                              borderRadius: BorderRadius.circular(15)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Divider(color: notifire.getgreycolor),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: GestureDetector(
                        onTap: null,
                        child: Container(
                            decoration: BoxDecoration(
                                color: Darkblue,
                                borderRadius: BorderRadius.circular(50)),
                            height: 50,
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: Center(
                              child: Text(
                                "Aceptar",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: WhiteColor,
                                    fontFamily: "Gilroy Bold"),
                              ),
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            );
          });
        });
  }

  room({text, titletext, onclick1, onclick2, middeltext}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(text,
                style: TextStyle(
                    fontSize: 16,
                    color: notifire.getwhiteblackcolor,
                    fontFamily: "Gilroy Bold")),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                children: [
                  InkWell(
                    onTap: onclick1,
                    child: CircleAvatar(
                      backgroundColor: notifire.getblackgreycolor,
                      radius: 12,
                      child: Icon(Icons.remove,
                          color: notifire.getdarkwhitecolor, size: 20),
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    'middeltext',
                    style: TextStyle(color: notifire.getwhiteblackcolor),
                  ),
                  const SizedBox(width: 5),
                  InkWell(
                    onTap: onclick2,
                    child: CircleAvatar(
                      backgroundColor: notifire.getdarkbluecolor,
                      radius: 12,
                      child: Icon(Icons.add,
                          color: notifire.getdarkwhitecolor, size: 20),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        Text(
          titletext,
          style: TextStyle(
              fontSize: 14,
              color: notifire.getgreycolor,
              fontFamily: "Gilroy Medium"),
        ),
      ],
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
