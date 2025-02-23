import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tomatebnb/bloc/export_blocs.dart';
import 'package:tomatebnb/models/accommodation/accommodation_discount_request_model.dart';
import 'package:tomatebnb/models/accommodation/accommodation_discount_response_model.dart';
import 'package:tomatebnb/models/accommodation/accommodation_price_request_model.dart';
import 'package:tomatebnb/models/accommodation/accommodation_price_response_model.dart';
import 'package:tomatebnb/models/accommodation/accommodation_request_model.dart';
import 'package:tomatebnb/models/accommodation/accommodation_response_model.dart';

import 'package:tomatebnb/utils/Colors.dart';
import 'package:tomatebnb/utils/dark_lightmode.dart';

class PricesPage extends StatefulWidget {
  const PricesPage({super.key});

  @override
  State<PricesPage> createState() => _PricesPageState();
}

class _PricesPageState extends State<PricesPage> {
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
  late AccommodationPriceResponseModel accommodationPriceResponseModel;
  late AccommodationDiscountResponseModel accommodationDiscountResponseModel;
  final _priceController = TextEditingController();
  final _priceWeekendController = TextEditingController();
  static const List<Map<String, String>> _titles = [
    {
      'title': 'Terminar y publicar',
      'subtitle':
          'Por último tendras que definir tus preferencias, establecer los precios y terminar el anuncio'
    },
    {
      'title': 'Establece un precio normal',
      'subtitle': 'Puedes cambiar este precio en el futuro'
    },
    {
      'title': 'Ahora establece un precio de fin de semana',
      'subtitle': 'Puede variar segun la disponibilidad'
    },
    {
      'title': 'Agrega descuentos',
      'subtitle':
          'Destaca tu alojamiento para para conseguir reservaciones más rápido y obtener tus primeras evaluaciones'
    },
    {
      'title': 'Revisa tu anuncio',
      'subtitle':
          'Esto es lo que verán los huespedes, asegurate que todo luzca bien'
    }
  ];
  List<bool> selectedServices = [];

  late AccommodationRequestModel? accommodationRequestModel;
  late AccommodationResponseModel? accommodationResponseModel;

  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    _accommodationId = GoRouterState.of(context).extra! as int;
    context.read<AccommodationDiscountBloc>().add(
                        AccommodationDiscountGetByAccommodationEvent(
                            _accommodationId ?? 0));
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
            // physics: const BouncingScrollPhysics(),
            physics: const NeverScrollableScrollPhysics(),
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
                    color: _currentPage == i ? Theme.of(context).colorScheme.primary : greyColor,
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
              child: Image.asset("assets/images/onbording13.png"),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(),
              child: Text(
                _titles[_currentPage]['title'] ?? '',
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
                _titles[_currentPage]['subtitle'] ?? '',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 15,
                    color: Theme.of(context).colorScheme.primary,
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
                            color: Theme.of(context).colorScheme.primary,
                            fontFamily: "Gilroy Bold"),
                      )),
                ),
                BlocConsumer<AccommodationPriceBloc, AccommodationPriceState>(
                  listener: (context, state) {
                    if (state is AccommodationPriceGetByAccommodationSuccess) {
                      accommodationPriceResponseModel =
                          state.responseAccommodationPrices.first;
                      _pageController.nextPage(
                          duration: const Duration(microseconds: 300),
                          curve: Curves.easeIn);
                    } else if (state
                        is AccommodationPriceGetByAccommodationError) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(state.message),
                      ));
                    }
                  },
                  builder: (context, state) {
                    if (state is AccommodationPriceGetByAccommodationLoading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: GestureDetector(
                        onTap: () {
                          // _pageController.nextPage(
                          //     duration: const Duration(microseconds: 300),
                          //     curve: Curves.easeIn);
                          context.read<AccommodationPriceBloc>().add(
                              AccommodationPriceGetByAccommodationEvent(
                                  _accommodationId ?? 0));
                        },
                        child: Container(
                            decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.primary,
                                borderRadius: BorderRadius.circular(25)),
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
                _titles[_currentPage]['title'] ?? '',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 24,
                    fontFamily: "Gilroy Bold",
                    color: notifire.getwhiteblackcolor), //heding Text
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            Padding(
              padding: const EdgeInsets.symmetric(),
              child: Text(
                _titles[_currentPage]['subtitle'] ?? '',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 14,
                    fontFamily: "Gilroy Bold",
                    color: notifire.getblackgreycolor), //heding Text
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            Container(
              height: MediaQuery.of(context).size.height * 0.50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: notifire.getdarkmodecolor),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _priceController,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 50),
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      prefixText: 'Bs.',
                      hintText: "0",
                      hintStyle: TextStyle(
                        fontSize: 50.0,
                        color: Theme.of(context).colorScheme.primary,
                        fontFamily: "Gilroy Medium",
                      ),
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color(0xffE2E4EA),
                          ),
                          borderRadius: BorderRadius.circular(15)),
                    ),
                  ),
                ),
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
                            color: Theme.of(context).colorScheme.primary,
                            fontFamily: "Gilroy Bold"),
                      )),
                ),
                BlocConsumer<AccommodationPriceBloc, AccommodationPriceState>(
                  listener: (context, state) {
                    if (state is AccommodationPriceUpdateSuccess) {
                      accommodationPriceResponseModel.priceNight =
                          double.parse(_priceController.text);
                      _pageController.nextPage(
                          duration: const Duration(microseconds: 300),
                          curve: Curves.easeIn);
                    } else if (state is AccommodationPriceUpdateError) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(state.message)));
                    }
                  },
                  builder: (context, state) {
                    if (state is AccommodationPriceUpdateLoading) {
                      return Center(child: const CircularProgressIndicator());
                    }
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: GestureDetector(
                        onTap: () {
                          context.read<AccommodationPriceBloc>().add(
                              AccommodationPriceUpdateEvent(
                                  accommodationPriceResponseModel.id,
                                  AccommodationPriceRequestModel(
                                      accommodationId:
                                          accommodationPriceResponseModel
                                              .accommodationId,
                                      priceNight:
                                          double.parse(_priceController.text),
                                      priceWeekend:
                                          accommodationPriceResponseModel
                                              .priceWeekend,
                                      type:
                                          accommodationPriceResponseModel.type,
                                      status: accommodationPriceResponseModel
                                          .status)));
                        },
                        child: Container(
                            decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.primary,
                                borderRadius: BorderRadius.circular(25)),
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
                _titles[_currentPage]['title'] ?? '',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 24,
                    fontFamily: "Gilroy Bold",
                    color: notifire.getwhiteblackcolor), //heding Text
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            Padding(
              padding: const EdgeInsets.symmetric(),
              child: Text(
                _titles[_currentPage]['subtitle'] ?? '',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 14,
                    fontFamily: "Gilroy Bold",
                    color: notifire.getblackgreycolor), //heding Text
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            Container(
              height: MediaQuery.of(context).size.height * 0.50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: notifire.getdarkmodecolor),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _priceWeekendController,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.numberWithOptions(),
                    style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 50),
                    decoration: InputDecoration(
                      prefixText: 'Bs.',
                      hintText: "0",
                      hintStyle: TextStyle(
                        fontSize: 50.0,
                        color: Theme.of(context).colorScheme.primary,
                        fontFamily: "Gilroy Medium",
                      ),
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color(0xffE2E4EA),
                          ),
                          borderRadius: BorderRadius.circular(15)),
                    ),
                  ),
                ),
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
                            color: Theme.of(context).colorScheme.primary,
                            fontFamily: "Gilroy Bold"),
                      )),
                ),
                BlocConsumer<AccommodationPriceBloc, AccommodationPriceState>(
                  listener: (context, state) {
                    if (state is AccommodationPriceUpdateSuccess) {
                      accommodationPriceResponseModel.priceWeekend =
                          double.parse(_priceWeekendController.text);
                      _pageController.nextPage(
                          duration: const Duration(microseconds: 300),
                          curve: Curves.easeIn);
                    } else if (state is AccommodationPriceUpdateError) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(state.message)));
                    }
                  },
                  builder: (context, state) {
                    if (state is AccommodationPriceUpdateLoading) {
                      return Center(child: const CircularProgressIndicator());
                    }
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: GestureDetector(
                        onTap: () {
                          context.read<AccommodationPriceBloc>().add(
                              AccommodationPriceUpdateEvent(
                                  accommodationPriceResponseModel.id,
                                  AccommodationPriceRequestModel(
                                      accommodationId:
                                          accommodationPriceResponseModel
                                              .accommodationId,
                                      priceNight:
                                          accommodationPriceResponseModel
                                              .priceNight,
                                      priceWeekend: double.parse(
                                          _priceWeekendController.text),
                                      type:
                                          accommodationPriceResponseModel.type,
                                      status: accommodationPriceResponseModel
                                          .status)));
                        },
                        child: Container(
                            decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.primary,
                                borderRadius: BorderRadius.circular(25)),
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
                _titles[_currentPage]['title'] ?? '',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 24,
                    fontFamily: "Gilroy Bold",
                    color: notifire.getwhiteblackcolor), //heding Text
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            Padding(
              padding: const EdgeInsets.symmetric(),
              child: Text(
                _titles[_currentPage]['subtitle'] ?? '',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 14,
                    fontFamily: "Gilroy Bold",
                    color: notifire.getblackgreycolor), //heding Text
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            const SizedBox(height: 4),
            Container(
              height: MediaQuery.of(context).size.height * 0.50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: notifire.getdarkmodecolor),
              child: BlocConsumer<AccommodationDiscountBloc,
                  AccommodationDiscountState>(
                listener: (context, state) {
                  if (state is AccommodationDiscountGetByAccommodationSuccess) {
                    accommodationDiscountResponseModel =
                        state.responseAccommodationDiscounts.first;
                  } else if (state
                      is AccommodationDiscountGetByAccommodationError) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(state.message),
                    ));
                  }
                },
                builder: (context, state) {
                  if (state is AccommodationDiscountGetByAccommodationLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is AccommodationDiscountGetByAccommodationSuccess) {
                    accommodationDiscountResponseModel =
                        state.responseAccommodationDiscounts.first;
                  }
                  
                   
                    return ListView(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: notifire.getdarkmodecolor,
                              border: Border(
                                  bottom: BorderSide(
                                      color: notifire.getdarkbluecolor,
                                      width: 2.0),
                                  top: BorderSide(
                                      color: notifire.getdarkbluecolor,
                                      width: 2.0)),
                            ),
                            child: Column(
                              children: [
                                BlocConsumer<AccommodationDiscountBloc, AccommodationDiscountState>(
                                  listener: (context, state) {
                                    if (state is AccommodationDiscountUpdateSuccess) {
                                      accommodationDiscountResponseModel.discountValueb = 10.0;
                                      setState(() {});
                                    }else if(state is AccommodationDiscountUpdateError){
                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
                                    }

                                  },
                                  builder: (context, state) {
                                    if (state is AccommodationDiscountUpdateLoading) {
                                      return Center(child: CircularProgressIndicator(),);
                                    }
                                    return ListTile(
                                        onTap: () {
                                           context.read<AccommodationDiscountBloc>().add(
                              AccommodationDiscountUpdateEvent(
                                  accommodationDiscountResponseModel.id,
                                  AccommodationDiscountRequestModel(
                                      accommodationId: accommodationPriceResponseModel.accommodationId,
                                      discountValuea: 0,
                                      discountValueb:accommodationDiscountResponseModel.discountValueb>0?0:10,
                                      discountValuec:accommodationDiscountResponseModel.discountValuec,
                                      discountValued:accommodationDiscountResponseModel.discountValued,
                                      status:true
                                    )));
                                        },
                                        trailing:
                                            accommodationDiscountResponseModel
                                                        .discountValueb >
                                                    0
                                                ? Icon(Icons.check_circle,
                                                    color:
                                                        notifire
                                                            .getdarkbluecolor)
                                                : Icon(Icons.circle_outlined,
                                                    color: notifire
                                                        .getdarkbluecolor),
                                        leading: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 12.0),
                                          child: Text(
                                            '10%',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontSize: 30.0),
                                          ),
                                        ),
                                        title: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 12.0),
                                          child: Text(
                                            'Descuento por semana',
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
                                              child: Text('Para 7 noches o más',
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: greyColor,
                                                      fontFamily:
                                                          "Gilroy Medium"))),
                                        )
                                        // isThreeLine: true,
                                        );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.1,
                        ),
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: notifire.getdarkmodecolor,
                              border: Border(
                                  bottom: BorderSide(
                                      color: notifire.getdarkbluecolor,
                                      width: 2.0),
                                  top: BorderSide(
                                      color: notifire.getdarkbluecolor,
                                      width: 2.0)),
                            ),
                            child: Column(
                              children: [
                                BlocConsumer<AccommodationDiscountBloc, AccommodationDiscountState>(
                                  listener: (context, state) {
                                    if (state is AccommodationDiscountUpdateSuccess) {
                                      accommodationDiscountResponseModel.discountValuec = 20.0;
                                      setState((){});
                                    }else if(state is AccommodationDiscountUpdateError){
                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
                                    }

                                  },
                                  builder: (context, state) {
                                    if (state is AccommodationDiscountUpdateLoading) {
                                      return Center(child: CircularProgressIndicator(),);
                                    }
                                    return ListTile(
                                        onTap: () {
                                           context.read<AccommodationDiscountBloc>().add(
                              AccommodationDiscountUpdateEvent(
                                  accommodationDiscountResponseModel.id,
                                  AccommodationDiscountRequestModel(
                                      accommodationId: accommodationPriceResponseModel.accommodationId,
                                      discountValuea: 0,
                                      discountValueb:accommodationDiscountResponseModel.discountValueb,
                                      discountValuec:accommodationDiscountResponseModel.discountValuec>0?0:20,
                                      discountValued:accommodationDiscountResponseModel.discountValued,
                                      status: true
                                    )));
                                        },
                                        trailing:
                                            accommodationDiscountResponseModel
                                                        .discountValuec >
                                                    0
                                                ? Icon(Icons.check_circle,
                                                    color:
                                                        notifire
                                                            .getdarkbluecolor)
                                                : Icon(Icons.circle_outlined,
                                                    color: notifire
                                                        .getdarkbluecolor),
                                        leading: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 12.0),
                                          child: Text(
                                            '20%',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontSize: 30.0),
                                          ),
                                        ),
                                        title: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 12.0),
                                          child: Text(
                                            'Descuento mensual',
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
                                              child: Text('Para 28 noches o más',
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: greyColor,
                                                      fontFamily:
                                                          "Gilroy Medium"))),
                                        )
                                        // isThreeLine: true,
                                        );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ]
                    );
                  
                 
                },
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
                            color: Theme.of(context).colorScheme.primary,
                            fontFamily: "Gilroy Bold"),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: BlocConsumer<AccommodationBloc, AccommodationState>(
                    listener: (context, state) {
                      if (state is AccommodationUpdate2Success) {
                        _pageController.nextPage(
                            duration: const Duration(microseconds: 300),
                            curve: Curves.easeIn);
                      } else if (state is AccommodationUpdate2Error) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(state.message),
                        ));
                      }
                    },
                    builder: (context, state) {
                      if (state is AccommodationUpdate2Loading) {
                        return Center(child: const CircularProgressIndicator());
                      }
                      return GestureDetector(
                        onTap: () {
                              _pageController.nextPage(
                            duration: const Duration(microseconds: 300),
                            curve: Curves.easeIn);
                        },
                        child: Container(
                            decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.primary,
                                borderRadius: BorderRadius.circular(25)),
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
                      );
                    },
                  ),
                )
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
                _titles[_currentPage]['title'] ?? '',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 24,
                    fontFamily: "Gilroy Bold",
                    color: notifire.getwhiteblackcolor), //heding Text
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            Padding(
              padding: const EdgeInsets.symmetric(),
              child: Text(
                _titles[_currentPage]['subtitle'] ?? '',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 14,
                    fontFamily: "Gilroy Bold",
                    color: notifire.getblackgreycolor), //heding Text
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            const SizedBox(height: 4),
            Container(
              height: MediaQuery.of(context).size.height * 0.50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: notifire.getdarkmodecolor),
              child: TextField(
                minLines: 5,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                // controller: adressController,
                decoration: InputDecoration(
                  hintText: "Alojamiento espacioso.....",
                  hintStyle: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontFamily: "Gilroy Medium",
                  ),
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color(0xffE2E4EA),
                      ),
                      borderRadius: BorderRadius.circular(15)),
                ),
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
                            color: Theme.of(context).colorScheme.primary,
                            fontFamily: "Gilroy Bold"),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: BlocConsumer<AccommodationBloc, AccommodationState>(
                    listener: (context, state) {
                      if (state is AccommodationUpdate2Success) {
                        _pageController.nextPage(
                            duration: const Duration(microseconds: 300),
                            curve: Curves.easeIn);
                      } else if (state is AccommodationUpdate2Error) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(state.message),
                        ));
                      }
                    },
                    builder: (context, state) {
                      if (state is AccommodationUpdate2Loading) {
                        return Center(child: const CircularProgressIndicator());
                      }
                      return GestureDetector(
                        onTap: () {},
                        child: Container(
                            decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.primary,
                                borderRadius: BorderRadius.circular(25)),
                            height: 50,
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: Center(
                              child: Text(
                                "Finalizar",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: WhiteColor,
                                    fontFamily: "Gilroy Bold"),
                              ),
                            )),
                      );
                    },
                  ),
                )
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
                            color: Theme.of(context).colorScheme.primary,
                            fontFamily: "Gilroy Medium",
                          ),
                          suffixIcon: Padding(
                            padding: const EdgeInsets.all(6),
                            child: Icon(
                              Icons.keyboard_arrow_down,
                              color: Theme.of(context).colorScheme.primary,
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
                    Divider(color: Theme.of(context).colorScheme.primary),
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
                            color: Theme.of(context).colorScheme.primary,
                            fontFamily: "Gilroy Medium",
                          ),
                          suffixIcon: Padding(
                            padding: const EdgeInsets.all(6),
                            child: Icon(
                              Icons.keyboard_arrow_down,
                              color: Theme.of(context).colorScheme.primary,
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
                    Divider(color: Theme.of(context).colorScheme.primary),
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
                            color: Theme.of(context).colorScheme.primary,
                            fontFamily: "Gilroy Medium",
                          ),
                          suffixIcon: Padding(
                            padding: const EdgeInsets.all(6),
                            child: Icon(
                              Icons.keyboard_arrow_down,
                              color: Theme.of(context).colorScheme.primary,
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
                    Divider(color: Theme.of(context).colorScheme.primary),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: GestureDetector(
                        onTap: null,
                        child: Container(
                            decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.primary,
                                borderRadius: BorderRadius.circular(25)),
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
              color: Theme.of(context).colorScheme.primary,
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
