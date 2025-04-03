import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tomatebnb/bloc/export_blocs.dart';
import 'package:tomatebnb/models/accommodation/accommodation_request_model.dart';
import 'package:tomatebnb/models/accommodation/accommodation_response_complete_model.dart';
import 'package:tomatebnb/models/accommodation/accommodation_response_model.dart';
import 'package:tomatebnb/models/accommodation/accommodation_type_response_model.dart';
import 'package:tomatebnb/models/accommodation/describe_response_model.dart';
import 'package:tomatebnb/services/location_service.dart';
import 'package:tomatebnb/utils/Colors.dart';
import 'package:tomatebnb/utils/customwidget.dart';
import 'package:tomatebnb/utils/dark_lightmode.dart';

class DescribePage extends StatefulWidget {
  const DescribePage({super.key});

  @override
  State<DescribePage> createState() => _DescribePageState();
}

class _DescribePageState extends State<DescribePage> {
  @override
  void initState() {
    _pageController = PageController(initialPage: _currentPage);
    getdarkmodepreviousstate();
    super.initState();
    context.read<DescribeBloc>().add(DescribeGetEvent());
    context.read<AccommodationTypeBloc>().add(AccommodationTypeGetEvent());
    accommodationRequestModel = AccommodationRequestModel();
    accommodationResponseModel = AccommodationResponseCompleteModel();
  }

  late ColorNotifire notifire;
  PageController _pageController = PageController();
  int _currentPage = 0;
  int? _accommodationId;
  List<DescribeResponseModel> describes = [];
  List<AccommodationTypeResponseModel> accommodationTypes = [];

  final adressController = TextEditingController();
  final cityController = TextEditingController();
  final countryController = TextEditingController(text:'Bolivia');

  int _guestCounter = 0;
  int _roomCounter = 0;
  int _bathCounter = 0;
  int _bedsCounter = 0;

  static const List<String> _titles = [
    'Describe tu espacio',
    '¿Cuál de estas opciones describen mejor tu alojamiento?',
    '¿Que tipo de alojamiento ofreces a los huespedes?',
    '¿Donde se encuentra tu espacio?',
    'Agrega algunos datos básicos de tu espacio',
  ];
  List<bool> selected = []; //selected describes
  List<bool> selectedTypes = [];
  late AccommodationRequestModel? accommodationRequestModel;
  late AccommodationResponseCompleteModel? accommodationResponseModel;
  LocationService locationService = LocationService();
  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    _accommodationId = GoRouterState.of(context).extra as int?;
    context
        .read<AccommodationBloc>()
        .add(AccommodationGetByIdEvent(_accommodationId ?? 0));
    return Scaffold(
      backgroundColor: WhiteColor,
       appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.surface,
        surfaceTintColor: Theme.of(context).colorScheme.surface,
        automaticallyImplyLeading: false,
        // leading: BackButton(color: notifire.getwhiteblackcolor),
       
        actions: [
          Ink(
            height: 40,
            decoration:
                ShapeDecoration(color: Colors.grey[300], shape: CircleBorder()),
            child: IconButton(
                onPressed: () {
                  context.go('/menu-anfitrion');
                },
                icon: const Icon(Icons.close)),
          ),
          SizedBox(
            width: 10,
          )
        ],
      ),
     
      body: Stack(
        children: <Widget>[
          PageView(
            controller: _pageController,
            onPageChanged: _handlingOnPageChanged,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              BlocBuilder<AccommodationBloc, AccommodationState>(
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
                  if (state is AccommodationGetByIdSuccess) {
                    accommodationResponseModel = state.responseAccommodation;
                    accommodationRequestModel =accommodationResponseModel?.toRequestModel();
                    adressController.text=accommodationResponseModel!.address??'';
                    cityController.text=accommodationResponseModel!.city??'';
                    countryController.text=accommodationResponseModel!.country??'';
                     _guestCounter = accommodationResponseModel!.guestCapacity??0;
                     _roomCounter =  accommodationResponseModel!.numberRooms??0;
                     _bathCounter =  accommodationResponseModel!.numberBathrooms??0;
                     _bedsCounter =  accommodationResponseModel!.numberBeds??0;
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
              child: Image.asset("assets/images/onbording11.png"),
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
                "En este paso, te preguntaremos sobre el tipo de alojamiento que compartes, si los huespedes tendrán el espacio entero o una habitación. Posteriormente indicanos la ubicación y cuantos huespedes pueden quedarse.",
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
                            color: Theme.of(context).colorScheme.primary,
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
                            color: Theme.of(context).colorScheme.primary,
                            borderRadius: BorderRadius.circular(15)),
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
                  child: BlocBuilder<DescribeBloc, DescribeState>(
                    builder: (context, state) {
                      if (state is DescribeGetLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (state is DescribeGetError) {
                        return Center(
                          child: Text(state.message),
                        );
                      }
                      if (state is DescribeGetSuccess) {
                        describes = state.responseDescribes;
                        for (int i = 0; i < describes.length; i++) {
                          if(accommodationResponseModel!.describeId==describes[i].id){
                            selected.add(true);
                          }else{
                            selected.add(false);
                          }
                          
                        }
                      }
                      return SizedBox(
                        height: MediaQuery.of(context).size.height * 0.63,
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 5,
                            childAspectRatio: 1.3,
                          ),
                          // physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          itemCount: describes.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 6),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      border: 
                                      selected[index]
                                      ?Border(
                                        top:BorderSide(color:Theme.of(context).colorScheme.tertiary,width:4.0),
                                        bottom:BorderSide(color:Theme.of(context).colorScheme.tertiary,width:4.0),
                                        left:BorderSide(color:Theme.of(context).colorScheme.tertiary,width:4.0),
                                        right:BorderSide(color:Theme.of(context).colorScheme.tertiary,width:4.0),)
                                      :Border(),
                                      color: notifire.getdarkmodecolor),
                                  child: Column(
                                    children: [
                                      ListTile(
                                        onTap: () {
                                          for (var i = 0;i < selected.length;i++) {
                                            selected[i] = false;
                                          }
                                          selected[index] = true;
                                          accommodationRequestModel?.describeId = describes[index].id;
                                          setState(() {});
                                        },
                                        
                                        // trailing: selected[index] == true
                                            
                                        //     ? Icon(Icons.check_circle,
                                        //         color:
                                        //             notifire.getdarkbluecolor)
                                        //     : SizedBox.shrink(),

                                        title: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 12.0),
                                          child:Image.asset("assets/images/d${describes[index].id}.png",
                                          height: 30,width: 30,)
                                          // Icon(Icons.bed),
                                        ),
                                        subtitle: Center(
                                          child: Text(
                                            describes[index].describe??'',
                                            style: TextStyle(
                                                fontFamily: "Gilroy Bold",
                                                fontSize: 16,
                                                color:
                                                    notifire.getwhiteblackcolor),
                                          ),
                                        ),
                                        // isThreeLine: true,
                                      ),
                                    ],
                                  ),
                                )
                                );
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
                            color: Theme.of(context).colorScheme.primary,
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
                      accommodationResponseModel?.describeId =
                          accommodationRequestModel?.describeId;
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
                        onTap: accommodationRequestModel?.describeId == null
                            ? null
                            : () {
                                context.read<AccommodationBloc>().add(
                                    AccommodationUpdateEvent(
                                        _accommodationId ?? 0,
                                        accommodationRequestModel!));
                              },
                        child: Container(
                            decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.primary,
                                borderRadius: BorderRadius.circular(15)),
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
                      if (state is AccommodationTypeGetSuccess) {
                        accommodationTypes = state.responseAccommodationTypes;
                        for (int i = 0; i < accommodationTypes.length; i++) {
                          if(accommodationTypes[i].id == accommodationResponseModel?.typeId)
                          {
                            selectedTypes.add(true);
                          }else{
                            selectedTypes.add(false);
                          }
                        }
                      }
                      return SizedBox(
                        height: MediaQuery.of(context).size.height * 0.63,
                        child: ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          itemCount: accommodationTypes.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 6),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: notifire.getdarkmodecolor,
                                       border: 
                                      selectedTypes[index]
                                      ?Border(
                                        top:BorderSide(color:Theme.of(context).colorScheme.tertiary,width:4.0),
                                        bottom:BorderSide(color:Theme.of(context).colorScheme.tertiary,width:4.0),
                                        left:BorderSide(color:Theme.of(context).colorScheme.tertiary,width:4.0),
                                        right:BorderSide(color:Theme.of(context).colorScheme.tertiary,width:4.0),)
                                      :Border(),),
                                  child: Column(
                                    children: [
                                      ListTile(
                                          onTap: () {
                                            for (var i = 0;
                                                i < selectedTypes.length;
                                                i++) {
                                              selectedTypes[i] = false;
                                            }
                                            selectedTypes[index] = true;
                                            accommodationRequestModel?.typeId =
                                                accommodationTypes[index].id;
                                            setState(() {});
                                          },
                                         
                                          // trailing: selectedTypes[index] == true
                                          //     ? Icon(Icons.check_circle,
                                          //         color:
                                          //             notifire.getdarkbluecolor)
                                          //     : SizedBox.shrink(),
                                          leading: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 12.0),
                                            child: Image.asset("assets/images/at${accommodationTypes[index].id}.png")
                                            // Icon(Icons.holiday_village)87,
                                          ),
                                          title: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 12.0),
                                            child: Text(
                                              accommodationTypes[index].name??'',
                                              style: TextStyle(
                                                  fontFamily: "Gilroy Bold",
                                                  fontSize: 16,
                                                  color: notifire
                                                      .getwhiteblackcolor),
                                            ),
                                          ),
                                          subtitle: Padding(
                                            padding:
                                                const EdgeInsets.only(top: 8,bottom: 12.0),
                                            child: SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.61,
                                                child: Text(
                                                    accommodationTypes[index]
                                                        .description??'',
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
                                )
                                );
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
                            color: Theme.of(context).colorScheme.primary,
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
                                color: Theme.of(context).colorScheme.primary,
                                borderRadius: BorderRadius.circular(15)),
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

  // Completer para el controlador del mapa
  late GoogleMapController mapController;
  Set<Marker> markers = Set<Marker>();
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Widget _buildPage4() {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    LatLng currentLocation = LatLng(-17.009547, -64.832168);
    return SafeArea(
      child: Scaffold(
        backgroundColor: notifire.getbgcolor,
        body: Stack(
          children: [
            GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: currentLocation,
                zoom: 6,
              ),
              markers: markers,
            ),
            Column(
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
                    buttontext: "Ingresa tu direccón",
                    onclick: bottomsheet,
                    context: context),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                BlocConsumer<LocalizationBloc, LocalizationState>(
                  listener: (context, state) {
                    if (state is LocalizationGetSuccess) {
                           accommodationRequestModel?.latitude = state.latitude; 
                           accommodationRequestModel?.longitude = state.longitude;

                           // Asignamos la latitud y longitud al google maps
                            mapController.animateCamera(
                              CameraUpdate.newCameraPosition(
                                CameraPosition(
                                  target: LatLng(state.latitude, state.longitude),
                                  zoom: 14,
                                ),
                              ),
                            );

                            // Colocamos un marker en la ubicación actual Set<Marker>
                            // Colocamos un marker en la ubicación actual
                            final marker = Marker(
                              markerId: MarkerId('current_location'),
                              position: LatLng(state.latitude, state.longitude),
                              infoWindow: InfoWindow(title: 'Mi ubicación actual'),
                              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
                            );

                            // Actualizamos los markers del mapa
                            setState(() {
                              markers.clear();
                              markers.add(marker);
                            });
                            
                        } else if (state is LocalizationGetError) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(state.message ),
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
                            onTap: ()  {
                               context.read<LocalizationBloc>().add(
                                        LocalizationGetEvent());
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                    color: Theme.of(context).colorScheme.primary,
                                    borderRadius: BorderRadius.circular(25)),
                                height: 40,
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
                           (accommodationRequestModel?.latitude?? 0) != 0  && (accommodationRequestModel?.longitude?? 0) != 0
                              ? Icon(Icons.check_circle_outlined, color: Theme.of(context).colorScheme.primary)
                              :Icon(Icons.circle_outlined, color: Colors.grey)
                           
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
                                color: Theme.of(context).colorScheme.primary,
                                fontFamily: "Gilroy Bold"),
                          )),
                    ),
                    BlocConsumer<AccommodationBloc, AccommodationState>(
                      listener: (context, state) {
                        if (state is AccommodationUpdateSuccess) {
                          accommodationResponseModel?.address = accommodationRequestModel?.address;
                          accommodationResponseModel?.city = accommodationRequestModel?.city;
                          accommodationResponseModel?.country = accommodationRequestModel?.country;
                          accommodationResponseModel?.latitude = accommodationRequestModel?.latitude;
                          accommodationResponseModel?.longitude = accommodationRequestModel?.longitude;
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
                            onTap: 
                            // adressController.text.isEmpty ||
                            //         cityController.text.isEmpty ||
                            //         countryController.text.isEmpty||
                                    (accommodationRequestModel?.latitude??0)==0||
                                    (accommodationRequestModel?.longitude??0)==0
                                ? null
                                : () {
                                    accommodationRequestModel?.address =
                                        adressController.text;
                                    accommodationRequestModel?.city =
                                        cityController.text;
                                    accommodationRequestModel?.country =
                                        countryController.text;
            
                                    context.read<AccommodationBloc>().add(
                                        AccommodationUpdateEvent(
                                            _accommodationId ?? 0,
                                            accommodationRequestModel!));
                                  },
                            child: Container(
                                decoration: BoxDecoration(
                                    color: Theme.of(context).colorScheme.primary,
                                    borderRadius: BorderRadius.circular(15)),
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
              child:  Container(
            height: MediaQuery.of(context).size.height * 0.50,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.025),
                  room(
                      text: "Cantidad de Huespedes",
                      titletext: "Minimum contains 4 people",
                      onclick1: () {
                        setState(() {
                          if(_guestCounter>0){
                            _guestCounter--;
                          }
                          
                        });
                      },
                      middeltext: "$_guestCounter",
                      onclick2: () {
                        setState(() {
                          _guestCounter++;
                        });
                      }),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.025),
                  room(
                      text: "Cantidad de recamaras",
                      titletext: " ",
                      onclick1: () {
                        setState(() {
                          if (_roomCounter>0) {
                            
                          _roomCounter--;
                          }
                        });
                      },
                      middeltext: "$_roomCounter",
                      onclick2: () {
                        setState(() {
                          _roomCounter++;
                        });
                      }),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.025),
                  room(
                      text: "Cantidad de baños",
                      titletext: "",
                      onclick1: () {
                        setState(() {
                          if (_bathCounter>0) {
                          _bathCounter--;
                          }
                        });
                      },
                      middeltext: "$_bathCounter",
                      onclick2: () {
                        setState(() {
                          _bathCounter++;
                        });
                      }),
                       SizedBox(height: MediaQuery.of(context).size.height * 0.025),
                  room(
                      text: "Cantidad de camas",
                      titletext: "",
                      onclick1: () {
                        setState(() {
                          if (_bedsCounter>0) {
                          _bedsCounter--;
                          }
                        });
                      },
                      middeltext: "$_bedsCounter",
                      onclick2: () {
                        setState(() {
                          _bedsCounter++;
                        });
                      }),
                  
                ],
              ),
            ),
          )
        
             
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
                BlocConsumer<AccommodationBloc, AccommodationState>(
                  listener: (context, state) {
                    if (state is AccommodationUpdateSuccess) {
                      accommodationResponseModel?.guestCapacity = accommodationRequestModel?.guestCapacity;
                      accommodationResponseModel?.numberRooms = accommodationRequestModel?.numberRooms;
                      accommodationResponseModel?.numberBathrooms = accommodationRequestModel?.numberBathrooms;
                      accommodationResponseModel?.numberBeds = accommodationRequestModel?.numberBeds;
                      // _pageController.nextPage(
                      //     duration: const Duration(microseconds: 300),
                      //     curve: Curves.easeIn);
                      if(_currentPage==4){
                        context.push('/highlight',extra: _accommodationId);
                      }
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
                        onTap: _guestCounter < 1 ||
                               _roomCounter < 1 ||
                               _bathCounter < 1 ||
                               _bedsCounter < 1
                            ? null
                            : () {
                                accommodationRequestModel?.guestCapacity = _guestCounter;
                                accommodationRequestModel?.numberRooms = _roomCounter;
                                accommodationRequestModel?.numberBathrooms = _bathCounter;
                                accommodationRequestModel?.numberBeds = _bedsCounter;
                                context.read<AccommodationBloc>().add(
                                    AccommodationUpdateEvent(
                                        _accommodationId ?? 0,
                                        accommodationRequestModel!));
                              },
                        child: Container(
                            decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.primary,
                                borderRadius: BorderRadius.circular(15)),
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
                        controller: adressController,
                        decoration: InputDecoration(
                          hintText:
                              "Calle, Avenida, Nro.  Zona/ Barrio Piso dpto.",
                          hintStyle: TextStyle(
                            color: notifire.getgreycolor,
                            fontFamily: "Gilroy Medium",
                          ),
                          suffixIcon: Padding(
                            padding: const EdgeInsets.all(6),
                            
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
                        controller: cityController,
                        decoration: InputDecoration(
                          hintText: "La Paz, Santa Cruz, Montero.....",
                          hintStyle: TextStyle(
                            color: notifire.getgreycolor,
                            fontFamily: "Gilroy Medium",
                          ),
                          suffixIcon: Padding(
                            padding: const EdgeInsets.all(6),
                            
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
                        readOnly: true,
                        controller: countryController,
                        decoration: InputDecoration(
                          hintText: "Bolivia",
                          hintStyle: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontFamily: "Gilroy Medium",
                          ),
                          suffixIcon: Padding(
                            padding: const EdgeInsets.all(6),
                           
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
                        onTap: 
                        // adressController.text.isEmpty ||
                        //         cityController.text.isEmpty ||
                        //         countryController.text.isEmpty
                        //     ? null
                        //     : 
                            () {
                                accommodationRequestModel?.address =
                                    adressController.text;
                                accommodationRequestModel?.city =
                                    cityController.text;
                                accommodationRequestModel?.country =
                                    countryController.text;
                                Navigator.of(context).pop();
                              },
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
                      radius: 15,
                      child: Icon(Icons.remove,
                          color: notifire.getdarkwhitecolor, size: 30),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Text(
                    middeltext,
                    style: TextStyle(color: Theme.of(context).colorScheme.primary,fontSize: 25.0),
                  ),
                  const SizedBox(width: 15),
                  InkWell(
                    onTap: onclick2,
                    child: CircleAvatar(
                      backgroundColor: notifire.getdarkbluecolor,
                      radius: 15,
                      child: Icon(Icons.add,
                          color: notifire.getdarkwhitecolor, size: 30),
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
