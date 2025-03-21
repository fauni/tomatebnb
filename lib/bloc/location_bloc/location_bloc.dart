import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tomatebnb/bloc/export_blocs.dart';


class LocationBloc extends Bloc<LocationEvent, LocationState> {
  LocationBloc() : super(LocationState()){
    on<LoadLocation>(_onLoadLocation);
  }

  Future<void> _onLoadLocation(LoadLocation event, Emitter<LocationState> emit) async {
    emit(state.copyWith(status: LocationStatus.loading));
    try {
      Position position = await _getCurrentLocation();
      emit(state.copyWith(status: LocationStatus.loaded, position: position));
    } catch (e) {
      emit(state.copyWith(status: LocationStatus.error, errorMessage: e.toString()));
    }
  }

  Future<Position> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Los servicios de ubicación están desactivados');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Los permisos de ubicación están denegados.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Los permisos de ubicación están denegados permanentemente, no podemos solicitar permisos.');
    }
    return await Geolocator.getCurrentPosition();
  }

}