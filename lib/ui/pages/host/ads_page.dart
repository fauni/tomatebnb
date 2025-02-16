import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tomatebnb/bloc/export_blocs.dart';
import 'package:tomatebnb/models/accommodation/accommodation_response_model.dart';
import 'package:tomatebnb/utils/customwidget.dart';
import 'package:tomatebnb/utils/dark_lightmode.dart';

class AdsPage extends StatefulWidget {
  const AdsPage({super.key});
  @override
  State<AdsPage> createState() => _AdsPageState();
}

class _AdsPageState extends State<AdsPage> {
  @override
  void initState() {
    getdarkmodepreviousstate();
    super.initState();

    context.read<AccommodationBloc>().add(AccommodationGetEvent());

  }

  late ColorNotifire notifire;
  List<AccommodationResponseModel> ads=[]; 

  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: notifire.getbgcolor,
        leading: BackButton(color: notifire.getwhiteblackcolor),
        title: Text(
          "Anuncios",
          style: TextStyle(
              color: notifire.getwhiteblackcolor, fontFamily: "Gilroy Bold"),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: AppButton(
          buttontext: "Crear Anuncio",
          onclick: () {
            context.push('/startad');
          },
        ),
      ),
      backgroundColor: notifire.getbgcolor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text("4 Ready to Use",
              //     style: TextStyle(
              //         fontSize: 16,
              //         color: notifire.getwhiteblackcolor,
              //         fontFamily: "Gilroy Bold")),
              const SizedBox(height: 10),
              SizedBox(
                child: BlocBuilder<AccommodationBloc, AccommodationState>(
                  builder: (context, state) {
                    if (state is AccommodationLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if(state is AccommodationGetError){
                      return Center(child: Text(state.message),);
                    }
                    if (state is AccommodationGetSuccess){
                     ads = state.responseAccommodations;
                    }
                    return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemCount: ads.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: notifire.getdarkmodecolor),
                              child: Column(
                                children: [
                                  ListTile(
                                    leading: Image.asset(
                                        "assets/images/home-2.png",
                                        height: 35),
                                    // trailing: Icon(
                                    //   Icons.edit_square,
                                    //   color: notifire.getdarkbluecolor
                                    //   ),
                                    title: Text(
                                      ads[index].title??"Sin título",
                                      style: TextStyle(
                                          fontFamily: "Gilroy Bold",
                                          fontSize: 16,
                                          color: notifire.getwhiteblackcolor),
                                    ),
                                    subtitle: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.5,
                                          child: Text(
                                            ads[index].description??"Sin descripción",  
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: notifire.getgreycolor,
                                                fontFamily: "Gilroy Medium"),
                                          ),
                                        ),
                                        const SizedBox(width: 4),
                                        Text("Eliminar",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color:
                                                    notifire.getdarkbluecolor,
                                                fontFamily: "Gilroy Medium")),
                                      ],
                                    ),
                                    isThreeLine: true,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 14),
                                    child: cupon(
                                        text1: "Fecha de Creacion:",
                                        text2: '${ads[index].createdAt?.day}/${ads[index].createdAt?.month}/${ads[index].createdAt?.year}',
                                        buttontext: "Editar",
                                        onClick: () {
                                          // Navigator.of(context).push(
                                          //     MaterialPageRoute(builder: (context) => Favourite()));
                                        }),
                                  )
                                ],
                              ),
                            ));
                      },
                    );
                    

                  },
                ),
             
              ),
            ],
          ),
        ),
      ),
    );
  }

  getdarkmodepreviousstate() async {
    final prefs = await SharedPreferences.getInstance();
    bool? previusstate = prefs.getBool("setIsDark");
    if (previusstate == null) {
      notifire.setIsDark = false;
    } else {
      notifire.setIsDark = previusstate;
    }
  }
}
