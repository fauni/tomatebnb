import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:scrollable_clean_calendar/utils/extensions.dart';
import 'package:tomatebnb/bloc/export_blocs.dart';
import 'package:tomatebnb/models/reserve/event_request_model.dart';
import 'package:tomatebnb/models/reserve/event_response_model.dart';
import 'package:tomatebnb/models/reserve/reserve_response_model.dart';
import 'package:tomatebnb/utils/customwidget.dart';

class CheckinPage extends StatefulWidget {
  const CheckinPage({super.key});

  @override
  State<CheckinPage> createState() => _CheckinPageState();
}

class _CheckinPageState extends State<CheckinPage> {
  late ReserveResponseModel _reserve;
  final TextEditingController obsController = TextEditingController();
  List<EventResponseModel> _events = [];
  @override
  Widget build(BuildContext context) {
    _reserve = GoRouterState.of(context).extra as ReserveResponseModel;
    context.read<EventBloc>().add(EventGetByReserveEvent(_reserve.id!));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Eventos de Reserva'),
      ),
      body: 
           BlocConsumer<EventBloc, EventState>(
              listener: (context, state) {
                if (state is EventGetByReserveSuccess) {
                  // Handle success state
                  _events = state.responseEvents;
                }
                if (state is EventGetByReserveError) {
                  // Show error message
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      backgroundColor: Theme.of(context).colorScheme.error,
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state is EventGetByReserveLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is EventGetByReserveSuccess) {
                   _events = state.responseEvents;
                  return Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: _events.length,
                          itemBuilder: (context, index) {
                            return  
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        decoration:  BoxDecoration(
                          color: Theme.of(context).colorScheme.surfaceContainer,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                              height: 75,
                              width: 75,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Icon(Icons.error),
                                // child: Image.network(
                                //   'https://asda', // state.responseReserve.accommodation.photos![0].url,
                                //   errorBuilder: (context, error, stackTrace) {
                                //     return const Icon(Icons.error);
                                //   },
                                //   width: 100,
                                //   height: 100,
                                //   fit: BoxFit.cover,
                                // ),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  state.responseEvents[index].type!,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: "Gilroy Bold",
                                    color: Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.65,
                                  child: Text(
                                    state.responseEvents[index].note!,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: "Gilroy",
                                      color: Theme.of(context).colorScheme.secondary,
                                      overflow: TextOverflow.ellipsis
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        // Text('${state.responseReserve.accommodation.prices![0].priceNight} BS', style: TextStyle(fontSize: 16, color: Theme.of(context).colorScheme.primary)),
                                         Text('${state.responseEvents[index].eventDate?.toLocal() }', style: TextStyle(fontSize: 16, color: Theme.of(context).colorScheme.primary)),
                                        //Text('/Total', )
                                      ],
                                    ),
                                    // Row(
                                    //   children: [
                                    //     const SizedBox(width:12),
                                    //     Image.asset("assets/images/star.png", height: 20,),
                                    //     const SizedBox(width: 2),
                                    //     Padding(
                                    //       padding: const EdgeInsets.only(top: 4),
                                    //       child: Row(
                                    //         children: [
                                    //           Text('4.5', style: TextStyle(fontSize: 16, color: Theme.of(context).colorScheme.inversePrimary, fontWeight: FontWeight.bold),)
                                    //         ],
                                    //       ),
                                    //     )
                                    //   ],
                                    // )
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                                
                      );
                          },
                        ),
                      ),
              _events.isEmpty
                  ? Padding(
                      padding: EdgeInsets.all(12.0),
                      child: AppButton(
                        context: context,
                        buttontext: "Checkin",
                        onclick: () {
                          bottomsheet("Checkin");
                        },
                      ),
                    )
                  : _events.length == 1 && _events[0].type == "Checkout"
              ? Padding(
                  padding: EdgeInsets.all(12.0),
                  child: AppButton(
                    context: context,
                    buttontext: "Checkin",
                    onclick: () {
                      bottomsheet("Checkin");
                    },
                  ),
                )
              : _events.length == 1 && _events[0].type == "Checkin"
                  ? Padding(
                      padding: EdgeInsets.all(12.0),
                      child: AppButton(
                        context: context,
                        buttontext: "Checkout",
                        onclick: () {
                          bottomsheet("Checkout");
                        },
                      ),
                    )
                  : Container(),
                    ],
                  );
                }
                if (state is EventGetByReserveError) {
                  return Center(
                    child: Text(state.message),
                  );
                }
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text('Checkin Page'),
                    ],
                  ),
                );
              },
            ),
          
    );
  }

  bottomsheet(String title) {
    return showModalBottomSheet(
        backgroundColor: Colors.transparent,
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
                          title,
                          style: TextStyle(
                              fontSize: 18,
                              fontFamily: "Gilroy Bold",
                              color: Colors.white),
                        ),
                        InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Icon(
                              Icons.close,
                              color: Colors.white,
                            ))
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                    Text(
                      "Observaciones",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontFamily: "Gilroy Bold"),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                      ),
                      child: TextField(
                        controller: obsController,
                        minLines: 3,
                        maxLines: 5,
                        decoration: InputDecoration(
                          hintText:
                              "Observaciones al momento de realizar el $title",
                          hintStyle: TextStyle(
                            color: Colors.grey,
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
                    Divider(
                      color: Colors.grey,
                    ),
                    BlocConsumer<EventBloc, EventState>(
                      listener: (context, state) {
                        // TODO: implement listener
                        if (state is EventCreateError) {
                          Navigator.of(context).pop();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(state.message),
                              backgroundColor:
                                  Theme.of(context).colorScheme.error,
                            ),
                          );
                        }
                        if (state is EventCreateSuccess) {
                          Navigator.of(context).pop();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("$title registrado"),
                              backgroundColor:
                                  Theme.of(context).colorScheme.primary,
                            ),
                          );
                        }
                      },
                      builder: (context, state) {
                        if (state is EventCreateLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: GestureDetector(
                            onTap:
                                // adressController.text.isEmpty ||
                                //         cityController.text.isEmpty ||
                                //         countryController.text.isEmpty
                                //     ? null
                                //     :
                                () {
                              // Navigator.of(context).pop();
                              EventRequestModel event = EventRequestModel(
                                  type: title,
                                  note: obsController.text,
                                  eventDate: DateTime.now(),
                                  reserveId: _reserve.id!);
                              context
                                  .read<EventBloc>()
                                  .add(EventCreateEvent(event));
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    borderRadius: BorderRadius.circular(25)),
                                height: 50,
                                width: MediaQuery.of(context).size.width * 0.5,
                                child: Center(
                                  child: Text(
                                    "Registrar $title",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontFamily: "Gilroy Bold"),
                                  ),
                                )),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          });
        });
  }
}
