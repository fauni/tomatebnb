import 'dart:typed_data';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
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

  Widget buildImageSkeleton() {
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: Container(
      width: double.infinity,
      height: 170, // Ajusta la altura según tus necesidades
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(15),
      ),
    ),
  );
}

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
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.asset("assets/images/BoutiqueHotel.jpg", fit: BoxFit.cover,),
                            ),
                          )
                        ],
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 35,
                      width: 110,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.blueGrey,
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
                    color: Colors.black),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              Text(
                widget.accommodation.address!,
                style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).colorScheme.primary,
                    fontFamily: "Gilroy Medium",
                    overflow: TextOverflow.ellipsis),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.001),
              Divider(color: Theme.of(context).colorScheme.secondary),
              // SizedBox(
              //     height: MediaQuery.of(context)
              //             .size
              //             .height *
              //         0.01),
              Text(
                '${widget.accommodation.city!} - ${widget.accommodation.country!}',
                style: TextStyle(fontSize: 12,color: Theme.of(context).colorScheme.primary,fontFamily: "Gilroy Medium")
              )
            ],
          ),
        ),
      ),
    );
  }

  hotelsystem({String? image, text, double? radi, BuildContext? context}) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
