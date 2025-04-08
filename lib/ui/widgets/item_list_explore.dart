import 'dart:typed_data';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:tomatebnb/config/app_colors.dart';
import 'package:tomatebnb/config/constants/environment.dart';
import 'package:tomatebnb/models/accommodation/accommodation_response_complete_model.dart';
import 'package:tomatebnb/ui/widgets/skeleton_image_widget.dart';

class ItemListExplore extends StatefulWidget {
  
  const ItemListExplore({super.key, required this.accommodation, required this.onTap});

  final AccommodationResponseCompleteModel accommodation;
  final VoidCallback onTap;

  @override
  State<ItemListExplore> createState() => _ItemListExploreState();
}

class _ItemListExploreState extends State<ItemListExplore> {
  String imgsUrl = Environment.UrlImg;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        width: 280,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12), color: Colors.white),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
              children: [
                CarouselSlider(
                  options: CarouselOptions(
                    autoPlay: true,
                    enlargeCenterPage: true,
                    aspectRatio: 16 / 9,
                    viewportFraction: 1, // Muestra una imagen a la vez
                  ),
                  items: widget.accommodation.photos!.isNotEmpty
                      ? widget.accommodation.photos!.map((photo) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Container(
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.symmetric(horizontal: 0.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: FadeInImage.memoryNetwork(
                                    placeholder: Uint8List(0),
                                    placeholderErrorBuilder: (context, error, stackTrace) => SkeletonImageWidget(),
                                    image: '$imgsUrl/accommodations/${photo.photoUrl}',
                                    fit: BoxFit.cover, // Para que la imagen cubra el contenedor
                                  ),
                                ),
                              );
                            },
                          );
                        }).toList()
                      : [
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.asset("assets/images/BoutiqueHotel.jpg", fit: BoxFit.cover,),
                            ),
                          )
                        ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        "assets/images/heart.png",
                        color: widget.accommodation.isFavorite! ? Colors.red : Colors.white,
                        height: 20,
                      ),
                      Container(
                        height: 35,
                        width: 110,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        child: Center(
                          child: Text(
                            "Bs. ${widget.accommodation.priceNight} noche",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              fontFamily: "Gilroy Medium",
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
              SizedBox(height: 5),
              Text(
                widget.accommodation.title!,
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: "Gilroy Bold",
                    color: Theme.of(context).colorScheme.primary,),
              ),
              Text(
                widget.accommodation.address!,
                style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).colorScheme.secondary,
                    fontFamily: "Gilroy Medium",
                    overflow: TextOverflow.ellipsis),
              ),
              Text(
                '${widget.accommodation.city!} - ${widget.accommodation.country!}',
                style: TextStyle(fontSize: 12,color: Theme.of(context).colorScheme.secondary,fontFamily: "Gilroy Medium")
              )
            ],
          ),
        ),
      ),
    );
  }

  hotelsystem({String? image, text, double? radi, BuildContext? context}) {
    return Row(
      children: [
        Image.asset(
          image!,
          height: 25,
          color: Theme.of(context!).colorScheme.secondary,
        ),
        const SizedBox(width: 5),
        Text(
          text,
          style: TextStyle(
            color: Colors.black, 
            fontFamily: "Gilroy Medium"
          ),
        ),
        const SizedBox(width: 11),
        CircleAvatar(
          radius: radi,
          backgroundColor: Colors.blueGrey,
        )
      ],
    );
  }
}
