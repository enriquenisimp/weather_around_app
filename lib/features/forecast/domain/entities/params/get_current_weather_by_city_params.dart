import 'package:equatable/equatable.dart';

class GetCurrentWeatherByCityParams extends Equatable {
  final String latitudeLongitude;
  const GetCurrentWeatherByCityParams({
    required this.latitudeLongitude,
  });

  @override
  List<Object?> get props => [latitudeLongitude];
}
