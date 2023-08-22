import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_around_app/core/data/constants/api_constants.dart';
import 'package:weather_around_app/core/data/constants/assets_constants.dart';
import 'package:weather_around_app/core/data/utils.dart';
import 'package:weather_around_app/features/forecast/data/models/list_cities_model.dart';
import 'package:weather_around_app/features/forecast/domain/entities/forecast_card/city_entity.dart';
import 'package:weather_around_app/features/forecast/domain/mapper/forecast_card/forecast_card_mapper.dart';

Future<void> main() async {
  group('ForecastMapper functions', () {
    test(
      'when usecase receive a ListCitiesModel, '
      'the mapper should convert it into a UI Entity',
      () async {
        WidgetsFlutterBinding.ensureInitialized();

        final json = await Utils.getJsonFromFile(
          MockConstants.getMockAPi(
            ApiConstants.citySearch,
          ),
        );
        final result = ForecastMapper.fromCityModelListToEntities(
            ListCitiesModel.fromJson(json).cities);

        expect(
          result,
          [
            const CityEntity(
              name: 'London',
              region: 'Ontario',
              country: 'Canada',
              latLong: '42.98,-81.25',
            )
          ],
        );
      },
    );
  });
}
