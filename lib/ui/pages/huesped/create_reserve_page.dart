import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tomatebnb/bloc/export_blocs.dart';
import 'package:tomatebnb/config/app_colors.dart';
import 'package:tomatebnb/models/accommodation/accommodation_response_complete_model.dart';
import 'package:tomatebnb/models/reserve/reserve_request_model.dart';
import 'package:tomatebnb/ui/widgets/item_list_anuncio.dart';
import 'package:tomatebnb/utils/Colors.dart';
import 'package:tomatebnb/utils/customwidget.dart';

class CreateReservePage extends StatefulWidget {
  const CreateReservePage({super.key});

  @override
  State<CreateReservePage> createState() => _CreateReservePageState();
}

class _CreateReservePageState extends State<CreateReservePage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOn;

  int _counter = 0;
  int _counter1 = 0;
  int _counter2 = 0;
  int _nights = 0;

  String _selectedDate = '';
  String _dateCount = '';
  String _range = '';
  String _rangeCount = '';
  DateTime? _selectedDay = DateTime.now();
  DateTime? _focusedDay = DateTime.now();
  DateTime? _rangeStart = DateTime.now();
  DateTime? _rangeEnd = DateTime.now();

  bool isChecked = false;
  bool isChecked1 = false;

  @override
  void initState() {
    super.initState();
  }

  late AccommodationResponseCompleteModel _accommodation =
      AccommodationResponseCompleteModel();
  ReserveRequestModel reserveRequest = ReserveRequestModel();

  @override
  Widget build(BuildContext context) {
    _accommodation =
        GoRouterState.of(context).extra as AccommodationResponseCompleteModel;
    _nights = daysBetween(_accommodation.createdAt ?? DateTime.now(),
        _accommodation.updatedAt ?? DateTime.now());
    return Scaffold(
      // backgroundColor: AppColors().bgcolor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(75),
        child: CustomAppbar(
          centertext: "Detalle de la Reserva",
          // ActionIcon: Icons.more_vert,
          // bgcolor: AppColors().bgcolor,
          // actioniconcolor: notifire.getwhiteblackcolor,
          // leadingiconcolor: notifire.getwhiteblackcolor,
          // titlecolor: notifire.getwhiteblackcolor,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ItemListAnuncio(anuncio: _accommodation),
              // const SizedBox(height: 15),
              Row(
                children: <Widget>[
                  Text(
                    "Fechas",
                    style: TextStyle(fontSize: 16, fontFamily: "Gilroy Bold"),
                  ),
                ],
              ),
              Container(
                height: 40,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withAlpha(10),
                  borderRadius: BorderRadius.circular(8),
                  // color: notifire.getdarkmodecolor
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "del",
                      style: TextStyle(fontSize: 16, fontFamily: "Gilroy"),
                    ),
                    Text(
                      "${_accommodation.createdAt?.day}/ ${_accommodation.createdAt?.month}/ ${_accommodation.createdAt?.year}",
                      style: TextStyle(fontSize: 16, fontFamily: "Gilroy"),
                    ),
                    Text(
                      "al",
                      style: TextStyle(fontSize: 16, fontFamily: "Gilroy"),
                    ),
                    Text(
                      " ${_accommodation.updatedAt?.day}/ ${_accommodation.updatedAt?.month}/ ${_accommodation.updatedAt?.year}",
                      style: TextStyle(fontSize: 16, fontFamily: "Gilroy"),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Room(
                  text: "Cantidad de Huespedes",
                  titletext: "Mayores de 5 años",
                  onclick1: () {
                    setState(() {
                      if (_counter2 > 1) {
                        _counter2--;
                      }
                    });
                  },
                  middeltext: "$_counter2",
                  onclick2: () {
                    setState(() {
                      if (_counter2 < (_accommodation.guestCapacity ?? 0)) {
                        _counter2++;
                      }
                    });
                  }),
              Divider(
                thickness: 1,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Detalles del costo",
                      style:
                          TextStyle(fontSize: 16, fontFamily: "Gilroy Bold")),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "\$${_accommodation.prices?.first.priceNight} x $_nights Nights",
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: "Gilroy Medium",
                        ),
                      ),
                      Text(
                        "\BS ${_accommodation.prices!.first.priceNight * _nights}",
                        style: TextStyle(
                            fontSize: 14, fontFamily: "Gilroy Medium"),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total (BS)",
                        style: TextStyle(
                          fontFamily: "Gilroy Bold",
                          // color: notifire.getwhiteblackcolor,
                        ),
                      ),
                      Text(
                        "\BS ${_accommodation.prices!.first.priceNight * _nights}",
                        style: TextStyle(
                          fontFamily: "Gilroy Bold",
                          // color: notifire.getwhiteblackcolor,
                        ),
                      ),
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
      floatingActionButton: BlocConsumer<ReserveBloc, ReserveState>(
        listener: (context, state) {
          // TODO: implement listener
          if(state is ReserveCreateError){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.message),
              backgroundColor: Theme.of(context).colorScheme.error,
            ));
          }
          if (state is ReserveCreateSuccess) {
            bookingSuccessfull(state.responseReserve.id??0 );
          }
        },
        builder: (context, state) {
          if (state is ReserveCreateLoading) {
            return Center(child: CircularProgressIndicator());
          }else{
              return InkWell(
            // onTap: ()=> context.push('/payment', extra: 1),
            onTap: () {
              reserveRequest.accommodationId = _accommodation.id;
              reserveRequest.startDate = _accommodation.createdAt;
              reserveRequest.endDate = _accommodation.updatedAt;
              reserveRequest.numberGuests = _counter2;
              reserveRequest.totalPrice =
              _accommodation.prices!.first.priceNight * _nights;
              reserveRequest.cashDiscount = 0;
              reserveRequest.commission = 0;
              reserveRequest.state = 'pendiente';
              context
                  .read<ReserveBloc>()
                  .add(ReserveCreateEvent(reserveRequest));
            },

            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 30),
              child: Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Theme.of(context).colorScheme.primary),
                child: Center(
                  child: Text(
                    "Reservar",
                    style: TextStyle(
                      fontSize: 16,
                      color: WhiteColor,
                      fontFamily: "Gilroy Bold",
                    ),
                  ),
                ),
              ),
            ),
          );
        

          }
                
        },
      ),
    );
  }

  guestbottomsheet() {
    return showModalBottomSheet(
      backgroundColor: AppColors().bgcolor,
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
                          // color: notifire.getwhiteblackcolor
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Icon(
                          Icons.close,
                          // color: notifire.getwhiteblackcolor,
                        ),
                      ),
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
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(text,
                style: TextStyle(
                    fontSize: 16,
                    // color: notifire.getwhiteblackcolor,
                    fontFamily: "Gilroy Bold")),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                children: [
                  InkWell(
                    onTap: onclick1,
                    child: CircleAvatar(
                      // backgroundColor: notifire.getblackgreycolor,
                      radius: 12,
                      child: Icon(Icons.remove,
                          // color: notifire.getdarkwhitecolor,
                          size: 20),
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    middeltext,
                    style: TextStyle(
                        // color: notifire.getwhiteblackcolor
                        ),
                  ),
                  const SizedBox(width: 5),
                  InkWell(
                    onTap: onclick2,
                    child: CircleAvatar(
                      // backgroundColor: notifire.getdarkbluecolor,
                      radius: 12,
                      child: Icon(Icons.add,
                          // color: notifire.getdarkwhitecolor,
                          size: 20),
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
              // color: notifire.getgreycolor,
              fontFamily: "Gilroy Medium"),
        ),
      ],
    );
  }

  paymentmodelbottomsheet() {
    return showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: AppColors().bgcolor,
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
              height: MediaQuery.of(context).size.height * 0.65,
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
                              "Metodo de pago",
                              style: TextStyle(
                                fontSize: 18,
                                fontFamily: "Gilroy Bold",
                                // color: notifire.getwhiteblackcolor
                              ),
                            ),
                            InkWell(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: Icon(
                                  Icons.close,
                                  // color: notifire.getwhiteblackcolor,
                                ))
                          ],
                        ),
                        const SizedBox(height: 20),
                        Container(
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            // color: notifire.getdarkmodecolor
                          ),
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
                                    // color: notifire.getwhiteblackcolor
                                  ),
                                ),
                                Spacer(),
                                Theme(
                                  data: ThemeData(
                                      // unselectedWidgetColor: notifire.getdarkwhitecolor
                                      ),
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
                            // color: notifire.getdarkmodecolor
                          ),
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
                                    // color: notifire.getwhiteblackcolor
                                  ),
                                ),
                                Spacer(),
                                Theme(
                                  data: ThemeData(
                                      // unselectedWidgetColor: notifire.getdarkwhitecolor
                                      ),
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
                            // color: notifire.getdarkmodecolor
                          ),
                          child: Row(
                            children: [
                              const SizedBox(width: 15),
                              Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  // color: notifire.getgreycolor
                                ),
                                child: Center(
                                  child: CircleAvatar(
                                      // backgroundColor: notifire.getdarkbluecolor,
                                      radius: 14,
                                      child: Image.asset(
                                          "assets/images/add.png",
                                          height: 25)),
                                ),
                              ),
                              const SizedBox(width: 15),
                              Text(
                                "Agregar Tarjeta de débito",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: "Gilroy Bold",
                                  // color: notifire.getwhiteblackcolor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Spacer(),
                        // SizedBox(
                        //     height: MediaQuery.of(context).size.height * 0.1),
                        BlocConsumer<ReserveBloc, ReserveState>(
                          listener: (context, state) {
                            if (state is ReserveCreateError) {
                              Navigator.of(context).pop();
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text(state.message),
                                backgroundColor:
                                    Theme.of(context).colorScheme.error,
                              ));
                            }
                            if (state is ReserveCreateSuccess) {
                              bookingSuccessfull(0);
                            }
                          },
                          builder: (context, state) {
                            if (state is ReserveCreateLoading) {
                              return Center(child: CircularProgressIndicator());
                            }
                            return AppButton(
                                context: context,
                                buttontext: "Confirmar y pagar",
                                onclick: () {
                                  reserveRequest.accommodationId =
                                      _accommodation.id;
                                  reserveRequest.startDate =
                                      _accommodation.createdAt;
                                  reserveRequest.endDate =
                                      _accommodation.updatedAt;
                                  reserveRequest.numberGuests = _counter2;
                                  reserveRequest.totalPrice =
                                      _accommodation.prices!.first.priceNight *
                                          _nights;
                                  reserveRequest.cashDiscount = 0;
                                  reserveRequest.commission = 0;
                                  reserveRequest.state = 'pendiente';
                                  context
                                      .read<ReserveBloc>()
                                      .add(ReserveCreateEvent(reserveRequest));
                                }

                                // BookingSuccessfull,
                                );
                          },
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

  bookingSuccessfull(int reserveId) {
    return showModalBottomSheet(
        isDismissible: false,
        isScrollControlled: true,
        backgroundColor: AppColors().bgcolor,
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
                        bottom: 150,
                        child: Column(
                          children: [
                            Center(
                              child: Text(
                                "Reserva creada",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: "Gilroy Bold",
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 1,
                              child: Text(
                                "¡Felicitaciones!, se ha registrado su reserva en la fecha correspondiente. ¿Desea continuar con el pago?",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: "Gilroy Medium"),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          context.pop();
                          context.pop();
                          context.replace('/menu-viajero');
                        },
                        child: Container(
                          margin: const EdgeInsets.only(
                              top: 380, left: 20, right: 20),
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.transparent,
                          ),
                          child: Center(
                              child: Text("Todavía no",
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Theme.of(context).colorScheme.primary,
                                      fontFamily: "Gilroy Bold"))),
                        ),
                      ),
                      
                      InkWell(
                        onTap: () {
                          
                          context.pop();
                          context.pop();
                          context.replace('/payment', extra: reserveId);
                          // context.replace('/menu-viajero');
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
                              child: Text("Realizar Pago",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: WhiteColor,
                                      fontFamily: "Gilroy Bold"))),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          });
        });
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
    return ((to.difference(from).inHours / 24).round()) + 1;
  }
}
