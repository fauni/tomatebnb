import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tomatebnb/bloc/export_blocs.dart';
import 'package:tomatebnb/config/constants/environment.dart';
import 'package:tomatebnb/models/accommodation/accommodation_photo_request_model.dart';
import 'package:tomatebnb/models/accommodation/accommodation_photo_response_model.dart';
import 'package:tomatebnb/models/accommodation/accommodation_request_model.dart';
import 'package:tomatebnb/models/accommodation/accommodation_response_complete_model.dart';
// import 'package:tomatebnb/models/accommodation/accommodation_response_model.dart';
import 'package:tomatebnb/models/aspect_response_model.dart';

import 'package:tomatebnb/models/service_response_model.dart';
import 'package:tomatebnb/utils/Colors.dart';

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
    accommodationResponseModel = AccommodationResponseCompleteModel();
    addEmptyPhoto();
  }

  late ColorNotifire notifire;
  PageController _pageController = PageController();
  int _currentPage = 0;
  int? _accommodationId;
  List<ServiceResponseModel> services = [];
  List<AspectResponseModel> aspects = [];
  List<AccommodationPhotoResponseModel> photos = [];
   final String _imgsUrl = Environment.UrlImg;
  int _countPhotos=0;

  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  static const List<String> _titles = [
    'Haz que tu espacion se destaque',
    'Cuentale a tus huéspedes todo lo que tu espacio tiene para ofrecer',
    'Agrega algunas fotos de tu alojamiento',
    'Ponle Título a tu alojamiento',
    'Vamos a describir tu alojamiento, elije hasta dos aspectos que lo distingan',
    'Crea tu descripción',
  ];
  List<bool> selectedServices = [];
  List<bool> selectedAspects = [];

  late AccommodationRequestModel? accommodationRequestModel;
  late AccommodationResponseCompleteModel? accommodationResponseModel;

  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    _accommodationId = GoRouterState.of(context).extra as int?;
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
                    photos = accommodationResponseModel!.photos??[];
                    addEmptyPhoto();
                    accommodationRequestModel =
                        accommodationResponseModel?.toRequestModel();
                    _titleController.text = accommodationResponseModel!.title??'';
                    _descriptionController.text = accommodationResponseModel!.description??'';

                    context.read<AspectBloc>().add(AspectGetByDescribeEvent(
                        accommodationResponseModel?.describeId ?? 0));
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
              _buildPage5(),
              _buildPage6(),
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
              for (int i = 0; i < 6; i++)
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    // borderRadius: const BorderRadius.all(
                    //   Radius.circular(50),
                    // ),
                    // color: Color(0xFF000000),
                    color: _currentPage == i
                        ? Theme.of(context).colorScheme.primary
                        : greyColor,
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
                              bool esElegido= false;
                                for(int j  = 0; j < accommodationResponseModel!.services!.length; j++)
                                {
                                  if(services[i].id == accommodationResponseModel!.services![j].serviceId)
                                    {
                                      esElegido =true;
                                    }
                                }
                              selectedServices.add(esElegido);
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
                                child: BlocListener<AccommodationServiceBloc,
                                    AccommodationServiceState>(
                                  listener: (context, state) {
                                    // TODO: implement listener
                                    if (state
                                        is AccommodationServiceCreateSuccess) {
                                      if (state.responseAccommodationService
                                              .serviceId ==
                                          services[index].id) {
                                        selectedServices[index] = true;
                                        setState(() {});
                                      }
                                      // _pageController.nextPage(
                                      //     duration: const Duration(microseconds: 300),
                                      //     curve: Curves.easeIn);
                                    } else if (state
                                        is AccommodationServiceDeleteSuccess) {
                                      if (state.responseAccommodationService
                                              .serviceId ==
                                          services[index].id) {
                                        selectedServices[index] = false;
                                        setState(() {});
                                      }
                                    } else if (state
                                        is AccommodationServiceCreateError) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text(state.message),
                                      ));
                                    } else if (state
                                        is AccommodationServiceDeleteError) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text(state.message),
                                      ));
                                    }
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: notifire.getdarkmodecolor,
                                        border: 
                                        selectedServices[index]
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
                                            if (!selectedServices[index]) {
                                              context
                                                  .read<
                                                      AccommodationServiceBloc>()
                                                  .add(
                                                      AccommodationServiceCreateEvent(
                                                          _accommodationId ?? 0,
                                                          services[index].id));
                                            } else {
                                              context
                                                  .read<
                                                      AccommodationServiceBloc>()
                                                  .add(
                                                      AccommodationServiceDeleteEvent(
                                                          _accommodationId ?? 0,
                                                          services[index].id));
                                            }
                                          
                                          },
                                          title: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 12.0),
                                            child: Icon(Icons.bed),
                                          ),
                                          subtitle: Center(
                                            child: Text(
                                              services[index].name,
                                              style: TextStyle(
                                                  fontFamily: "Gilroy Bold",
                                                  fontSize: 16,
                                                  color: notifire
                                                      .getwhiteblackcolor),
                                            ),
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
                            color: Theme.of(context).colorScheme.primary,
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
                    child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.63,
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 5,
                      childAspectRatio: 1.3,
                    ),
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    itemCount: photos.length,
                    itemBuilder: (BuildContext context, int index) {
                      if (photos[index].id > 0) {
                        return Stack(
                          children:<Widget> [
                            FadeInImage.assetNetwork(
                              placeholder: 'assets/images/load.gif', 
                              image: '$_imgsUrl/accommodations/${photos[index].photoUrl}'),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton.outlined(
                                    
                                    color: Theme.of(context).colorScheme.error,

                                    onPressed: (){
                                      context.read<AccommodationPhotoBloc>().add(
                                        AccommodationPhotoDeleteEvent(photos[index].id ));
                                    },
                                    icon: Icon(Icons.delete,
                                    // color: Theme.of(context).colorScheme.error,
                                    ))
                                ],
                              )
                              ]
                        );  
                        // Text('foto ');
                      } else {
                        return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: notifire.getdarkmodecolor),
                              child: Column(
                                children: [
                                  ListTile(
                                    onTap: bottomsheet,
                                    title: SizedBox(height: 15.0,),
                                    subtitle: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 1.0),
                                        child: Icon(
                                          Icons.add_a_photo_outlined,
                                          size: 70.0,
                                        ),
                                      ),
                                    ),
                                    // subtitle: Padding(
                                    //   padding: const EdgeInsets.only(top: 8),
                                    //   child: IconButton(
                                    //     onPressed: null,
                                    //     icon: Icon(Icons.add_a_photo_outlined))
                                    // )
                                    // isThreeLine: true,
                                  ),
                                ],
                              ),
                            ));
                      }
                    },
                  ),
                ))),
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
                BlocConsumer<AccommodationPhotoBloc, AccommodationPhotoState>(
                  listener: (context, state) {
                    if(state is AccommodationPhotoCreateSuccess){
                      _countPhotos++;
                      photos.removeLast();
                      photos.add(state.responseAccommodationPhoto);
                      // accommodationResponseModel?.photos?.add(state.responseAccommodationPhoto);
                      addEmptyPhoto();
                      setState(() { });
                    }
                    if(state is AccommodationPhotoCreateError){
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(state.message)));
                    }

                    if(state is AccommodationPhotoDeleteSuccess){
                    //  photos.removeLast();
                     photos.remove(state.responseAccommodationPhoto);
                     int removeId = 0;
                     for (var photo in photos) {
                       if(photo.id == state.responseAccommodationPhoto.id){
                         removeId = photo.id;
                       }
                     }
                     if (removeId!=0) {
                      photos.removeWhere((photo)=>photo.id==removeId);  
                     }
                     _countPhotos--;
                    //photos.add(state.responseAccommodationPhoto);
                      // accommodationResponseModel?.photos?.add(state.responseAccommodationPhoto);
                      // addEmptyPhoto();
                       setState(() { });
                    }
                    if(state is AccommodationPhotoDeleteError){
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(state.message)));
                    }

                  },
                  builder: (context, state) {
                    if(state is AccommodationPhotoCreateLoading){
                      return Center(child:CircularProgressIndicator());
                    }
                    if(state is AccommodationPhotoDeleteLoading){
                      return Center(child:CircularProgressIndicator());
                    }
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: GestureDetector(
                        onTap: accommodationRequestModel?.typeId == null
                            ? null
                            : () {
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
                    );
                  },
                )
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
        body: SingleChildScrollView(
          child: Column(
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
              const SizedBox(height: 4),
              Container(
                height: MediaQuery.of(context).size.height * 0.55,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: notifire.getdarkmodecolor),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _titleController,
                      minLines: 2,
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      style: TextStyle(
                          fontSize: 35,
                          color: Theme.of(context).colorScheme.primary),
                      // controller: adressController,
                      decoration: InputDecoration(
                        hintText: "Alojamiento.....",
                        hintStyle: TextStyle(
                          color: notifire.getgreycolor,
                          fontSize: 25.0,
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
                          removeFocus();
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
                           removeFocus();
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
                          onTap: 
                          // _titleController.text.isEmpty
                              // ? null
                              // : 
                              () {
                                  accommodationRequestModel?.title =
                                      _titleController.text;
                                  context.read<AccommodationBloc>().add(
                                      AccommodationUpdate2Event(
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
                        );
                      },
                    ),
                  )
                ],
              ),
            ],
          ),
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
                  child: BlocBuilder<AspectBloc, AspectState>(
                    builder: (context, state) {
                      if (state is AspectGetByDescribeLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (state is AspectGetByDescribeError) {
                        return Center(
                          child: Text(state.message),
                        );
                      }
                      if (state is AspectGetByDescribeSuccess) {
                        aspects = state.responseAspects;
                        // for (int i = 0; i < aspects.length; i++) {
                        //   selectedAspects.add(false);
                        // }
                          for (int i = 0; i < aspects.length; i++) {
                              bool esElegido= false;
                                for(int j  = 0; j < accommodationResponseModel!.aspects!.length; j++)
                                {
                                  if(aspects[i].id == accommodationResponseModel!.aspects![j].aspectId)
                                    {
                                      esElegido =true;
                                    }
                                }
                              selectedAspects.add(esElegido);
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
                          itemCount: aspects.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 6),
                                child: BlocListener<AccommodationAspectBloc,
                                    AccommodationAspectState>(
                                  listener: (context, state) {
                                    // TODO: implement listener
                                    if (state
                                        is AccommodationAspectCreateSuccess) {
                                      if (state.responseAccommodationAspect
                                              .aspectId ==
                                          aspects[index].id) {
                                        selectedAspects[index] = true;
                                        setState(() {});
                                      }
                                      // _pageController.nextPage(
                                      //     duration: const Duration(microseconds: 300),
                                      //     curve: Curves.easeIn);
                                    } else if (state
                                        is AccommodationAspectDeleteSuccess) {
                                      if (state.responseAccommodationAspect
                                              .aspectId ==
                                          aspects[index].id) {
                                        selectedAspects[index] = false;
                                        setState(() {});
                                      }
                                    } else if (state
                                        is AccommodationAspectCreateError) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text(state.message),
                                      ));
                                    } else if (state
                                        is AccommodationAspectDeleteError) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text(state.message),
                                      ));
                                    }
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: notifire.getdarkmodecolor,
                                         border: 
                                        selectedAspects[index]
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
                                            if (!selectedAspects[index]) {
                                              context
                                                  .read<
                                                      AccommodationAspectBloc>()
                                                  .add(
                                                      AccommodationAspectCreateEvent(
                                                          _accommodationId ?? 0,
                                                          aspects[index].id));
                                            } else {
                                              context
                                                  .read<
                                                      AccommodationAspectBloc>()
                                                  .add(
                                                      AccommodationAspectDeleteEvent(
                                                          _accommodationId ?? 0,
                                                          aspects[index].id));
                                            }
                                          },

                                          // trailing: selectedAspects[index]
                                          //     ? Icon(Icons.check_circle,
                                          //         color:
                                          //             notifire.getdarkbluecolor)
                                          //     : SizedBox.shrink(),

                                          title: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 12.0),
                                            child: Icon(Icons.bed),
                                          ),
                                          subtitle: Center(
                                            child: Text(
                                              aspects[index].description,
                                              style: TextStyle(
                                                  fontFamily: "Gilroy Bold",
                                                  fontSize: 16,
                                                  color: notifire
                                                      .getwhiteblackcolor),
                                            ),
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
                            color: Theme.of(context).colorScheme.primary,
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

  Widget _buildPage6() {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    return SafeArea(
      child: Scaffold(
        backgroundColor: notifire.getbgcolor,
        body: SingleChildScrollView(
          child: Column(
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
              const SizedBox(height: 4),
              Container(
                height: MediaQuery.of(context).size.height * 0.55,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: notifire.getdarkmodecolor),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _descriptionController,
                      minLines: 5,
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      style: TextStyle(
                          fontSize: 25,
                          color: Theme.of(context).colorScheme.primary),
                      // controller: adressController,
                      decoration: InputDecoration(
                        hintText: "Alojamiento espacioso.....",
                        hintStyle: TextStyle(
                            color: notifire.getgreycolor,
                            fontFamily: "Gilroy Medium",
                            fontSize: 20),
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
                          removeFocus();
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
                          if(_currentPage==5){
                          context.push('/prices', extra: _accommodationId);
                          }
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
                          onTap: _descriptionController.text.isEmpty
                              ? null
                              : () {
                                  accommodationRequestModel!.description =
                                      _descriptionController.text;
                                  context.read<AccommodationBloc>().add(
                                      AccommodationUpdate2Event(
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
                        );
                      },
                    ),
                  )
                ],
              ),
            ],
          ),
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
              height: MediaQuery.of(context).size.height * 0.20,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 1),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //  Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [

                    //     InkWell(
                    //         onTap: () {
                    //           Navigator.of(context).pop();
                    //         },
                    //         child: Icon(
                    //           Icons.close,
                    //           color: notifire.getwhiteblackcolor,
                    //         ))
                    //   ],
                    // ),
                    const SizedBox(height: 4),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 1),
                      child: Center(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                            AccommodationPhotoRequestModel request = AccommodationPhotoRequestModel(
                              accommodationId: _accommodationId.toString(),
                              photoUrl: "none",
                              mainPhoto: "0",
                              order: photos.length.toString(),
                               ); 
                            context.read<AccommodationPhotoBloc>().add(
                                    AccommodationPhotoCreateEvent(
                                        request,
                                        false));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: WhiteColor,
                                borderRadius: BorderRadius.circular(5)),
                            height: 50,
                            width: MediaQuery.of(context).size.width,
                            child: Center(
                              child: Text(
                                "Desde Galeria",
                                style: TextStyle(
                                    fontSize: 20,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    fontFamily: "Gilroy Bold"),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Divider(color: Theme.of(context).colorScheme.primary),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 1),
                      child: Center(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                            AccommodationPhotoRequestModel request = AccommodationPhotoRequestModel(
                              accommodationId: _accommodationId.toString(),
                              photoUrl: "none",
                              mainPhoto: "0",
                              order: photos.length.toString(),
                               ); 
                            context.read<AccommodationPhotoBloc>().add(
                                    AccommodationPhotoCreateEvent(
                                        request,
                                        true));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.primary,
                                borderRadius: BorderRadius.circular(5)),
                            height: 50,
                            width: MediaQuery.of(context).size.width,
                            child: Center(
                              child: Text(
                                "Desde Cámara",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: WhiteColor,
                                    fontFamily: "Gilroy Bold"),
                              ),
                            ),
                          ),
                        ),
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

  addEmptyPhoto() {
    photos.add(AccommodationPhotoResponseModel(
        accommodationId: 0,
        photoUrl: "",
        mainPhoto: false,
        order: 0,
        // status: "",
        updatedAt: DateTime.parse("2000-01-01"),
        createdAt: DateTime.parse("2000-01-01"),
        id: 0));
  }

 removeFocus(){
     FocusScopeNode currentFocus = FocusScope.of(context);
      if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
      }
   
 }

}
