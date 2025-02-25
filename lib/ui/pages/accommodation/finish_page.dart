import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tomatebnb/bloc/export_blocs.dart';
import 'package:tomatebnb/models/accommodation/accommodation_request_model.dart';
import 'package:tomatebnb/models/accommodation/accommodation_response_complete_model.dart';
import 'package:tomatebnb/utils/customwidget.dart';

class FinishPage extends StatefulWidget {
  const FinishPage({super.key});

  @override
  State<FinishPage> createState() => _FinishPageState();
}

class _FinishPageState extends State<FinishPage> {
  @override
  void initState() {
    super.initState();
    accommodationResponseModel = AccommodationResponseCompleteModel();
  }

  late int _accommodationId;
  AccommodationRequestModel accommodationRequestModel =
      AccommodationRequestModel();

  late AccommodationResponseCompleteModel? accommodationResponseModel;
  @override
  Widget build(BuildContext context) {
    _accommodationId = GoRouterState.of(context).extra! as int;
    context
        .read<AccommodationBloc>()
        .add(AccommodationGetByIdEvent(_accommodationId ?? 0));

    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.9,
          child: BlocConsumer<AccommodationBloc, AccommodationState>(
            listener: (context, state) {
              if (state is AccommodationGetByIdSuccess) {
                accommodationResponseModel = state.responseAccommodation;
                accommodationRequestModel =
                    accommodationResponseModel!.toRequestModel();
              }
            },
            builder: (context, state) {
              if (state is AccommodationGetByIdLoading) {
                return Center(child: CircularProgressIndicator());
              }

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.02),
                    Padding(
                      padding: const EdgeInsets.symmetric(),
                      child: Text(
                        'Creaste tu anuncion con éxito',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 30,
                            fontFamily: "Gilroy Bold",
                            color: Theme.of(context)
                                .colorScheme
                                .tertiary), //heding Text
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    labelTile('Título'),
                    dataTile(accommodationResponseModel!.title ?? 'Sin título',
                        20.0),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    labelTile('Descripción'),
                    dataTile(
                        accommodationResponseModel!.description ?? 'Sin título',
                        16.0),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    labelTile('Dirección'),
                    dataTile(
                        accommodationResponseModel!.address ?? 'Sin título',
                        16.0),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    labelTile('Ciudad'),
                    dataTile(
                        accommodationResponseModel!.city ?? 'Sin título', 16.0),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    labelTile('País'),
                    dataTile(
                        accommodationResponseModel!.country ?? 'Sin título',
                        16.0),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    labelTile('Capacidad'),
                    dataTile(
                        '${accommodationResponseModel!.guestCapacity} Huespedes',
                        20.0),
                    dataTile(
                        '${accommodationResponseModel!.numberRooms} Recamaras',
                        20.0),
                    dataTile(
                        '${accommodationResponseModel!.numberBathrooms} Baños',
                        20.0),
                    dataTile(
                        '${accommodationResponseModel!.guestCapacity} Camas',
                        20.0),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    labelTile('Tipo de hospedaje'),
                    dataTile(
                        accommodationResponseModel?.type?.name ?? 'Sin título',
                        16.0),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    labelTile('Se ve como un(a)'),
                    dataTile(
                        accommodationResponseModel?.describe?.describe ??
                            'Sin título',
                        16.0),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    BlocListener<AccommodationBloc, AccommodationState>(
                      listener: (context, state) {
                        if (state is AccommodationUpdate2Success){
                          context.pushReplacement('/menu-anfitrion');
                        }
                      },
                      child: Center(
                          child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: AppButton(
                            buttontext: 'Pagina Principal',
                            onclick: () {
                              accommodationRequestModel.priceNight =
                              accommodationResponseModel!.prices!.first.priceNight;
                              
                               context
                                .read<AccommodationBloc>()
                                .add(AccommodationUpdate2Event(_accommodationId,accommodationRequestModel));
                            },
                            context: context),
                      )),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget dataTile(String data, double size) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border(
                top: BorderSide(
                    color: Theme.of(context).colorScheme.tertiary, width: 1.0),
                bottom: BorderSide(
                    color: Theme.of(context).colorScheme.tertiary, width: 1.0),
                left: BorderSide(
                    color: Theme.of(context).colorScheme.tertiary, width: 1.0),
                right: BorderSide(
                    color: Theme.of(context).colorScheme.tertiary, width: 1.0),
              ),
              color: Colors.white),
          child: Column(
            children: [
              ListTile(
                title: Center(
                  child: Text(
                    data,
                    style: TextStyle(
                        fontFamily: "Gilroy Bold",
                        fontSize: size,
                        color: Theme.of(context).colorScheme.primary),
                  ),
                ),
                // isThreeLine: true,
              ),
            ],
          ),
        ));
  }

  Widget labelTile(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Text(
        label,
        style: TextStyle(
            fontSize: 20,
            fontFamily: "Gilroy Bold",
            color: Theme.of(context).colorScheme.primary), //heding Text
      ),
    );
  }
}
