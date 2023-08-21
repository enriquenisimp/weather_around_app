import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:weather_around_app/core/domain/usecases/usecase.dart';
import 'package:weather_around_app/core/error/failure.dart';
import 'package:weather_around_app/features/forecast/data/repositories/forecast_repository.dart';
import 'package:weather_around_app/features/forecast/domain/entities/forecast_detail/forecast_detail_city_entity.dart';
import 'package:weather_around_app/features/forecast/domain/entities/params/get_current_weather_by_city_params.dart';
import 'package:weather_around_app/features/forecast/domain/mapper/forecast_detail/forecast_detail_city_mapper.dart';

@injectable
class GetForecastDetailWeatherByCityUseCase
    extends UseCase<ForecastDetailCityEntity, GetCurrentWeatherByCityParams> {
  final ForecastRepository _forecastRepository;

  GetForecastDetailWeatherByCityUseCase(this._forecastRepository);
  @override
  Future<Either<Failure, ForecastDetailCityEntity>> call(params) async {
    final currentWeatherResult =
        await _forecastRepository.getForecastWeatherDetailByCityRepository(
      params.latitudeLongitude,
    );

    return currentWeatherResult.fold(
      (failure) => Left(failure),
      (forecastDetailWeatherModel) {
        return Right(
          ForecastDetailCityMapper.fromForecastModelToEntity(
            forecastDetailWeatherModel,
          ),
        );
      },
    );
  }
}
