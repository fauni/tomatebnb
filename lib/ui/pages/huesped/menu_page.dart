import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tomatebnb/ui/pages/huesped/explorar_page.dart';
import 'package:tomatebnb/ui/pages/huesped/favorito_page.dart';
import 'package:tomatebnb/ui/pages/huesped/profile_page.dart';
import 'package:tomatebnb/ui/pages/huesped/viaje_page.dart';
import 'package:tomatebnb/utils/Colors.dart';
import 'package:tomatebnb/utils/dark_lightmode.dart';

int selectedIndex = 0;

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  // late int _lastTimeBackButtonWasTapped;
  // static const exitTimeInMillis = 2000;

  final _pageOption = [
    const ExplorarPage(),
    const FavoritoPage(),
    const ViajePage(),
    const ProfilePage(),
  ];

  @override
  void initState() {
    getdarkmodepreviousstate();
    super.initState();
  }

  late ColorNotifire notifire;

  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: notifire.getwhiteblackcolor,
        backgroundColor: notifire.getbgcolor,
        elevation: 0,
        selectedLabelStyle: const TextStyle(
            fontFamily: 'Gilroy Bold', fontWeight: FontWeight.bold),
        fixedColor: notifire.getwhiteblackcolor,
        unselectedLabelStyle: const TextStyle(fontFamily: 'Gilroy Medium'),
        currentIndex: selectedIndex,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        items: [
          BottomNavigationBarItem(
              icon: Icon(EvaIcons.searchOutline, color: selectedIndex == 0 ? Darkblue : greyColor),
              label: 'Explora'),
          BottomNavigationBarItem(
              icon: Icon(EvaIcons.heart, color: selectedIndex == 1 ? Darkblue : greyColor),
              label: 'Favoritos'),
          BottomNavigationBarItem(
              icon: Icon(Icons.airplane_ticket_outlined, color: selectedIndex == 3 ? Darkblue : greyColor),
              label: 'Viajes'),
          BottomNavigationBarItem(
            icon: Icon(EvaIcons.person, color: selectedIndex == 3 ? Darkblue : greyColor),
            label: 'Perfil',
          ),
        ],
        onTap: (index) {
          setState(() {});
          selectedIndex = index;
        },
      ),
      body: _pageOption[selectedIndex],
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