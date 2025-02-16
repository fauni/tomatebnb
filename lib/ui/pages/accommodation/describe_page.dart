import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tomatebnb/bloc/export_blocs.dart';
import 'package:tomatebnb/models/accommodation/accommodation_request_model.dart';
import 'package:tomatebnb/models/accommodation/accommodation_response_model.dart';
import 'package:tomatebnb/models/accommodation/accommodation_type_response_model.dart';
import 'package:tomatebnb/models/accommodation/describe_response_model.dart';
import 'package:tomatebnb/utils/Colors.dart';
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
    accommodationResponseModel = AccommodationResponseModel();
  }

  late ColorNotifire notifire;
  PageController _pageController = PageController();
  int _currentPage = 0;
  int? _accommodationId;
  List<DescribeResponseModel> describes = [];
  List<AccommodationTypeResponseModel> accommodationTypes = [];
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
                    accommodationRequestModel = accommodationResponseModel?.toRequestModel();
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
                          selected.add(false);
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
                            childAspectRatio: 1.5,
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
                                        // leading: Image.asset(
                                        //     "assets/images/home-2.png",
                                        //     height: 35),
                                        trailing: selected[index] == true 
                                                  // || accommodationResponseModel?.describeId == describes[index].id  
                                            ? Icon(Icons.check_circle,
                                                    color: notifire
                                                        .getdarkbluecolor)
                                            : SizedBox.shrink(),

                                        title: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 12.0),
                                          child: Icon(Icons.bed),
                                        ),
                                        subtitle: Text(
                                          describes[index].describe,
                                          style: TextStyle(
                                              fontFamily: "Gilroy Bold",
                                              fontSize: 16,
                                              color:
                                                  notifire.getwhiteblackcolor),
                                        ),
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
                    if(state is AccommodationUpdateSuccess){
                      _pageController.nextPage(
                              duration: const Duration(microseconds: 300),
                              curve: Curves.easeIn);
                      accommodationResponseModel?.describeId = accommodationRequestModel?.describeId;
                    }else if(state is AccommodationUpdateError ){
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(state.message),
                      ));
                    }
                  },
                  builder: (context, state) {
                    if(state is AccommodationUpdateLoading){
                        return Center(child: const CircularProgressIndicator());
                    } 
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: GestureDetector(
                        onTap: 
                        accommodationRequestModel?.describeId == null
                        ?null
                        :() {
                          
                             context.read<AccommodationBloc>().add(
                          AccommodationUpdateEvent(
                            _accommodationId ?? 0, 
                            accommodationRequestModel!)
                          );
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
                height: MediaQuery.of(context).size.height *0.02), //upar thi jagiya mukeli che
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
                  child: BlocBuilder<AccommodationTypeBloc, AccommodationTypeState>(
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
                          selectedTypes.add(false);
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
                                      color: notifire.getdarkmodecolor),
                                  child: Column(
                                    children: [
                                      ListTile(
                                        onTap: () {
                                          for (var i = 0;i < selectedTypes.length;i++) {
                                            selectedTypes[i] = false;
                                          }
                                          selectedTypes[index] = true;
                                          accommodationRequestModel?.typeId = accommodationTypes[index].id;
                                          setState(() {});
                                        },
                                        // leading: Image.asset(
                                        //     "assets/images/home-2.png",
                                        //     height: 35),
                                        trailing: selectedTypes[index] == true 
                                                // ||accommodationResponseModel?.typeId == accommodationTypes[index].id  
                                            ? Icon(Icons.check_circle,
                                                    color: notifire
                                                        .getdarkbluecolor)
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
                                            accommodationTypes[index].name,
                                            style: TextStyle(
                                                fontFamily: "Gilroy Bold",
                                                fontSize: 16,
                                                color: notifire.getwhiteblackcolor),
                                          ),
                                        ),
                                
                                        subtitle: Padding(
                                      padding: const EdgeInsets.only(top: 8),
                                      child: SizedBox(
                                        width: MediaQuery.of(context).size.width *
                                            0.61,
                                        child: Text(
                                        accommodationTypes[index].description,
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: greyColor,
                                              fontFamily: "Gilroy Medium")
                                        )
                                      ),
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
                    if(state is AccommodationUpdateSuccess){
                      _pageController.nextPage(
                              duration: const Duration(microseconds: 300),
                              curve: Curves.easeIn);
                              accommodationResponseModel?.typeId = accommodationRequestModel?.typeId;
                    }else if(state is AccommodationUpdateError ){
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(state.message),
                      ));
                    }
                  },
                  builder: (context, state) {
                    if(state is AccommodationUpdateLoading){
                        return Center(child: const CircularProgressIndicator());
                    } 
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: GestureDetector(
                        onTap: 
                        accommodationRequestModel?.typeId == null
                        ?null
                        :() {
                          
                             context.read<AccommodationBloc>().add(
                          AccommodationUpdateEvent(
                            _accommodationId ?? 0, 
                            accommodationRequestModel!)
                          );
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
            SizedBox(
                height: MediaQuery.of(context).size.height *0.02), //upar thi jagiya mukeli che
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
                        height: MediaQuery.of(context).size.height * 0.63,
                    
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
                    // TODO: implement listener
                    if(state is AccommodationUpdateSuccess){
                      _pageController.nextPage(
                              duration: const Duration(microseconds: 300),
                              curve: Curves.easeIn);
                              accommodationResponseModel?.typeId = accommodationRequestModel?.typeId;
                    }else if(state is AccommodationUpdateError ){
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(state.message),
                      ));
                    }
                  },
                  builder: (context, state) {
                    if(state is AccommodationUpdateLoading){
                        return Center(child: const CircularProgressIndicator());
                    } 
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: GestureDetector(
                        onTap: 
                        accommodationRequestModel?.typeId == null
                        ?null
                        :() {
                          
                             context.read<AccommodationBloc>().add(
                          AccommodationUpdateEvent(
                            _accommodationId ?? 0, 
                            accommodationRequestModel!)
                          );
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

  Widget _buildPage5() {
    return (Text(
      _titles[_currentPage],
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
