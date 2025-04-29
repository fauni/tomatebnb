import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tomatebnb/bloc/export_blocs.dart';
import 'package:tomatebnb/models/accommodation/accommodation_instruction_response_model.dart';
import 'package:tomatebnb/models/reserve/reserve_response_model.dart';
import 'package:tomatebnb/utils/Colors.dart';
import 'package:tomatebnb/utils/customwidget.dart';
import 'package:tomatebnb/utils/dark_lightmode.dart';

class InstructionsReservePage extends StatefulWidget {
  const InstructionsReservePage({super.key});

  @override
  State<InstructionsReservePage> createState() =>
      _InstructionsReservePageState();
}

class _InstructionsReservePageState extends State<InstructionsReservePage> {
  List<AccommodationInstructionResponseModel> instructions = [];
  late ReserveResponseModel reserveResponseModel;
  late ColorNotifire notifire;
  TimeOfDay? _selectedTime;
  TimeOfDay? _selectedTimeOut;

  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    reserveResponseModel =
        GoRouterState.of(context).extra as ReserveResponseModel;
    context.read<AccommodationInstructionBloc>().add(
        AccommodationInstructionGetByAccommodationEvent(
            reserveResponseModel.accommodation?.id ?? 0));
    _selectedTime = TimeOfDay.fromDateTime(reserveResponseModel.checkinDate!);
    _selectedTimeOut =
        TimeOfDay.fromDateTime(reserveResponseModel.checkoutDate!);

    return Center(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: notifire.getbgcolor,
          leading: BackButton(color: notifire.getwhiteblackcolor),
          title: Text(
            "Instrucciones",
            style: TextStyle(
                color: notifire.getwhiteblackcolor, fontFamily: "Gilroy Bold"),
          ),
        ),
        backgroundColor: notifire.getbgcolor,
        body: Column(
          children: [
            BlocConsumer<AccommodationInstructionBloc,
                AccommodationInstructionState>(
              listener: (context, state) {
                if (state
                    is AccommodationInstructionGetByAccommodationSuccess) {
                  instructions = state.responseAccommodationInstructions;
                }
                if (state is AccommodationInstructionGetByAccommodationError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state
                    is AccommodationInstructionGetByAccommodationLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (instructions.isEmpty) {
                  return Center(
                    child: Text(
                      "No hay instrucciones disponibles",
                      style: TextStyle(color: notifire.getwhiteblackcolor),
                    ),
                  );
                }
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: instructions.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              decoration: BoxDecoration(
                                color: notifire.getwhiteblackcolor
                                    .withOpacity(0.1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ListTile(
                                title: Text(instructions[index].title ?? "",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      fontFamily: "Gilroy Bold",
                                    )),
                                subtitle: Text(
                                  instructions[index].description ?? "",
                                  maxLines: 5,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: notifire.getwhiteblackcolor,
                                  ),
                                ),
                                leading: index == 0
                                    ? Icon(
                                        Icons.location_searching,
                                        color: notifire.getwhiteblackcolor,
                                      )
                                    : index == 1
                                        ? Icon(
                                            Icons.input,
                                            color: notifire.getwhiteblackcolor,
                                          )
                                        : Icon(
                                            Icons.output,
                                            color: notifire.getwhiteblackcolor,
                                          ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            const SizedBox(
              height: 20,
            ),
            Divider(
              height: 5,
            ),
            BlocConsumer<ReserveBloc, ReserveState>(
              listener: (context, state) {
                if (state is ReserveCheckinSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Actualizado correctamente'),
                      backgroundColor: Colors.green,
                    ),
                  );
                }
                if (state is ReserveCheckinError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
                
              },
              builder: (context, state) {
                if (state is ReserveCheckinLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "Llegaré al lugar a Horas:",
                      style: TextStyle(
                        fontFamily: "Gilroy Bold",
                        // color: notifire.getwhiteblackcolor,
                      ),
                    ),
                    Text(_selectedTime == null
                        ? "Hora no seleccionada"
                        : _selectedTime!.format(context)),
                    IconButton(
                        onPressed: () {
                          _selectTime(context, true);
                        },
                        color: Theme.of(context).colorScheme.secondary,
                        icon: Icon(
                          Icons.share_arrival_time_outlined,
                          color: Theme.of(context).colorScheme.primary,
                          size: 40.0,
                        ))
                  ],
                );
              },
            ),
            Divider(
              height: 5,
            ),
            Divider(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "Dejaré el lugar a Horas:",
                  style: TextStyle(
                    fontFamily: "Gilroy Bold",
                    // color: notifire.getwhiteblackcolor,
                  ),
                ),
                Text(_selectedTime == null
                    ? "Hora no seleccionada"
                    : _selectedTimeOut!.format(context)),
                IconButton(
                    onPressed: () {
                      _selectTime(context, false);
                    },
                    color: Theme.of(context).colorScheme.secondary,
                    icon: Icon(
                      Icons.time_to_leave,
                      color: Theme.of(context).colorScheme.primary,
                      size: 40.0,
                    ))
              ],
            ),
            Divider(
              height: 5,
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              
              child: AppButton(
              context: context,
              buttontext: "Guardar cambios",
              onclick: () {
                context.read<ReserveBloc>().add(ReserveCheckinEvent(
                      reserveResponseModel.id??0,
                      reserveResponseModel.checkinDate!.toIso8601String()
                    ));
                context.read<ReserveBloc>().add(ReserveCheckoutEvent(
                      reserveResponseModel.id??0,
                      reserveResponseModel.checkoutDate!.toIso8601String()
                    ));
              },
            ),
          )
            
          ],
        ),
      ),
    );
  }

  Future<void> _selectTime(BuildContext context, bool checkin) async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (newTime != null) {
      if (checkin) {
        _selectedTime = newTime;
        reserveResponseModel.checkinDate = DateTime(
          reserveResponseModel.startDate!.year,
          reserveResponseModel.startDate!.month,
          reserveResponseModel.startDate!.day,
          _selectedTime!.hour,
          _selectedTime!.minute,
        );
        
      } else {
        _selectedTimeOut = newTime;
        reserveResponseModel.checkoutDate = DateTime(
          reserveResponseModel.endDate!.year,
          reserveResponseModel.endDate!.month,
          reserveResponseModel.endDate!.day,
          _selectedTimeOut!.hour,
          _selectedTimeOut!.minute,
        ).add(Duration(days: 1));
      }
      setState(() {});
    }
  }
}
