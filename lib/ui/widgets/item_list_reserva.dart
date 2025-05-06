import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tomatebnb/bloc/export_blocs.dart';
import 'package:tomatebnb/models/reserve/reserve_response_model.dart';

class ItemListReserva extends StatefulWidget {
  final ReserveResponseModel reserva;
  // Agregamos el metodo onTap
  final Function() onTap;

  const ItemListReserva({super.key, required this.reserva, required this.onTap});

  @override
  State<ItemListReserva> createState() => _ItemListReservaState();
}

class _ItemListReservaState extends State<ItemListReserva> {
  @override
  void initState() {
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    context.read<AccommodationBloc>().add(AccommodationGetByIdEvent(widget.reserva.accommodationId??0));
    return BlocBuilder<AccommodationBloc, AccommodationState>(
      
      builder: (context, state) {
        return GestureDetector(
          onTap: widget.onTap,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 6),
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Theme.of(context).colorScheme.tertiary.withAlpha(100),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.reserva.accommodation?.title?? "Sin título",
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: "Gilroy Bold",
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 1,
                  child: Text(
                    widget.reserva.accommodation?.description ?? "Sin descripción",
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: "Gilroy",
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
                          Text("${widget.reserva.startDate?.day}/${widget.reserva.startDate?.month}/${widget.reserva.startDate?.year}", style: TextStyle(fontFamily: "Gilroy"),),
                          const SizedBox(width: 5),
                          Text( "hasta el ", style: TextStyle(color: Theme.of(context).colorScheme.secondary,fontFamily: "Gilroy"),),
                          SizedBox(width: 5,),
                          Text("${widget.reserva.endDate?.day}/${widget.reserva.endDate?.month}/${widget.reserva.endDate?.year}", style: TextStyle(fontFamily: "Gilroy"),),
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
                      Text('${widget.reserva.totalPrice} BS.', style: TextStyle(fontFamily: "Gilroy"),),
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
