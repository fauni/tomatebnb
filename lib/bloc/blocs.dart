
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tomatebnb/repository/auth_repository.dart';
import 'package:tomatebnb/repository/accommodation_repository.dart';
import 'auth_bloc/auth_bloc.dart';
import 'package:tomatebnb/bloc/accommodation_bloc/accommodation_bloc.dart';

class Blocs {
  // Declaramos el bloc
  static final AuthBloc authBloc = AuthBloc(AuthRepository(),);
  static final AccommodationBloc accommodationBloc = AccommodationBloc(AccommodationRepository(),);

  // Lista de blocs Providers para proveer a toda la aplicación
  static final blocsProviders = [
    BlocProvider<AuthBloc>(create: (context) => authBloc),
    BlocProvider<AccommodationBloc>(create: (context) => accommodationBloc),
  ];

  // Metodos para cerrar el bloc cuando no se necesite
  static void dispose() {
    authBloc.close();
    accommodationBloc.close();
  }
  static final Blocs _instance = Blocs._internal();

  factory Blocs() {
    return _instance;
  }

  Blocs._internal();
}