import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tomatebnb/bloc/export_blocs.dart';
import 'package:tomatebnb/models/reserve/reserve_response_model.dart';
import 'package:tomatebnb/provider/navigation_provider.dart';
import 'package:tomatebnb/ui/widgets/empty_data_widget.dart';
import 'package:tomatebnb/ui/widgets/item_list_reserva.dart';


class ViajePage extends StatefulWidget {
  const ViajePage({super.key});

  @override
  State<ViajePage> createState() => _ViajePageState();
}

class _ViajePageState extends State<ViajePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cargarReservas();
  }

  void cargarReservas() {
    context.read<ReserveBloc>().add(ReserveGetByUserEvent());
  }

  @override
  Widget build(BuildContext context) {
    // context.read<ReserveBloc>().add(ReserveGetByUserEvent());
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.surface,
        surfaceTintColor: Theme.of(context).colorScheme.surface,
        automaticallyImplyLeading: false,
        title: Text("Mis Reservas",style: TextStyle(fontFamily: "Gilroy Bold"),),
        actions: [
          IconButton(onPressed: ()=> cargarReservas(), icon: Icon(Icons.refresh)),
          SizedBox(width: 10,)
        ],
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: BlocConsumer<ReserveBloc, ReserveState>(
        listener:(context, state) {
          if (state is ReserveGetByUserError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message),
              backgroundColor: Theme.of(context).colorScheme.error,)
            );
          }
        },
        builder: (context, state) {
          if (state is ReserveGetByUserLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is ReserveGetByUserSuccess) {
            if(state.responseReserves.isEmpty){
              return EmptyDataWidget(
                image: 'assets/images/empty-folder.png',
                message: 'Todavía no tienes reservas creadas',
                onPush: () {
                  context.read<NavigationProvider>().setPage(0);
                },
              );
            } else {
              return ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(horizontal: 10),
                itemCount: state.responseReserves.length,
                itemBuilder: (BuildContext context, int index) {
                  ReserveResponseModel reserva = state.responseReserves[index];
                  return ItemListReserva(
                    reserva: reserva,
                    onTap: () async {
                      await context.push('/detalle_reserva', extra: reserva);
                      cargarReservas();
                    },
                  );
                
                },
              );
            }
          } else {
            return Center(child:Text('No existen reservas'));
          }
        },
      ),
    );
  }
}