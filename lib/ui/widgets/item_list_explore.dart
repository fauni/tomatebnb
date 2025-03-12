import 'package:flutter/material.dart';
import 'package:tomatebnb/config/constants/environment.dart';
import 'package:tomatebnb/models/accommodation/accommodation_response_complete_model.dart';

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
                  // ignore: sized_box_for_whitespace
                  Container(
                    height: 170,
                    width: double.infinity,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: widget.accommodation.photos!.isNotEmpty 
                      ?  FadeInImage.assetNetwork(
                        placeholder: 'assets/images/load.gif', 
                        image: '$imgsUrl/accommodations/${widget.accommodation.photos?.first.photoUrl}')
                      : Image.asset("assets/images/BoutiqueHotel.jpg"),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          height: 30,
                          width: 100,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.black),
                          child: Center(
                            child: Text(
                              "Bs. ${widget.accommodation.priceNight}/Noche",
                              style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.white,
                                  fontFamily: "Gilroy Medium"),
                            ),
                          )),
                    ),
                  )
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  hotelsystem(
                      image: "assets/images/Bed.png", text: "2 Beds", radi: 3, context: context),
                  hotelsystem(
                      image: "assets/images/wifi.png", text: "Wifi", radi: 3, context: context),
                  hotelsystem(
                      image: "assets/images/gym.png", text: "Gym", radi: 0, context: context),
                ],
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
