import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tomatebnb/bloc/export_blocs.dart';
import 'package:tomatebnb/models/reserve/reserve_response_model.dart';

class ItemListReserva extends StatelessWidget {
  final ReserveResponseModel reserva;

  const ItemListReserva({super.key, required this.reserva});

  @override
  Widget build(BuildContext context) {
    context.read<AccommodationBloc>().add(AccommodationGetByIdEvent(reserva.accommodationId??0));
    return BlocBuilder<AccommodationBloc, AccommodationState>(
      
      builder: (context, state) {
        return GestureDetector(
          onTap: () => context.push('/detalle_reserva', extra: reserva),
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 6),
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Theme.of(context).colorScheme.surfaceContainer,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  reserva.accommodation?.title?? "Sin título",
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: "Gilroy Bold",
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 1,
                  child: Text(
                    reserva.accommodation?.description ?? "Sin descripción",
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: "Gilroy",
                      color: Theme.of(context).colorScheme.secondary,
                      overflow: TextOverflow.ellipsis
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Theme.of(context).colorScheme.primary.withAlpha(30)
                  ),
                  child: Row(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text('Desde el ', style: TextStyle(color: Theme.of(context).colorScheme.secondary,fontFamily: "Gilroy"),),
                          Text("${reserva.startDate?.day}/${reserva.startDate?.month}/${reserva.startDate?.year}", style: TextStyle(fontFamily: "Gilroy"),),
                          const SizedBox(width: 5),
                          Text( "hasta el ", style: TextStyle(color: Theme.of(context).colorScheme.secondary,fontFamily: "Gilroy"),),
                          SizedBox(width: 5,),
                          Text("${reserva.endDate?.day}/${reserva.endDate?.month}/${reserva.endDate?.year}", style: TextStyle(fontFamily: "Gilroy"),),
                        ],
                      ),                       
                    ],
                  ),
                ),
                const SizedBox(height: 5),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Theme.of(context).colorScheme.primary.withAlpha(30)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Precio Total: ", 
                        style: TextStyle(
                          fontFamily: "Gilroy Bold",
                          color: Theme.of(context).colorScheme.primary
                        ),
                      ),
                      Text('${reserva.totalPrice} BS.', style: TextStyle(fontFamily: "Gilroy"),),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
