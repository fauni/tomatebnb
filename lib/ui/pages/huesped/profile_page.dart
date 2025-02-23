import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tomatebnb/utils/dark_lightmode.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    getdarkmodepreviousstate();
    getMode();
    super.initState();
  }

  late ColorNotifire notifire;
  late bool? isAnfitrion = false;

  void getMode() async {
    final prefs = await SharedPreferences.getInstance();
    isAnfitrion = prefs.getBool("setIsAnfitrion");
  }

  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    return  Scaffold(
      backgroundColor: notifire.getbgcolor,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: isAnfitrion != null && isAnfitrion == true ? 
        FloatingActionButton.extended(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          onPressed: () => changeMode(), 
          label: Text('Cambiar a modo viajero'),
          icon: Icon(Icons.change_circle_outlined),
        ) 
        : FloatingActionButton.extended(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          onPressed: () => changeMode(), 
          label: Text('Cambiar a modo anfitrion'),
          icon: Icon(Icons.change_circle_outlined),
        ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 13),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 32,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Perfil",
                    style: TextStyle(
                        fontSize: 18,
                        color: notifire.getwhiteblackcolor,
                        fontFamily: "Gilroy Bold"),
                  ),
                  InkWell(
                    onTap: () {
                      // TODO: Redirigir a configuraciones
                    },
                    child: CircleAvatar(
                      backgroundColor: notifire.getdarkmodecolor,
                      child: Image.asset(
                        "assets/images/notification.png",
                        height: 25,
                        color: notifire.getwhiteblackcolor,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
      // body:AppButton(
      //   buttontext:"ir a anuncios",
      //   onclick:(){
      //     context.push("/ads");
      //   }
      // ),
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

  changeMode() async {
    final prefs = await SharedPreferences.getInstance();
    if(isAnfitrion == null || isAnfitrion == false){
      prefs.setBool("setIsAnfitrion", true);
      // ignore: use_build_context_synchronously
      context.push('/menu-anfitrion');
    } else {
      prefs.setBool("setIsAnfitrion", false);
      // ignore: use_build_context_synchronously
      context.push('/menu-viajero');
    }
  }
}