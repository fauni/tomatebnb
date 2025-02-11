import 'package:go_router/go_router.dart';
import 'package:tomatebnb/ui/pages/anfitrion/home_page.dart';
import 'package:tomatebnb/ui/pages/auth/login_page.dart';

// Simulación de estado de autentificación
bool isAuthenticated = false;

final GoRouter appRouter = GoRouter(
  initialLocation: '/home',
  routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginPage()
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomePage()
    )
  ]
);