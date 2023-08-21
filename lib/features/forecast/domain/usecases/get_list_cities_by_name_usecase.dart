import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:weather_around_app/core/domain/usecases/usecase.dart';
import 'package:weather_around_app/core/error/failure.dart';
import 'package:weather_around_app/features/forecast/data/repositories/forecast_repository.dart';
import 'package:weather_around_app/features/forecast/domain/entities/forecast_card/city_entity.dart';
import 'package:weather_around_app/features/forecast/domain/entities/params/get_list_cities_params.dart';
import 'package:weather_around_app/features/forecast/domain/mapper/forecast_card/forecast_card_mapper.dart';

@injectable
class GetListCitiesByNameUseCase
    extends UseCase<List<CityEntity>, GetListCitiesParams> {
  final ForecastRepository _forecastRepository;

  GetListCitiesByNameUseCase(this._forecastRepository);
  @override
  Future<Either<Failure, List<CityEntity>>> call(params) async {
    final cityModelListResult =
        await _forecastRepository.getListCitiesByNameRepository(
      params.cityName,
    );

    return cityModelListResult.fold(
      (failure) => Left(failure),
      (cityModelList) => Right(
        ForecastMapper.fromCityModelListToEntities(
          cityModelList.cities,
        ),
      ),
    );
  }
}
