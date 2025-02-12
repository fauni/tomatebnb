import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tomatebnb/ui/pages/huesped/home_page.dart';
import 'package:tomatebnb/ui/pages/huesped/message_page.dart';
import 'package:tomatebnb/ui/pages/huesped/profile_page.dart';
import 'package:tomatebnb/ui/pages/huesped/search_page.dart';
import 'package:tomatebnb/utils/Colors.dart';
import 'package:tomatebnb/utils/dark_lightmode.dart';

int selectedIndex = 0;

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  late int _lastTimeBackButtonWasTapped;
  static const exitTimeInMillis = 2000;

  final _pageOption = [
    const HomePage(),
    SearchPage(),
    const MessagePage(),
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
              icon: Image.asset("assets/images/homeicon.png",
                  color: selectedIndex == 0 ? Darkblue : greyColor,
                  height: MediaQuery.of(context).size.height / 35),
              label: 'Home'),
          BottomNavigationBarItem(
              icon: Image.asset("assets/images/search.png",
                  color: selectedIndex == 1 ? Darkblue : greyColor,
                  height: MediaQuery.of(context).size.height / 35),
              label: 'Search'),
          BottomNavigationBarItem(
              icon: Image.asset("assets/images/message.png",
                  color: selectedIndex == 2 ? Darkblue : greyColor,
                  height: MediaQuery.of(context).size.height / 35),
              label: 'Message'),
          BottomNavigationBarItem(
            icon: Image.asset("assets/images/profile.png",
                color: selectedIndex == 3 ? Darkblue : greyColor,
                height: MediaQuery.of(context).size.height / 35),
            label: 'Profile',
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