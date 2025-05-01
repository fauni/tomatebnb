import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:scrollable_clean_calendar/utils/extensions.dart';
import 'package:tomatebnb/bloc/export_blocs.dart';
import 'package:tomatebnb/models/reserve/reserve_response_model.dart';
import 'package:tomatebnb/utils/customwidget.dart';

class ReserveDetailPage extends StatefulWidget {
  ReserveResponseModel reserva;
  ReserveDetailPage({super.key, required this.reserva});

  @override
  State<ReserveDetailPage> createState() => _ReserveDetailPageState();
}

class _ReserveDetailPageState extends State<ReserveDetailPage> {
  @override
  void initState() {
    super.initState();
    cargarReservaPorId();
  }

  
   int _nights=0;

  cargarReservaPorId(){
    context.read<ReserveBloc>().add(ReserveGetByIdEvent(widget.reserva.id!));
  }
  @override
  Widget build(BuildContext context) {
    context.read<ReserveBloc>().add(ReserveGetByIdEvent(widget.reserva.id!));
_nights = daysBetween(widget.reserva.startDate ?? DateTime.now(),
        widget.reserva.endDate ?? DateTime.now());
   
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(75),
        child: CustomAppbar(
          centertext: "Detalle de la Reserva"
        ),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        child: BlocConsumer<ReserveBloc, ReserveState>(
          listener: (context, state) {
            // if(state is ReserveGetByIdSuccess){
            //   widget.reserva = state.responseReserve;
            // }
          },
          builder: (context, state) {
            if(state is ReserveGetByIdLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if(state is ReserveGetByIdError) {
              return Center(
                child: Text(state.message),
              );
            } else if (state is ReserveGetByIdSuccess) {
              return Column(
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      
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
                                  state.responseReserve.accommodation!.title!,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: "Gilroy Bold",
                                    color: Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.65,
                                  child: Text(
                                    state.responseReserve.accommodation!.description!,
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
                                        Text('${state.responseReserve.totalPrice} BS', style: TextStyle(fontSize: 16, color: Theme.of(context).colorScheme.primary)),
                                        Text('/Total', )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const SizedBox(width:12),
                                        Image.asset("assets/images/star.png", height: 20,),
                                        const SizedBox(width: 2),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 4),
                                          child: Row(
                                            children: [
                                              Text('4.5', style: TextStyle(fontSize: 16, color: Theme.of(context).colorScheme.inversePrimary, fontWeight: FontWeight.bold),)
                                            ],
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                                
                      ),
                     
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Cantidad de Huespedes:",
                            style: TextStyle(
                              fontFamily: "Gilroy Bold",
                              // color: notifire.getwhiteblackcolor,
                            ),
                          ),
                          Text(
                            '${widget.reserva.numberGuests}',
                            style: TextStyle(
                              fontFamily: "Gilroy",
                              // color: notifire.getwhiteblackcolor,
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Fecha Desde:",
                            style: TextStyle(
                              fontFamily: "Gilroy Bold",
                              // color: notifire.getwhiteblackcolor,
                            ),
                          ),
                          Text(
                            DateFormat('dd/MM/yyyy')
                                .format(widget.reserva.startDate!),
                            style: TextStyle(
                              fontFamily: "Gilroy",
                              // color: notifire.getwhiteblackcolor,
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Fecha Hasta:",
                            style: TextStyle(
                              fontFamily: "Gilroy Bold",
                              // color: notifire.getwhiteblackcolor,
                            ),
                          ),
                          Text(
                            DateFormat('dd/MM/yyyy')
                                .format(widget.reserva.endDate!),
                            style: TextStyle(
                              fontFamily: "Gilroy",
                              // color: notifire.getwhiteblackcolor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 1,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Detalle del Pago",
                              style: TextStyle(
                                  fontSize: 16, fontFamily: "Gilroy Bold")),
                          const SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${_nights} Noches",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: "Gilroy Medium",
                                  color: Theme.of(context).colorScheme.secondary,
                                ),
                              ),
                              Text(
                                "${widget.reserva.totalPrice} BS",
                                style: TextStyle(
                                    fontSize: 14,
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    fontFamily: "Gilroy Medium"),
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: [
                          //     Text("Cleaning Fee",style: TextStyle(fontSize: 14,fontFamily: "Gilroy Medium",color: Theme.of(context).colorScheme.secondary,)),
                          //     Text("\$4",style: TextStyle(fontSize: 14,fontFamily: "Gilroy Medium",color: Theme.of(context).colorScheme.secondary,)),
                          //   ],
                          // ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Total (Bs.)",
                                style: TextStyle(
                                  fontFamily: "Gilroy Bold",
                                  // color: notifire.getwhiteblackcolor,
                                ),
                              ),
                              Text(
                                "${widget.reserva.totalPrice} BS",
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
                 Divider(
                    thickness: 1,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    widget.reserva.state == "Pagado" 
                                    ?InkWell(
                                      onTap: () {
                                        // if(_accommodationId!=0){
                                        context.push('/instructions_reserve',
                                            extra: widget.reserva);
                                        // }
                                      },
                                      child: Text(
                                            "Ver Instrucciones",
                                            style: TextStyle(
                                                 fontSize: 16,
                                                fontFamily: "Gilroy Bold",
                                                color: Theme.of(context).colorScheme.primary),
                                          ),
                                    ):
                                    Text(
                                          "Pendiente de Pago",
                                          style: TextStyle(
                                                fontSize: 16,
                                                fontFamily: "Gilroy Bold",
                                                color: Theme.of(context).colorScheme.primary),
                                        ),
                                    
                                  ],
                                ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        context.replace('/payment', extra: widget.reserva.id);
                      },
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50),
                          backgroundColor: Theme.of(context).colorScheme.tertiary,
                          foregroundColor: Theme.of(context).colorScheme.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                      child: Text('Realizar Pago')),
                       SizedBox(
                    height: 20,
                  ),
                  widget.reserva.state != "pendiente" &&(widget.reserva.startDate!.isSameDayOrAfter(DateTime.now()))
                  ?ElevatedButton(
                      onPressed: () {
                        context.push('/checkin', extra: widget.reserva);
                      },
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50),
                          backgroundColor: Theme.of(context).colorScheme.tertiary,
                          foregroundColor: Theme.of(context).colorScheme.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                      child: Text('Check In'))
                  :Text(""),
                  SizedBox(
                    height: 20,
                  ),
                ],
              );
            } else {
              return Center(
                child: Text("Reserva ${widget.reserva.id}"),
              );
            }
          },
        ),
      )),
    );
  }
  int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return ((to.difference(from).inHours / 24).round()) + 1;
  }
}
