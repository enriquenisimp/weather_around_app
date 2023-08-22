import 'package:equatable/equatable.dart';

class CityEntity extends Equatable {
  final String name;
  final String region;
  final String country;
  final String latLong;

  const CityEntity({
    required this.name,
    required this.region,
    required this.country,
    required this.latLong,
  });

  @override
  List<Object?> get props => [
        name,
        region,
        country,
        latLong,
      ];
}
