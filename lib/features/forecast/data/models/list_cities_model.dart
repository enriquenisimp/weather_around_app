import 'city_model.dart';

class ListCitiesModel {
  final List<CityModel> cities;

  ListCitiesModel(this.cities);

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
}
