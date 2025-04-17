import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tomatebnb/config/app_colors.dart';
import 'package:tomatebnb/provider/navigation_provider.dart';
import 'package:tomatebnb/ui/pages/huesped/explorar_page.dart';
import 'package:tomatebnb/ui/pages/huesped/favorito_page.dart';
import 'package:tomatebnb/ui/pages/huesped/profile_page.dart';
import 'package:tomatebnb/ui/pages/huesped/viaje_page.dart';
import 'package:tomatebnb/utils/Colors.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  final _pageOption = [
    const ExplorarPage(),
    const FavoritoPage(),
    const ViajePage(),
    const ProfilePage(),
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
      body: _pageOption[navigationProvider.selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: AppColors().WhiteColor,
        backgroundColor: AppColors().boxcolor,
        elevation: 0,
        selectedLabelStyle: const TextStyle(
            fontFamily: 'Gilroy Bold', fontWeight: FontWeight.bold),
        fixedColor: Theme.of(context).colorScheme.tertiary,
        unselectedLabelStyle: const TextStyle(fontFamily: 'Gilroy Medium'),
        currentIndex: navigationProvider.selectedIndex,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        items: [
          BottomNavigationBarItem(
              icon: Icon(EvaIcons.searchOutline, color: navigationProvider.selectedIndex == 0 ? colortheme.tertiary : greyColor),
              label: 'Explora'),
          BottomNavigationBarItem(
              icon: Image.asset(
                "assets/images/heart.png",
                height: 25,
                color: navigationProvider.selectedIndex == 1 ? colortheme.tertiary : greyColor,
              ),
              label: 'Favoritos'),
          BottomNavigationBarItem(
              icon: Image.asset(
                "assets/images/booking.png",
                height: 25,
                color: navigationProvider.selectedIndex == 2 ? colortheme.tertiary : greyColor,
              ),
              label: 'Mis Reservas'),
          BottomNavigationBarItem(
            icon: Image.asset(
              "assets/images/profile.png",
              height: 25,
              color: navigationProvider.selectedIndex == 3 ? colortheme.tertiary : greyColor,
            ),
            label: 'Mi Perfil',
          ),
        ],
        onTap: (index) {
          setState(() {});
          navigationProvider.setPage(index);
        },
      )
    );
  }
}