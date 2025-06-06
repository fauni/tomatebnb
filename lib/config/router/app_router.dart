import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tomatebnb/models/reserve/reserve_response_model.dart';
import 'package:tomatebnb/ui/pages/accommodation/accommodation_detail_page.dart';
import 'package:tomatebnb/ui/pages/accommodation/accommodation_instructions_page.dart';
import 'package:tomatebnb/ui/pages/accommodation/accommodation_rules_page.dart';
import 'package:tomatebnb/ui/pages/accommodation/describe_page.dart';
import 'package:tomatebnb/ui/pages/accommodation/finish_page.dart';
import 'package:tomatebnb/ui/pages/accommodation/highlight_page.dart';
import 'package:tomatebnb/ui/pages/accommodation/prices_page.dart';
import 'package:tomatebnb/ui/pages/accommodation/start_page.dart';
import 'package:tomatebnb/ui/pages/anfitrion/menu_anfitrion_page.dart';
import 'package:tomatebnb/ui/pages/auth/create_account_page.dart';
import 'package:tomatebnb/ui/pages/auth/verificate_email_page.dart';
import 'package:tomatebnb/ui/pages/host/ads_page.dart';
import 'package:tomatebnb/ui/pages/huesped/accommodation_filter_page.dart';
import 'package:tomatebnb/ui/pages/huesped/checkin_page.dart';
import 'package:tomatebnb/ui/pages/huesped/create_reserve_page.dart';
import 'package:tomatebnb/ui/pages/huesped/detalle_anuncio_page.dart';
import 'package:tomatebnb/ui/pages/huesped/explorar_mapa_page.dart';
import 'package:tomatebnb/ui/pages/huesped/home_page.dart';
import 'package:tomatebnb/ui/pages/auth/login_page.dart';
import 'package:tomatebnb/ui/pages/huesped/instructions_reserve_page.dart';
import 'package:tomatebnb/ui/pages/huesped/menu_page.dart';
import 'package:tomatebnb/ui/pages/huesped/payment_page.dart';
import 'package:tomatebnb/ui/pages/huesped/reserve_detail_page.dart';
import 'package:tomatebnb/ui/pages/huesped/search_page.dart';
import 'package:tomatebnb/ui/pages/huesped/select_date_page.dart';
import 'package:tomatebnb/ui/pages/user/change_password_page.dart';
import 'package:tomatebnb/ui/pages/user/my_profile_page.dart';

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
      path: '/create-account',
      builder: (context, state) => const CreateAccountPage()
    ),
    GoRoute(
      path: '/menu-viajero',
      builder: (context, state) => const MenuPage()
    ),
    GoRoute(
      path: '/menu-anfitrion',
      builder: (context, state) => const MenuAnfitrionPage()
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
    ),
    GoRoute(
      path: '/highlight',
      builder: (context, state) => const HighlightPage()
    ),
    GoRoute(
      path: '/explorar_mapa',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: ExplorarMapaPage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0, 1);
          const end = Offset.zero;
          final tween = Tween(begin: begin, end: end);
          final offsetAnimation = animation.drive(tween);
          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
      ),
    ),
    GoRoute(
      path: '/prices',
      builder: (context, state) => const PricesPage()
    ),
    GoRoute(
      path: '/detail_ads',
      builder: (context, state) => const DetalleAnuncioPage(),
    ), 
    GoRoute(
      path: '/finish',
      builder: (context, state) => const FinishPage()
    ),
    GoRoute(
      path: '/my_profile',
      builder: (context, state) => const MyProfilePage()
    ),
    GoRoute(
      path: '/accommodation_detail',
      builder: (context, state) => const AccommodationDetailPage()
    ),
    GoRoute(
      path: '/instructions',
      builder: (context, state) => const AccommodationInstructionsPage()
    ),
     GoRoute(
      path: '/rules',
      builder: (context, state) => const AccommodationRulesPage()
    ),
    GoRoute(
      path: '/create_reserve',
      builder: (context, state) => const CreateReservePage()
    ),
    GoRoute(
      path: '/select_date',
      builder: (context, state) => const SelectDatePage()
    ),
    GoRoute(
      path: '/detalle_reserva',
      builder: (context, state){
        final reserva = state.extra as ReserveResponseModel;
        return ReserveDetailPage(reserva: reserva);
      }
    ),
    GoRoute(
      path: '/accommodation_filter',
      builder: (context, state) => const AccommodationFilterPage()
    ),
     GoRoute(
      path: '/cambiar_password',
      builder: (context, state) => const ChangePasswordPage()
    ),
    GoRoute(
      path: '/verificate_email',
      builder: (context, state) => const VerificateEmailPage()
    ),
    GoRoute(
      path: '/payment',
      builder: (context, state){
        final reserveId = state.extra as int;
        return PaymentPage(reserveId: reserveId);
      }
    ),
    GoRoute(
      path: '/instructions_reserve',
      builder: (context, state) => const InstructionsReservePage()
    ),
    GoRoute(
      path: '/checkin',
      builder: (context, state) => const CheckinPage()
    )
  ]
);