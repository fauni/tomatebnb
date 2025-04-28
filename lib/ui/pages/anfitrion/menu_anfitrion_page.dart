import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tomatebnb/config/app_colors.dart';
import 'package:tomatebnb/provider/navigation_provider.dart';
import 'package:tomatebnb/ui/pages/anfitrion/anuncio_page.dart';
import 'package:tomatebnb/ui/pages/anfitrion/calendario_page.dart';
import 'package:tomatebnb/ui/pages/anfitrion/home_anfitrion_page.dart';
import 'package:tomatebnb/ui/pages/user/my_profile_page.dart';
import 'package:tomatebnb/utils/Colors.dart';

int selectedIndex = 0;

class MenuAnfitrionPage extends StatefulWidget {
  const MenuAnfitrionPage({super.key});

  @override
  State<MenuAnfitrionPage> createState() => _MenuAnfitrionPageState();
}

class _MenuAnfitrionPageState extends State<MenuAnfitrionPage> {
  // late int _lastTimeBackButtonWasTapped;
  // static const exitTimeInMillis = 2000;

  final _pageOption = [
    const HomeAnfitrionPage(),
    const CalendarioPage(),
    const AnuncioPage(),
    const MyProfilePage(),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final navigationProvider = Provider.of<NavigationProvider>(context);
    var colortheme = Theme.of(context).colorScheme;

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: AppColors().WhiteColor,
        backgroundColor: AppColors().boxcolor,
        elevation: 0,
        selectedLabelStyle: const TextStyle(
            fontFamily: 'Gilroy Bold', fontWeight: FontWeight.bold),
        fixedColor: Theme.of(context).colorScheme.tertiary,
        unselectedLabelStyle: const TextStyle(fontFamily: 'Gilroy Medium'),
        currentIndex: navigationProvider.selectedIndexAnfitrion,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset("assets/images/home.png", height: 25, color: navigationProvider.selectedIndexAnfitrion == 0 ? colortheme.tertiary : greyColor,),
            label: 'Inicio'),
          BottomNavigationBarItem(
            icon: Image.asset("assets/images/calendar.png", height: 25, color: navigationProvider.selectedIndexAnfitrion == 1 ? colortheme.tertiary : greyColor,),
            label: 'Calendario'),
          BottomNavigationBarItem(
            icon: Image.asset("assets/images/post-it.png", height: 25, color: navigationProvider.selectedIndexAnfitrion == 2 ? colortheme.tertiary : greyColor,),
            label: 'Anuncios'),
          BottomNavigationBarItem(
            icon: Image.asset("assets/images/hamburger.png", height: 25, color: navigationProvider.selectedIndexAnfitrion == 3 ? colortheme.tertiary : greyColor,),
            label: 'Menu',
          ),
        ],
        onTap: (index) {
          setState(() {});
          navigationProvider.setPageAnfitrion(index);
        },
      ),
      body: _pageOption[navigationProvider.selectedIndexAnfitrion],
    );
  }
}