import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_around_app/core/error/failure.dart';
import 'package:weather_around_app/core/presentation/bloc_status.dart';
import 'package:weather_around_app/features/forecast/domain/entities/forecast_card/city_entity.dart';
import 'package:weather_around_app/features/forecast/domain/entities/params/get_list_cities_params.dart';
import 'package:weather_around_app/features/forecast/domain/usecases/get_list_cities_by_name_usecase.dart';

part 'forecast_list_cities_state.dart';

class ForecastListCitiesCubit extends Cubit<ForecastListCitiesState> {
  ForecastListCitiesCubit(this._getListCitiesByNameUseCase)
      : super(ForecastListCitiesState.empty());
  final GetListCitiesByNameUseCase _getListCitiesByNameUseCase;

  void getCitiesByName({String? cityName}) async {
    if (cityName != null && cityName.isNotEmpty) {
      emit(ForecastListCitiesState.loading());

      final result = await _getListCitiesByNameUseCase(
        GetListCitiesParams(
          cityName: cityName,
        ),
      );

      result.fold(
        (failure) => emit(
          ForecastListCitiesState.error(
            failure,
          ),
        ),
        (listCities) => emit(
          ForecastListCitiesState.success(
            listCities,
          ),
        ),
      );
    } else {
      emit(ForecastListCitiesState.empty());
    }
  }
}
