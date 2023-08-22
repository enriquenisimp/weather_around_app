import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weather_around_app/core/data/constants/assets_constants.dart';
import 'package:weather_around_app/core/presentation/theme/theme_constants.dart';

class ErrorDetailView extends StatelessWidget {
  const ErrorDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
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
                WeatherConstants.weatherError,
              ),
              height: 120,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Something went wrong',
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              'Please try a different city',
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
