import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_around_app/core/error/failure.dart';
import 'package:weather_around_app/features/forecast/domain/entities/error/location_error.dart';

part 'geo_location_state.dart';

class GeoLocationCubit extends Cubit<GeoLocationState> {
  GeoLocationCubit() : super(const GeoLocationState.loading());

  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  void determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    String message = '';
    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      safeEmit(GeoLocationState.noLocation(
          LocationFailure(LocationErrorType.disabled)));
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        safeEmit(GeoLocationState.noLocation(
            LocationFailure(LocationErrorType.permissionDenied)));
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      safeEmit(GeoLocationState.noLocation(
          LocationFailure(LocationErrorType.permanentlyDenied)));
      return;
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    safeEmit(GeoLocationState.located(await Geolocator.getCurrentPosition()));
  }

  void safeEmit(GeoLocationState newState) {
    if (!isClosed) {
      emit(newState);
    }
  }
}
