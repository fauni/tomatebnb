import 'package:flutter/material.dart';

class DetalleAnuncioPage extends StatelessWidget {
  const DetalleAnuncioPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.tertiary,
              blurRadius: 10,
              spreadRadius: 10,
              blurStyle: BlurStyle.normal
            )
          ]
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 50,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
                )
              ),
              onPressed: (){
                
              }, 
              label: Text('Comprobar disponibilidad'),
              icon: Icon(Icons.verified_outlined, color: Theme.of(context).colorScheme.onPrimary,),
            ),
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            elevation: 0,
            backgroundColor: Theme.of(context).colorScheme.surface,
            leading: Padding(
              padding: const EdgeInsets.only(top: 8, left: 12),
              child: CircleAvatar(
                backgroundColor: Color(0xff202427),
                child: BackButton(
                  color: Colors.white,
                ),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 22,
                      backgroundColor: Color(0xff202427),
                      child: Image.asset(
                        "assets/images/share.png",
                        color: Colors.white,
                        height: 30,
                      ),
                    ),
                    const SizedBox(width: 20),
                    CircleAvatar(
                      radius: 22,
                      backgroundColor: Color(0xff202427),
                      child: Image.asset(
                        "assets/images/heart.png",
                        color: Colors.white,
                        height: 25,
                      ),
                    ),
                    const SizedBox(width: 20),
                  ],
                ),
              )
            ],
            expandedHeight: 250,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                "assets/images/SagamoreResort.jpg",
                height: 300,
                width: double.infinity,
                fit: BoxFit.fill,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  child: Stack(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Diamond Heart Hotel",
                            style: TextStyle(
                              fontSize: 18,
                              // color: notifire.getwhiteblackcolor,
                              fontFamily: "Gilroy Bold",
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Image.asset(
                                    "assets/images/Maplocation.png",
                                    height: 20,
                                    color: Colors.blue// notifire.getdarkbluecolor,
                                  ),
                                  Text(
                                    "Purwokerto, Karang Lewas",
                                    style: TextStyle(
                                        color: Colors.blueGrey,// notifire.getgreycolor,
                                        fontSize: 14,
                                        fontFamily: "Gilroy Medium"),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Image.asset("assets/images/star.png",
                                      height: 18),
                                  Text(
                                    "4.2",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.blue,// notifire.getdarkbluecolor,
                                      fontFamily: "Gilroy Bold",
                                    ),
                                  ),
                                  Text(
                                    "(84 Reviews)",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,// notifire.getgreycolor,
                                      fontFamily: "Gilroy Medium",
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}