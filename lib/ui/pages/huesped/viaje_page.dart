import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tomatebnb/bloc/export_blocs.dart';
import 'package:tomatebnb/ui/widgets/item_list_reserva.dart';


class ViajePage extends StatelessWidget {
  const ViajePage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<ReserveBloc>().add(ReserveGetByUserEvent());
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.surface,
        surfaceTintColor: Theme.of(context).colorScheme.surface,
        automaticallyImplyLeading: false,
        // leading: BackButton(color: notifire.getwhiteblackcolor),
        title: Text(
          "Mis Viajes",
          style: TextStyle(fontFamily: "Gilroy Bold"),
        ),
        actions: [
          Ink(
            height: 40,
            decoration:
                ShapeDecoration(color: Colors.grey[300], shape: CircleBorder()),
            child: IconButton(
                onPressed: () {
                  // context.push('/startad');
                },
                icon: const Icon(Icons.add)),
          ),
          SizedBox(
            width: 10,
          )
        ],
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              SizedBox(
                child: BlocConsumer<ReserveBloc, ReserveState>(
                  listener:(context, state) {
                    if (state is ReserveGetByUserError) {
                      ScaffoldMessenger.of(context)
                                       .showSnackBar(
                                        SnackBar(content: Text(state.message),
                                        backgroundColor: Theme.of(context).colorScheme.error,));
                    }
                  },
                  builder: (context, state) {
                    if (state is ReserveGetByUserLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    // if (state is AccommodationGetError) {
                    //   return Center(
                    //     child: Text(state.message),
                    //   );
                    // }
                    if (state is ReserveGetByUserSuccess) {
                      
                      return ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        itemCount: state.responseReserves.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ItemListReserva(
                            reserva: state.responseReserves[index],
                          );
                         
                        },
                      );
                    } else {
                      return Center(child:Text('No existen reservas'));
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}