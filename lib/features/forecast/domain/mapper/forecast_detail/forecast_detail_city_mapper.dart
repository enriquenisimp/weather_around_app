import 'package:weather_around_app/features/forecast/data/models/forecast_model.dart';
import 'package:weather_around_app/features/forecast/domain/entities/forecast_card/current_weather_city_entity.dart';
import 'package:weather_around_app/features/forecast/domain/entities/forecast_detail/forecast_detail_city_entity.dart';

class ForecastDetailCityMapper {
  static fromForecastModelToEntity(ForecastModel forecastModel) {
    final forecastByHourList = <ForecastDetailByHour>[];
    for (final forecastByHourModel
        in forecastModel.forecast.forecastDay.first.hour) {
      final forecastHour = fromForecastByHourModelToEntity(forecastByHourModel);
      forecastByHourList.add(forecastHour);
    }

    return ForecastDetailCityEntity(
      forecastByHourList: forecastByHourList,
      maxTemperature: forecastModel.forecast.forecastDay.first.day.maxtempC,
      averageTemperature: forecastModel.forecast.forecastDay.first.day.avgtempC,
      minTemperature: forecastModel.forecast.forecastDay.first.day.mintempC,
      localTime: forecastModel.location.localTimeDate(),
    );
  }

  static fromForecastByHourModelToEntity(Hour forecastByHour) {
    return ForecastDetailByHour(
      hourOfTheDay: forecastByHour.dateTimeOfDay.hour,
      periodOfDay: PeriodOfDay.getFromHour(forecastByHour.dateTimeOfDay.hour),
      temperature: forecastByHour.tempC,
      weatherConditionsEntity: WeatherConditionsEntity(
        description: forecastByHour.condition.description,
        iconUrl: forecastByHour.condition.iconUrl,
      ),
      windDegree: forecastByHour.windDegree,
      windDir: forecastByHour.windDir ?? WindDir.unknown,
      windKph: forecastByHour.windKph,
    );
  }
}
