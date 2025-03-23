import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tomatebnb/bloc/export_blocs.dart';
import 'package:tomatebnb/config/constants/environment.dart';
import 'package:tomatebnb/models/accommodation/accommodation_response_complete_model.dart';
import 'package:tomatebnb/models/reserve/reserve_response_model.dart';
// import 'package:tomatebnb/models/accommodation/accommodation_response_model.dart';
// import 'package:tomatebnb/utils/customwidget.dart';

class ItemListReserva extends StatelessWidget {
  final ReserveResponseModel reserva;

  const ItemListReserva({super.key, required this.reserva});

  @override
  Widget build(BuildContext context) {
    String imgsUrl = Environment.UrlImg;
    context.read<AccommodationBloc>()
           .add(AccommodationGetByIdEvent(reserva.accommodationId??0));
    return BlocBuilder<AccommodationBloc, AccommodationState>(
      
      builder: (context, state) {
        return GestureDetector(
           onTap: () => context.push('/detalle_reserva', extra: reserva),
          child: Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(vertical: 6),
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: reserva.state != 'pendiente'
                    ? Theme.of(context).colorScheme.inversePrimary
                    : Theme.of(context).colorScheme.errorContainer,
                width: 2,
              ),
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            child: Row(
              children: [
                // Container(
                //   margin:
                //       const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                //   height: 75,
                //   width: 75,
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(15),
                //     // color: Colors.red,
                //   ),
                //   child: ClipRRect(
                //     borderRadius: BorderRadius.circular(10),
                //     child: anuncio.photos!.isNotEmpty
                //         ? FadeInImage.assetNetwork(
                //             placeholder: 'assets/images/load.gif',
                //             image:
                //                 '$imgsUrl/accommodations/${anuncio.photos?.first.photoUrl}')
                //         : Image.asset("assets/images/BoutiqueHotel.jpg"),
                //   ),
                // ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      reserva.accommodation?.title?? "Sin título",
                      style: TextStyle(fontSize: 15, fontFamily: "Gilroy Bold"),
                    ),
                    // const SizedBox(height: 6),
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 0.006),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.65,
                      child: Text(
                        reserva.accommodation?.description ?? "Sin descripción",
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 13, fontFamily: "Gilroy Medium"),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                    Row(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text('del '),
                            Text(
                              "${reserva.startDate?.day}/${reserva.startDate?.month}/${reserva.startDate?.year}",
                              style: TextStyle(
                                  fontSize: 16, fontFamily: "Gilroy Bold"),
                            ),
                            const SizedBox(width: 3),
                            Text(
                              "al",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Theme.of(context).colorScheme.primary,
                                  fontFamily: "Gilroy Medium"),
                            ),
                            Text(
                              "${reserva.endDate?.day}/${reserva.endDate?.month}/${reserva.endDate?.year}",
                              style: TextStyle(
                                  fontSize: 16, fontFamily: "Gilroy Bold"),
                            ),
                          ],
                        ),
                       
                      ],
                    ),
                       Row(
                      children: [
                        Text('Bs.'),
                        Text(
                          reserva.totalPrice.toString(),
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: "Gilroy Bold"),
                        ),
                        const SizedBox(width: 3),
                        Text(
                          "Por el total de noches",
                          style: TextStyle(
                              fontSize: 16,
                              color: Theme.of(context).colorScheme.primary,
                              fontFamily: "Gilroy Medium"),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
