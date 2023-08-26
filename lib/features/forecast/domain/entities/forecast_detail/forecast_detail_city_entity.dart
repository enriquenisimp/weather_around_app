import 'forecast_detail_day_entity.dart';
import 'forecast_detail_hour.dart';

class ForecastDetailCityEntity {
  final List<ForecastDetailByHour> forecastByHourList;
  final ForecastDetailDay forecastDetailDay;
  final double maxTemperature;
  final double minTemperature;
  final double averageTemperature;
  final DateTime localTime;
  ForecastDetailCityEntity({
    required this.forecastByHourList,
    required this.maxTemperature,
    required this.minTemperature,
    required this.averageTemperature,
    required this.localTime,
    required this.forecastDetailDay,
  });
}
