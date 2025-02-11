import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var colorScheme = Theme.of(context).colorScheme; // Obtiene el esquema de colores

    return Scaffold(
      backgroundColor: colorScheme.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 50,
                    width: 190,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: colorScheme.primaryContainer),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const SizedBox(width: 5),
                        Icon(Icons.location_on, color: colorScheme.primary),
                        const SizedBox(width: 2),
                        Text(
                          "Surat Gujrat, India",
                          style: TextStyle(
                              color: colorScheme.onBackground,
                              fontFamily: "Gilroy Medium"),
                        ),
                        Icon(Icons.keyboard_arrow_down, color: colorScheme.primary),
                        const SizedBox(width: 5),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      // Navigator.of(context).push(
                      //   MaterialPageRoute(builder: (context) => const NotificationPage()),
                      // );
                    },
                    child: CircleAvatar(
                      radius: 25,
                      backgroundColor: colorScheme.primaryContainer,
                      child: Icon(Icons.notifications, color: colorScheme.onPrimaryContainer),
                    ),
                  )
                ],
              ),
              SizedBox(height: height * 0.015),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hello, yagnik! 👋",
                        style: TextStyle(
                            color: colorScheme.secondary, fontSize: 15, fontFamily: "Gilroy Medium"),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Let’s find the best hotel",
                        style: TextStyle(
                            fontSize: 20, color: colorScheme.onBackground, fontFamily: "Gilroy Bold"),
                      ),
                      SizedBox(height: height * 0.03),
                      Container(
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: colorScheme.primaryContainer),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          child: TextField(
                            onTap: () {
                              // Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Homepage()));
                            },
                            readOnly: true,
                            decoration: InputDecoration(
                              hintText: 'Search hotel',
                              hintStyle: TextStyle(color: colorScheme.secondary, fontFamily: "Gilroy Medium"),
                              prefixIcon: Icon(Icons.search, color: colorScheme.secondary),
                              suffixIcon: Icon(Icons.filter_list, color: colorScheme.secondary),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: height * 0.025),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Recommended Hotels",
                            style: TextStyle(fontFamily: "Gilroy Bold", color: colorScheme.onBackground),
                          ),
                          InkWell(
                            onTap: () {
                              // Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ShowAllHotel()));
                            },
                            child: Text(
                              "See All",
                              style: TextStyle(color: colorScheme.primary, fontFamily: "Gilroy Medium"),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: height * 0.018),
                      SizedBox(
                        height: height / 3.8,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 0, // hotelList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              onTap: () {
                                // Navigator.of(context).push(
                                //   MaterialPageRoute(builder: (context) => const HotelDetailPage()),
                                // );
                              },
                              child: Container(
                                margin: const EdgeInsets.symmetric(horizontal: 4),
                                width: 280,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12), color: colorScheme.primaryContainer),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Stack(
                                        children: [
                                          Container(
                                            height: 118,
                                            width: double.infinity,
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(15),
                                              child: Icon(Icons.abc),
                                              // child: Image.asset(
                                              //   hotelList[index]["img"].toString(),
                                              //   height: 120,
                                              //   fit: BoxFit.fill,
                                              // ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      // Text(
                                      //   hotelList[index]["title"].toString(),
                                      //   style: TextStyle(
                                      //       fontSize: 15, fontFamily: "Gilroy Bold", color: colorScheme.onBackground),
                                      // ),
                                      const SizedBox(height: 6),
                                      // Text(
                                      //   hotelList[index]["address"].toString(),
                                      //   style: TextStyle(
                                      //       fontSize: 12, color: colorScheme.secondary, fontFamily: "Gilroy Medium"),
                                      // ),
                                      const Divider(),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Icon(Icons.bed, color: colorScheme.primary),
                                          Icon(Icons.wifi, color: colorScheme.primary),
                                          Icon(Icons.fitness_center, color: colorScheme.primary),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: height * 0.02),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Nearby Hotels",
                            style: TextStyle(fontFamily: "Gilroy Bold", color: colorScheme.onBackground),
                          ),
                          InkWell(
                            onTap: () {
                              // Navigator.of(context).push(MaterialPageRoute(builder: (context) => const NearbyAllHotel()));
                            },
                            child: Text(
                              "See All",
                              style: TextStyle(color: colorScheme.primary, fontFamily: "Gilroy Medium"),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: height * 0.01),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}