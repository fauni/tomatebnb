import 'package:flutter/material.dart';
import 'package:tomatebnb/models/accommodation/accommodation_response_model.dart';

class ItemListAnuncio extends StatelessWidget {
  final AccommodationResponseModel anuncio;
  const ItemListAnuncio({super.key, required this.anuncio});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
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
              child: Image.asset("assets/images/BoutiqueHotel.jpg"),
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
              Text(
                anuncio.description??"Sin descripción",
                style: TextStyle(
                    fontSize: 13,
                    fontFamily: "Gilroy Medium"),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              Row(
                children: [
                  Row(
                    children: [
                      Text(
                        "\$46 /",
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: "Gilroy Bold"),
                      ),
                      const SizedBox(width: 3),
                      Text(
                        "Night",
                        style: TextStyle(
                            fontSize: 16,
                            color: Theme.of(context).colorScheme.primary,
                            fontFamily: "Gilroy Medium"),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const SizedBox(
                        width: 12,
                      ),
                      Image.asset(
                        "assets/images/star.png",
                        height: 20,
                      ),
                      const SizedBox(width: 2),
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Row(
                          children: [
                            Text(
                              "4.6",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "(142 Reviews)",
                              style:
                                  TextStyle(fontSize: 14, color: Theme.of(context).colorScheme.primary),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
