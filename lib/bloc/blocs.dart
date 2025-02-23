
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:tomatebnb/bloc/accommodation_type_bloc/accommodation_type_bloc.dart';
import 'package:tomatebnb/bloc/export_blocs.dart';
import 'package:tomatebnb/repository/accommodation_aspect_repository.dart';
import 'package:tomatebnb/repository/accommodation_price_repository.dart';
import 'package:tomatebnb/repository/accommodation_discount_repository.dart';
import 'package:tomatebnb/repository/accommodation_service_repository.dart';
import 'package:tomatebnb/repository/accommodation_type_repository.dart';
import 'package:tomatebnb/repository/aspect_repository.dart';
import 'package:tomatebnb/repository/auth_repository.dart';
import 'package:tomatebnb/repository/accommodation_repository.dart';
import 'package:tomatebnb/repository/describe_repository.dart';
import 'package:tomatebnb/repository/service_repository.dart';
import 'package:tomatebnb/services/location_service.dart';
// import 'auth_bloc/auth_bloc.dart';
// import 'package:tomatebnb/bloc/accommodation_bloc/accommodation_bloc.dart';
// import 'package:tomatebnb/bloc/describe_bloc/describe_bloc.dart';

class Blocs {
  // Declaramos el bloc
  static final AuthBloc authBloc = AuthBloc(AuthRepository(),);
  static final AccommodationBloc accommodationBloc = AccommodationBloc(AccommodationRepository(),);
  static final DescribeBloc describeBloc = DescribeBloc(DescribeRepository(),);
  static final AccommodationTypeBloc accommodationTypeBloc = AccommodationTypeBloc(AccommodationTypeRepository(),);
  static final LocalizationBloc localizationBloc = LocalizationBloc(LocationService(),);
  static final ServiceBloc serviceBloc = ServiceBloc(ServiceRepository(),);
  static final AccommodationServiceBloc accommodationServiceBloc = AccommodationServiceBloc(AccommodationServiceRepository(),);
  static final AspectBloc aspectBloc = AspectBloc(AspectRepository(),);
  static final AccommodationAspectBloc accommodationAspectBloc = AccommodationAspectBloc(AccommodationAspectRepository(),);
  static final AccommodationPriceBloc accommodationPriceBloc = AccommodationPriceBloc(AccommodationPriceRepository(),);
  static final AccommodationDiscountBloc accommodationDiscountBloc = AccommodationDiscountBloc(AccommodationDiscountRepository(),);

  // Lista de blocs Providers para proveer a toda la aplicación
  static final blocsProviders = [
    BlocProvider<AuthBloc>(create: (context) => authBloc),
    BlocProvider<AccommodationBloc>(create: (context) => accommodationBloc),
    BlocProvider<DescribeBloc>(create: (context) => describeBloc),
    BlocProvider<AccommodationTypeBloc>(create: (context) => accommodationTypeBloc),
    BlocProvider<LocalizationBloc>(create: (context) => localizationBloc),
    BlocProvider<ServiceBloc>(create: (context) => serviceBloc),
    BlocProvider<AccommodationServiceBloc>(create: (context) => accommodationServiceBloc),
    BlocProvider<AspectBloc>(create: (context) => aspectBloc),
    BlocProvider<AccommodationAspectBloc>(create: (context) => accommodationAspectBloc),
    BlocProvider<AccommodationPriceBloc>(create: (context) => accommodationPriceBloc),
    BlocProvider<AccommodationDiscountBloc>(create: (context) => accommodationDiscountBloc),
  ];

  // Metodos para cerrar el bloc cuando no se necesite
  static void dispose() {
    authBloc.close();
    accommodationBloc.close();
    describeBloc.close();
    accommodationTypeBloc.close();
    localizationBloc.close();
    serviceBloc.close();
    accommodationServiceBloc.close();
    aspectBloc.close();
    accommodationAspectBloc.close();
    accommodationPriceBloc.close();
    accommodationDiscountBloc.close();
  }


  static final Blocs _instance = Blocs._internal();

  factory Blocs() {
    return _instance;
  }

  Blocs._internal();
}