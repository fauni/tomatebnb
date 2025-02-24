import 'package:flutter/material.dart';

class ItemListExplore extends StatefulWidget {
  
  const ItemListExplore({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  State<ItemListExplore> createState() => _ItemListExploreState();
}

class _ItemListExploreState extends State<ItemListExplore> {
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
                      child: Image.asset(
                        'assets/images/SagamoreResort.jpg',
                        height: 120,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          height: 30,
                          width: 90,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.black),
                          child: Center(
                            child: Text(
                              "Bs. 185/Noche",
                              style: TextStyle(
                                  fontSize: 10,
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
                "Titulo del Anuncio",
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: "Gilroy Bold",
                    color: Colors.black),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              Text(
                "Dirección del anuncio, número 223",
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
