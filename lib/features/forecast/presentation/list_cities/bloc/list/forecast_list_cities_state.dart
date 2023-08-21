part of 'forecast_list_cities_cubit.dart';

class ForecastListCitiesState extends Equatable {
  final BaseStatus status;
  final List<CityEntity> cities;
  final Failure? failure;

  ForecastListCitiesState.empty()
      : status = BaseStatus.empty,
        cities = [],
        failure = null;

  ForecastListCitiesState.loading()
      : status = BaseStatus.loading,
        cities = [],
        failure = null;

  const ForecastListCitiesState.success(
    this.cities,
  )   : status = BaseStatus.success,
        failure = null;

  ForecastListCitiesState.error(
    this.failure,
  )   : status = BaseStatus.error,
        cities = [];

  @override
  List<Object?> get props => [
        status,
        cities,
        failure,
      ];
}
