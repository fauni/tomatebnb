import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_clean_calendar/controllers/clean_calendar_controller.dart';
import 'package:scrollable_clean_calendar/scrollable_clean_calendar.dart';
import 'package:scrollable_clean_calendar/utils/enums.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tomatebnb/models/accommodation/accommodation_response_complete_model.dart';
import 'package:tomatebnb/ui/widgets/item_list_anuncio.dart';
import 'package:tomatebnb/utils/Colors.dart';
import 'package:tomatebnb/utils/customwidget.dart';
import 'package:tomatebnb/utils/dark_lightmode.dart';

class CreateReservePage extends StatefulWidget {
  const CreateReservePage({super.key});

  @override
  State<CreateReservePage> createState() => _CreateReservePageState();
}

class _CreateReservePageState extends State<CreateReservePage> {
 CalendarFormat _calendarFormat = CalendarFormat.month;
 RangeSelectionMode _rangeSelectionMode = RangeSelectionMode
      .toggledOn;
  
  int _counter = 0;
  int _counter1 = 0;
  int _counter2 = 0;
  int _nights=0;

  String _selectedDate = '';
  String _dateCount = '';
  String _range = '';
  String _rangeCount = '';
  DateTime? _selectedDay=DateTime.now();
  DateTime? _focusedDay=DateTime.now() ;
  DateTime? _rangeStart=DateTime.now();
  DateTime? _rangeEnd=DateTime.now();

  bool isChecked = false;
  bool isChecked1 = false;

 

  @override
  void initState() {
    getdarkmodepreviousstate();
    super.initState();
  }

  late AccommodationResponseCompleteModel _accommodation =
      AccommodationResponseCompleteModel();
  late ColorNotifire notifire;

  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    _accommodation = GoRouterState.of(context).extra as AccommodationResponseCompleteModel;
    _nights = daysBetween(_accommodation.createdAt??DateTime.now(), _accommodation.updatedAt??DateTime.now());
    return Scaffold(
      backgroundColor: notifire.getbgcolor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(75),
        child: CustomAppbar(
          centertext: "Reservar",
          ActionIcon: Icons.more_vert,
          bgcolor: notifire.getbgcolor,
          actioniconcolor: notifire.getwhiteblackcolor,
          leadingiconcolor: notifire.getwhiteblackcolor,
          titlecolor: notifire.getwhiteblackcolor,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ItemListAnuncio(anuncio: _accommodation),
              const SizedBox(height: 15),
              Row(children: <Widget>[
                  Text(
             "Fechas",
              style: TextStyle(
              fontSize: 16,
              color: notifire.getwhiteblackcolor,
              fontFamily: "Gilroy Bold"),
              ),
               
              ],),
               Text(
             "${_accommodation.createdAt.toString().substring(0,10)} - ${_accommodation.updatedAt.toString().substring(0,10)}",
              style: TextStyle(
              fontSize: 16,
              color: notifire.getwhiteblackcolor,
              fontFamily: "Gilroy Bold"),
              ),
        //      TableCalendar(
               
        //         firstDay: DateTime.now(),
        //         lastDay: DateTime.now().add(Duration(days: 365)),
        //         focusedDay: DateTime.now().add(Duration(days: 5)),
        //         selectedDayPredicate: (day) {
        //           if(day.day >21 && day.day <25){
        //             return false;
        //           }else{
        //             return true;
        //           }
        //           // return isSameDay(_selectedDay, day);
        //         },
        //          rangeStartDay: _rangeStart,
        //         rangeEndDay: _rangeEnd,
        //         calendarFormat: _calendarFormat,
        //         rangeSelectionMode: _rangeSelectionMode,
        //         onDaySelected: (selectedDay, focusedDay) {
        //             if (!isSameDay(_selectedDay, selectedDay)) {
        //               setState(() {
        //                 _selectedDay = selectedDay;
        //                 _focusedDay = focusedDay;
        //                 _rangeStart = null; // Important to clean those
        //                 _rangeEnd = null;
        //                 _rangeSelectionMode = RangeSelectionMode.toggledOff;
        //               });
        //             }
        //         },
        //          onRangeSelected: (start, end, focusedDay) {
        //           setState(() {
        //             _selectedDay = null;
        //             _focusedDay = focusedDay;
        //             _rangeStart = start;
        //             _rangeEnd = end;
        //             _rangeSelectionMode = RangeSelectionMode.toggledOn;
        //             print(_rangeStart);
        //             print(_rangeEnd);
        //           });
        //         },
        //          onFormatChanged: (format) {
        //   if (_calendarFormat != format) {
        //     setState(() {
        //       _calendarFormat = format;
        //     });
        //   }
        // },
        //       ),
             
              const SizedBox(height: 10),
          //      Text(
          // "Huespedes",
          //     style: TextStyle(
          //         fontSize: 16,
          //         color: notifire.getwhiteblackcolor,
          //         fontFamily: "Gilroy Bold"),
          //   ),
             SizedBox(height: MediaQuery.of(context).size.height * 0.025),
                  Room(
                      text: "Huespedes",
                      titletext: "Mayores de 5 años",
                      onclick1: () {
                        setState(() {
                          if(_counter2>1){
                            _counter2--;
                          }
                        });
                      },
                      middeltext: "$_counter2",
                      onclick2: () {
                        setState(() {
                          if(_counter2 < (_accommodation.guestCapacity ?? 0)){
                            _counter2++;
                          }
                        });
                      }),
                  
              SizedBox(height: MediaQuery.of(context).size.height * 0.04),
              Divider(
                color: notifire.getgreycolor,
                thickness: 1,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Detalles del costo",
                      style: TextStyle(
                          fontSize: 16,
                          color: notifire.getwhiteblackcolor,
                          fontFamily: "Gilroy Bold")),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "\$${_accommodation.prices?.first.priceNight } x $_nights Nights",
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: "Gilroy Medium",
                            color: notifire.getgreycolor),
                      ),
                      Text(
                        "\$${_accommodation.prices!.first.priceNight*_nights}",
                        style: TextStyle(
                            fontSize: 14,
                            color: notifire.getgreycolor,
                            fontFamily: "Gilroy Medium"),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Text("Costo de limpieza",
                  //         style: TextStyle(
                  //             fontSize: 14,
                  //             fontFamily: "Gilroy Medium",
                  //             color: notifire.getgreycolor)),
                  //     Text("\$0",
                  //         style: TextStyle(
                  //             fontSize: 14,
                  //             fontFamily: "Gilroy Medium",
                  //             color: notifire.getgreycolor)),
                  //   ],
                  // ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Total (Bs.)",
                          style: TextStyle(
                              fontFamily: "Gilroy Bold",
                              color: notifire.getwhiteblackcolor,),),
                      Text("\$${_accommodation.prices!.first.priceNight*_nights}",
                          style: TextStyle(
                              fontFamily: "Gilroy Bold",
                              color: notifire.getwhiteblackcolor,),),
                    ],
                  ),

                ],
              ),
            ],
          ),
        ),
      ),
      resizeToAvoidBottomInset: false,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: InkWell(
        onTap: paymentmodelbottomsheet,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15,0,15,30),
          child: Container(
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Darkblue),
            child: Center(
              child: Text("Select Payment",
                style: TextStyle(
                  fontSize: 16,
                  color: WhiteColor,
                  fontFamily: "Gilroy Bold",),),
            ),
          ),
        ),
      ),
    );
  }

  guestbottomsheet() {
    return showModalBottomSheet(
      backgroundColor: notifire.getbgcolor,
      isScrollControlled: true,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
        ),
      ),
      builder: (context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.45,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Cantidad de Huespedes",
                        style: TextStyle(
                            fontFamily: "Gilroy Bold",
                            fontSize: 18,
                            color: notifire.getwhiteblackcolor),
                      ),
                      InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Icon(
                            Icons.close,
                            color: notifire.getwhiteblackcolor,
                          ),),
                    ],
                  ),
                 
                  SizedBox(height: MediaQuery.of(context).size.height * 0.025),
                 
                  // SizedBox(height: MediaQuery.of(context).size.height * 0.025),
                  // Room(
                  //     text: "Childern",
                  //     titletext: "Age 2 - 12",
                  //     onclick1: () {
                  //       setState(() {
                  //         _counter2--;
                  //       });
                  //     },
                  //     middeltext: "$_counter2",
                  //     onclick2: () {
                  //       setState(() {
                  //         _counter2++;
                  //       });
                  //     }),
                  Spacer(),
                  AppButton(
                    context: context,
                    buttontext: "Save",
                    onclick: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              ),
            ),
          );
        
        });
      },
    );
  }

  Room({text, titletext, onclick1, onclick2, middeltext}) {
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
                    middeltext,
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

 
  paymentmodelbottomsheet() {
    return showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: notifire.getbgcolor,
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.55,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Payment Method",
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
                        const SizedBox(height: 20),
                        Container(
                          height: 60,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: notifire.getdarkmodecolor),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 6),
                            child: Row(
                              children: [
                                const SizedBox(width: 10),
                                Image.asset(
                                  "assets/images/mastercard.png",
                                  height: 25,
                                ),
                                const SizedBox(width: 15),
                                Text(
                                  "Master Card",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: "Gilroy Bold",
                                      color: notifire.getwhiteblackcolor),
                                ),
                                Spacer(),
                                Theme(
                                  data: ThemeData(
                                      unselectedWidgetColor:
                                          notifire.getdarkwhitecolor),
                                  child: Checkbox(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5)),
                                    value: isChecked,
                                    onChanged: (value) {
                                      setState(() {
                                        isChecked = value!;
                                      });
                                    },
                                  ),
                                ),
                                const SizedBox(width: 15),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.03),
                        Container(
                          height: 60,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: notifire.getdarkmodecolor),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 6),
                            child: Row(
                              children: [
                                const SizedBox(width: 10),
                                Image.asset(
                                  "assets/images/Visa.png",
                                  height: 25,
                                ),
                                const SizedBox(width: 15),
                                Text(
                                  "Visa",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: "Gilroy Bold",
                                      color: notifire.getwhiteblackcolor),
                                ),
                                Spacer(),
                                Theme(
                                  data: ThemeData(
                                      unselectedWidgetColor:
                                          notifire.getdarkwhitecolor),
                                  child: Checkbox(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5)),
                                    value: isChecked1,
                                    onChanged: (value) {
                                      setState(() {
                                        isChecked1 = value!;
                                      });
                                    },
                                  ),
                                ),
                                const SizedBox(width: 15),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.03),
                        Container(
                          height: 60,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: notifire.getdarkmodecolor),
                          child: Row(
                            children: [
                              const SizedBox(width: 15),
                              Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: notifire.getgreycolor),
                                child: Center(
                                  child: CircleAvatar(
                                      backgroundColor:
                                          notifire.getdarkbluecolor,
                                      radius: 14,
                                      child: Image.asset(
                                          "assets/images/add.png",
                                          height: 25)),
                                ),
                              ),
                              const SizedBox(width: 15),
                              Text(
                                "Add Debit Card",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: "Gilroy Bold",
                                  color: notifire.getwhiteblackcolor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Spacer(),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.12),
                        AppButton(
                          context:context,
                          buttontext: "Confirm and Pay",
                          onclick: BookingSuccessfull,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            );
          });
        });
  }

  BookingSuccessfull() {
    return showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: notifire.getbgcolor,
        context: context,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        builder: (context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.60,
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Positioned(
                        top: 20,
                        child: CircleAvatar(
                          radius: 70,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(200),
                            child: Image.asset(
                                'assets/images/BookingSuccessfull.png'),
                          ),
                        ),
                      ),
                      Positioned(
                        top: -28,
                        right: 50,
                        child: Image.asset(
                          'assets/images/Success.png',
                          height: 160,
                        ),
                      ),
                      Positioned(
                        bottom: 100,
                        child: Column(
                          children: [
                            Center(
                              child: Text(
                                "Booking Successfull",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: "Gilroy Bold",
                                    color: notifire.getwhiteblackcolor),
                              ),
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 1,
                              child: Text(
                                "Congratulations! Please check in on the appropriate date. Enjoy your trip!",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: notifire.getgreycolor,
                                    fontFamily: "Gilroy Medium"),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          // selectedIndex = 0;
                          // Navigator.of(context).push(MaterialPageRoute(
                          //     builder: (context) => const homepage()));
                        },
                        child: Container(
                          margin: const EdgeInsets.only(
                              top: 300, left: 20, right: 20),
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Darkblue,
                          ),
                          child: Center(
                              child: Text("Close",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: WhiteColor,
                                      fontFamily: "Gilroy Bold"))),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            );
          });
        });
  }

  // PaymentCard(
  //     {Function(bool?)? OnChage, String? image, CardName, bool? check}) {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //     children: [
  //       Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceAround,
  //         children: [
  //           Image.asset(
  //             image!,
  //             height: 25,
  //           ),
  //           Text(
  //             CardName,
  //             style: TextStyle(fontSize: 15, fontFamily: "Gilroy Bold"),
  //           ),
  //         ],
  //       ),
  //       SizedBox(width: 25),

  //       // SizedBox(width: MediaQuery.of(context).size.width / 2.61),
  //       Row(
  //         children: [
  //           Checkbox(
  //               shape: RoundedRectangleBorder(
  //                   borderRadius: BorderRadius.circular(5)),
  //               value: check,
  //               activeColor: Darkblue,
  //               onChanged: OnChage!),
  //         ],
  //       ),
  //     ],
  //   );
  // }
  getdarkmodepreviousstate() async {
    final prefs = await SharedPreferences.getInstance();
    bool? previusstate = prefs.getBool("setIsDark");
    if (previusstate == null) {
      notifire.setIsDark = false;
    } else {
      notifire.setIsDark = previusstate;
    }
  }
   void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      if (args.value is PickerDateRange) {
        _range = '${args.value.startDate} -'
            // ignore: lines_longer_than_80_chars
            ' ${args.value.endDate ?? args.value.startDate}';
      } else if (args.value is DateTime) {
        _selectedDate = args.value.toString();
      } else if (args.value is List<DateTime>) {
        _dateCount = args.value.length.toString();
      } else {
        _rangeCount = args.value.length.toString();
      }
    });
     
  }
  int daysBetween(DateTime from, DateTime to) {
     from = DateTime(from.year, from.month, from.day);
     to = DateTime(to.year, to.month, to.day);
   return (to.difference(from).inHours / 24).round();
  }
}