import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_around_app/core/data/constants/assets_constants.dart';
import 'package:weather_around_app/core/presentation/theme/theme_constants.dart';
import 'package:weather_around_app/features/forecast/presentation/widgets/forecast_list/bloc/geo_location_cubit.dart';

class EmptyListView extends StatelessWidget {
  const EmptyListView({
    super.key,
    required this.title,
    required this.subtitle,
    required this.showCurrentLocation,
  });
  final String title;
  final String subtitle;
  final Function(Position position) showCurrentLocation;
  const EmptyListView.empty({super.key, required this.showCurrentLocation})
      : title = 'Welcome to WeatherAround!',
        subtitle = 'Start your search and see the weather around the world!';
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GeoLocationCubit()..determinePosition(),
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: ThemeConstants.dimensionMedium,
          vertical: ThemeConstants.dimensionLarge,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: ThemeConstants.dimensionMedium,
          vertical: ThemeConstants.dimensionLarge,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(ThemeConstants.dimensionLarge),
          color: Colors.white.withOpacity(0.4),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              WeatherConstants.getWeatherImage(
                WeatherConstants.weatherNotification,
              ),
              height: 100,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              subtitle,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            BlocBuilder<GeoLocationCubit, GeoLocationState>(
                builder: (context, state) {
              if (state.geoStatus == GeoStatus.loading) {
                return const CircularProgressIndicator();
              } else if (state.geoStatus == GeoStatus.noLocation) {
                return Text(state.failure?.message ??
                    "Something went wrong getting location");
              } else {
                return ElevatedButton(
                  child: const Text('Search your location'),
                  onPressed: () {
                    if (state.position != null) {
                      showCurrentLocation(state.position!);
                    }
                  },
                );
              }
            })
          ],
        ),
      ),
    );
  }
}
