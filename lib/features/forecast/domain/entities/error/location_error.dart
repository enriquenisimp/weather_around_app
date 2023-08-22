import 'package:weather_around_app/core/error/failure.dart';

enum LocationErrorType {
  disabled,
  permissionDenied,
  permanentlyDenied;

  String get name {
    switch (this) {
      case LocationErrorType.disabled:
        return 'Location services are disabled.';
      case LocationErrorType.permissionDenied:
        return 'Location permissions are denied';
      case LocationErrorType.permanentlyDenied:
        return 'Location permissions are permanently denied, we cannot request permissions.';
    }
  }
}

class LocationFailure extends Failure {
  final LocationErrorType errorType;
  LocationFailure(this.errorType) : super(errorType.name);
}
