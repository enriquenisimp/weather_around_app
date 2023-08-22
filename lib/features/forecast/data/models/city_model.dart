import 'package:equatable/equatable.dart';

class CityModel extends Equatable {
  final int id;
  final String name;
  final String region;
  final String country;
  final double latitude;
  final double longitude;
  final String url;

  const CityModel({
    required this.id,
    required this.name,
    required this.region,
    required this.country,
    required this.latitude,
    required this.longitude,
    required this.url,
  });

  static CityModel? fromJson(Map<String, dynamic> json) {
    try {
      final id = json['id'];
      final name = json['name'];
      final region = json['region'];
      final country = json['country'];
      final latitude = json['lat'];
      final longitude = json['lon'];
      final url = json['url'];

      return CityModel(
        id: id,
        name: name,
        region: region,
        country: country,
        latitude: latitude,
        longitude: longitude,
        url: url,
      );
    } catch (_) {
      return null;
    }
  }

  @override
  List<Object?> get props => [
        id,
        name,
        region,
        country,
        latitude,
        longitude,
        url,
      ];
}
