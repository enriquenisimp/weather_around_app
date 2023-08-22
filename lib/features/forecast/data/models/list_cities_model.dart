import 'package:equatable/equatable.dart';

import 'city_model.dart';

class ListCitiesModel extends Equatable {
  final List<CityModel> cities;

  const ListCitiesModel(this.cities);

  factory ListCitiesModel.fromJson(List<dynamic> listCitiesJson) {
    final cities = <CityModel>[];
    for (var cityJson in listCitiesJson) {
      final city = CityModel.fromJson(cityJson);

      if (city != null) {
        cities.add(city);
      }
    }
    return ListCitiesModel(cities);
  }

  @override
  List<Object?> get props => [cities];
}
