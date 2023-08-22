import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_around_app/core/di/injection.dart';
import 'package:weather_around_app/core/presentation/bloc_status.dart';
import 'package:weather_around_app/features/forecast/domain/usecases/get_current_weather_by_city_usecase.dart';
import 'package:weather_around_app/features/forecast/domain/usecases/get_list_cities_by_name_usecase.dart';
import 'package:weather_around_app/features/forecast/presentation/detail_city/detail_city_page.dart';
import 'package:weather_around_app/features/forecast/presentation/list_cities/bloc/current_weather/current_weather_cubit.dart';
import 'package:weather_around_app/features/forecast/presentation/list_cities/bloc/list/forecast_list_cities_cubit.dart';
import 'package:weather_around_app/features/forecast/presentation/widgets/cards/forecast_city_item_card.dart';
import 'package:weather_around_app/features/forecast/presentation/widgets/forecast_list/empty_list.dart';
import 'package:weather_around_app/features/forecast/presentation/widgets/search_bar.dart';

class ForecastListCitiesPage extends StatelessWidget {
  const ForecastListCitiesPage({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ForecastListCitiesCubit(
            getIt<GetListCitiesByNameUseCase>(),
          )..getCitiesByName(),
        ),
        BlocProvider(
          create: (context) =>
              CurrentWeatherCubit(getIt<GetCurrentWeatherByCityUseCase>()),
        ),
      ],
      child: const ForecastListCitiesView(),
    );
  }
}

class ForecastListCitiesView extends StatelessWidget {
  const ForecastListCitiesView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SearchBar(
          onSearch: (String? cityName) {
            context.read<ForecastListCitiesCubit>().getCitiesByName(
                  cityName: cityName,
                );
          },
        ),
      ),
      body: BlocConsumer<ForecastListCitiesCubit, ForecastListCitiesState>(
        listener: (context, state) {
          if (state.status == BaseStatus.success) {
            context
                .read<CurrentWeatherCubit>()
                .getCurrentWeathersOfCitiesAvailable(
                  state.cities.map((e) => e.latLong).toList(),
                );
          }
        },
        builder: (context, state) {
          return _buildWidgetByStatus(
            state: state,
            child: ListView.builder(
              itemCount: state.cities.length,
              itemBuilder: (context, index) {
                final city = state.cities[index];
                return ForecastCityItemCard(
                  cityIndex: index,
                  city: city,
                  onCitySelected: (int index) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailCityForecastPage(
                          city: city,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildWidgetByStatus({
    required Widget child,
    required ForecastListCitiesState state,
  }) {
    switch (state.status) {
      case BaseStatus.empty:
        return const EmptyListView.empty();
      case BaseStatus.loading:
        return const Center(
          child: CircularProgressIndicator(),
        );
      case BaseStatus.success:
        if (state.cities.isNotEmpty) {
          return child;
        } else {
          return const EmptyListView(
            title: 'No cities found',
            subtitle:
                'No cities found with that name, please try a different one',
          );
        }
      default:
        return EmptyListView(
          title: state.failure?.message ?? 'Something went wrong',
          subtitle: 'Try again later',
        );
    }
  }
}
