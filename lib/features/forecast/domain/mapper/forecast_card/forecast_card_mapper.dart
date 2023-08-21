import 'package:weather_around_app/features/forecast/data/models/city_model.dart';
import 'package:weather_around_app/features/forecast/data/models/current_weather_model.dart';
import 'package:weather_around_app/features/forecast/domain/entities/forecast_card/city_entity.dart';
import 'package:weather_around_app/features/forecast/domain/entities/forecast_card/current_weather_city_entity.dart';

class ForecastMapper {
  static CityEntity fromCityModelToEntity(CityModel cityModel) {
    return CityEntity(
        name: cityModel.name,
        region: cityModel.region,
        country: cityModel.country,
        latLong: "${cityModel.latitude},${cityModel.longitude}");
  }

  static List<CityEntity> fromCityModelListToEntities(
      List<CityModel> cityModelList) {
    final cityEntityList = <CityEntity>[];
    for (var cityModel in cityModelList) {
      final cityEntity = ForecastMapper.fromCityModelToEntity(cityModel);
      cityEntityList.add(cityEntity);
    }
    return cityEntityList;
  }

  static CurrentWeatherCityEntity fromCurrentWeatherModelToEntity(
      CurrentWeatherModel currentWeatherModel) {
    final periodOfDay = _calculatePeriodOfDay(
      currentWeatherModel.isDay,
      currentWeatherModel.localTimeDate(),
    );
    return CurrentWeatherCityEntity(
      periodOfDay: periodOfDay,
      localDateTime: currentWeatherModel.localTimeDate(),
      temperature: currentWeatherModel.tempC,
      isCloudy: currentWeatherModel.cloud > 20,
      weatherConditions: WeatherConditionsEntity(
        description: currentWeatherModel.weatherCondition.description,
        iconUrl: currentWeatherModel.weatherCondition.iconUrl,
      ),
    );
  }

  static PeriodOfDay _calculatePeriodOfDay(int isDay, DateTime dateTime) {
    if (isDay == 0) return PeriodOfDay.night;

    if (dateTime.hour < 11) {
      return PeriodOfDay.morning;
    }

    if (dateTime.hour < 16) {
      return PeriodOfDay.afternoon;
    }

    return PeriodOfDay.evening;
  }
}
