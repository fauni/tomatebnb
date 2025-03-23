import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tomatebnb/config/constants/environment.dart';
import 'package:tomatebnb/models/accommodation/accommodation_response_complete_model.dart';
// import 'package:tomatebnb/models/accommodation/accommodation_response_model.dart';
// import 'package:tomatebnb/utils/customwidget.dart';

class ItemListAnuncio extends StatelessWidget {
  final AccommodationResponseCompleteModel anuncio;
  
  const ItemListAnuncio({super.key, required this.anuncio});

  @override
  Widget build(BuildContext context) {
    String imgsUrl = Environment.UrlImg;
    return GestureDetector(
      onTap: () => context.push('/accommodation_detail', extra: anuncio.id),
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: 
             anuncio.prices!.isNotEmpty 
            && anuncio.prices!.isNotEmpty
            && anuncio.services!.isNotEmpty 
            && anuncio.describe!= null 
            && anuncio.photos!.isNotEmpty
            && anuncio.title!= null
            && anuncio.description!= null
            ?Theme.of(context).colorScheme.inversePrimary 
            :Theme.of(context).colorScheme.errorContainer,
           
            width: 2,
          ),
          color: Theme.of(context).colorScheme.onPrimary,
        ),
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              height: 75,
              width: 75,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                // color: Colors.red,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child:
                  anuncio.photos!.isNotEmpty
                  ?FadeInImage.assetNetwork(
                    placeholder: 'assets/images/load.gif', 
                    image: '$imgsUrl/accommodations/${anuncio.photos?.first.photoUrl}')              
                  :Image.asset("assets/images/BoutiqueHotel.jpg"),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  anuncio.title ?? "Sin título",
                  style: TextStyle(
                      fontSize: 15,
                      fontFamily: "Gilroy Bold"),
                ),
                // const SizedBox(height: 6),
                SizedBox(height: MediaQuery.of(context).size.height * 0.006),
                SizedBox(
                  width: MediaQuery.of(context).size.width*0.65 ,
                  child: Text(
                    anuncio.description??"Sin descripción",
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis, 
                    style: TextStyle(
                        fontSize: 13,
                        fontFamily: "Gilroy Medium"),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                Row(
                  children: [
                    Row(
                      children: [
                        Text('Bs.'),
                        Text(
                          anuncio.prices!.isNotEmpty
                          ?anuncio.prices?.first.priceNight.toString() ?? "0.0"
                          :"?",
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: "Gilroy Bold"),
                        ),
                        const SizedBox(width: 3),
                        Text(
                          "Por Noche",
                          style: TextStyle(
                              fontSize: 16,
                              color: Theme.of(context).colorScheme.primary,
                              fontFamily: "Gilroy Medium"),
                        ),
                      ],
                    ),
                
                  ],
                ),
             
              ],
            ),
             
          ],
        ),
      ),
    );
  }
}
