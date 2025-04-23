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
                    SizedBox(width: double.infinity,height: MediaQuery.of(context).size.height * 0.04),
                    Center(child: Image.asset('assets/logos/logo-samay.JPG', height: 100,)),
                    SizedBox(height: 12,),
                    Center(
                      child: Text('Tu anuncio fue creado con éxito',
                        style: TextStyle(fontSize: 20, fontFamily: "Gilroy Bold",color: Theme.of(context).colorScheme.secondary
                        ),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    dataTile(accommodationResponseModel!.title ?? 'Sin título', 14.0),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    dataTile(
                        accommodationResponseModel!.description ?? 'Sin título', 14.0),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    labelTile('Dirección'),
                    dataTile(
                        accommodationResponseModel!.address ?? 'Sin título',
                        16.0),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    labelTile('Ciudad'),
                    dataTile(
                        accommodationResponseModel!.city ?? 'Sin título', 14.0),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    labelTile('País'),
                    dataTile(
                        accommodationResponseModel!.country ?? 'Sin título',
                        16.0),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    labelTile('Capacidad'),
                    dataTile('${accommodationResponseModel!.guestCapacity} Huespedes',14.0),
                    SizedBox(height: 5,),
                    dataTile('${accommodationResponseModel!.numberRooms} Recamaras',14.0),
                    SizedBox(height: 5,),
                    dataTile('${accommodationResponseModel!.numberBathrooms} Baños',14.0),
                    SizedBox(height: 5,),
                    dataTile('${accommodationResponseModel!.guestCapacity} Camas',14.0),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    labelTile('Tipo de hospedaje'),
                    dataTile(accommodationResponseModel?.type?.name ?? 'Sin título',14.0),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    labelTile('Se ve como un(a)'),
                    dataTile(accommodationResponseModel?.describe?.describe ??'Sin título',14.0),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: AppButton(
                          buttontext: 'Pagina Principal',
                          onclick: () {
                            context.pushReplacement('/menu-anfitrion');
                            context.read<AccommodationBloc>().add(AccommodationGetEvent());
                          },
                          context: context
                        ),
                      )
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
              borderRadius: BorderRadius.circular(10),
              border: Border(
                top: BorderSide(color: Theme.of(context).colorScheme.tertiary, width: 0.5),
                bottom: BorderSide(color: Theme.of(context).colorScheme.tertiary, width: 0.5),
                left: BorderSide(color: Theme.of(context).colorScheme.tertiary, width: 0.5),
                right: BorderSide(color: Theme.of(context).colorScheme.tertiary, width: 0.5),
              ),
              color: Colors.white),
          child: Column(
            children: [
              ListTile(
                title: Center(
                  child: Text(
                    data,
                    style: TextStyle(
                        fontFamily: "Gilroy", fontSize: size, color: Theme.of(context).colorScheme.secondary),
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
            fontSize: 14,
            fontFamily: "Gilroy",
            color: Theme.of(context).colorScheme.primary), //heding Text
      ),
    );
  }
}
