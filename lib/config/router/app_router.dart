import 'package:go_router/go_router.dart';
import 'package:tomatebnb/ui/pages/accommodation/describe_page.dart';
import 'package:tomatebnb/ui/pages/accommodation/start_page.dart';
import 'package:tomatebnb/ui/pages/host/ads_page.dart';
import 'package:tomatebnb/ui/pages/huesped/home_page.dart';
import 'package:tomatebnb/ui/pages/auth/login_page.dart';
import 'package:tomatebnb/ui/pages/huesped/menu_page.dart';
import 'package:tomatebnb/ui/pages/huesped/search_page.dart';

// Simulación de estado de autentificación
bool isAuthenticated = false;

final GoRouter appRouter = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginPage()
    ),
    GoRoute(
      path: '/menu',
      builder: (context, state) => const MenuPage()
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomePage()
    ),
    GoRoute(
      path: '/search',
      builder: (context, state) => const SearchPage()
    ),
    GoRoute(
      path: '/ads',
      builder: (context, state) =>  AdsPage()
    ),
    GoRoute(
      path: '/startad',
      builder: (context, state) => const StartPage()
    ),
    GoRoute(
      path: '/describe',
      builder: (context, state) => const DescribePage()
    )
  ]
);