import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
    _pageController =  PageController(initialPage: _currentPage);
    super.initState();
    
  }
  late ColorNotifire notifire;
  PageController _pageController = PageController();
  int _currentPage = 0;
  String accommodationId = "0";
  @override
    Widget build(BuildContext context) {
    accommodationId = GoRouterState.of(context).extra! as String;
    return Scaffold(
      backgroundColor: WhiteColor,
      body: Stack(
        children: <Widget>[
          PageView(
            controller: _pageController,
            onPageChanged: _handlingOnPageChanged,
            physics: const BouncingScrollPhysics(),
            children: [
              _buildPage1(),
              _buildPage2(),
              _buildPage3(),
              _buildPage4(),
              _buildPage5()],
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
                  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 10.0,
                        width: MediaQuery.of(context).size.width * 0.22,
                        child: Container(
                          margin: EdgeInsetsDirectional.only(start: 1.0, end: 10.0),
                          height: 5.0,
                          color: Colors.black
                        ),
                        ),
                        SizedBox(
                        height: 10.0,
                        width: MediaQuery.of(context).size.width * 0.22,
                        child: Container(
                          margin: EdgeInsetsDirectional.only(start: 1.0, end: 10.0),
                          height: 5.0,
                          color: Colors.grey
                        ),
                        ),
                        SizedBox(
                        height: 10.0,
                        width: MediaQuery.of(context).size.width * 0.22,
                        child: Container(
                          margin: EdgeInsetsDirectional.only(start: 1.0, end: 10.0),
                          height: 5.0,
                          color: Colors.grey
                        ),
                        )

                    ],),
                ),
              ],
            ),
          ),
          
        ],
      ),
    );
  }

  Widget _buildDots({int? index,}) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            for(int i=0;i<5;i++)
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
  
  Widget _buildPage1(){
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    return Scaffold(
      backgroundColor: notifire.getbgcolor,
      body: Column(
        children: <Widget>[
          SizedBox(
              height: MediaQuery.of(context).size.height *
                  0.04), //upar thi jagiya mukeli che
          // ignore: sized_box_for_whitespace
          Container(
            height: MediaQuery.of(context).size.height / 1.9, //imagee size
            width: MediaQuery.of(context).size.width,
            child: Image.asset("assets/images/onbording11.png"),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(),
            child: Text(
              "Describe tu espacio $accommodationId",
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
                      )
                                       ),
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
    );
  }

  Widget _buildPage2(){
    return(
      Text("¿Cual de estas opciones describe mejor tu alojamiento?")     
    );
  }
  Widget _buildPage3(){
    return(
      Text("¿Que tipo de alojamiento ofreces a los huespedes?")     
    );
  }

  Widget _buildPage4(){
    return(
      Text("¿Donde se encuentra tu espacio?")     
    );
  }

  Widget _buildPage5(){
    return(
      Text("Agrega algunos datos básicos de tu espacio")     
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