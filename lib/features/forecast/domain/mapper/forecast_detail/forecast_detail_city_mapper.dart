import 'package:weather_around_app/features/forecast/data/models/forecast_model.dart';
import 'package:weather_around_app/features/forecast/domain/entities/enums/period_day.dart';
import 'package:weather_around_app/features/forecast/domain/entities/forecast_card/current_weather_city_entity.dart';
import 'package:weather_around_app/features/forecast/domain/entities/forecast_detail/forecast_detail_city_entity.dart';
import 'package:weather_around_app/features/forecast/domain/entities/forecast_detail/forecast_detail_day_entity.dart';
import 'package:weather_around_app/features/forecast/domain/entities/forecast_detail/forecast_detail_hour.dart';

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
      forecastDetailDay: fromForecastDayModelToEntity(
          forecastModel.forecast.forecastDay.first.day),
    );
  }

  static fromForecastDayModelToEntity(Day day) {
    return ForecastDetailDay(
      maxTempC: day.maxtempC,
      minTempC: day.mintempC,
      avgTempC: day.avgtempC,
      maxWindKph: day.maxwindKph,
      totalPrecipitationMm: day.totalprecipMm,
      avgHumidity: day.avghumidity,
      dailyWillItRain: day.dailyWillItRain,
      dailyChanceOfRain: day.dailyChanceOfRain,
      dailyWillItSnow: day.dailyChanceOfSnow,
      dailyChanceOfSnow: day.dailyChanceOfSnow,
      condition: WeatherConditionsEntity(
        description: day.condition.description,
        iconUrl: day.condition.iconUrl,
      ),
      uv: day.uv,
    );
  }

  static fromForecastByHourModelToEntity(Hour forecastByHour) {
    print(forecastByHour);
    return ForecastDetailByHour(
      hourOfTheDay: forecastByHour.dateTimeOfDay.hour,
      periodOfDay: PeriodOfDay.calculateByHour(
          forecastByHour.isDay, forecastByHour.dateTimeOfDay),
      temperature: forecastByHour.tempC,
      weatherConditionsEntity: WeatherConditionsEntity(
        description: forecastByHour.condition.description,
        iconUrl: forecastByHour.condition.iconUrl,
      ),
      windDegree: forecastByHour.windDegree,
      windDir: forecastByHour.windDir ?? WindDir.unknown,
      windKph: forecastByHour.windKph,
      uv: forecastByHour.uv,
      chanceOfRain: forecastByHour.chanceOfRain,
      precipitationMM: forecastByHour.precipMm,
      isCloudy: forecastByHour.cloud > 25,
      chanceOfSnow: forecastByHour.chanceOfSnow,
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
