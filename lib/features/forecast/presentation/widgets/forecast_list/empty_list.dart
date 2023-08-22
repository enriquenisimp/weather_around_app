import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weather_around_app/core/data/constants/assets_constants.dart';
import 'package:weather_around_app/core/presentation/theme/theme_constants.dart';

class EmptyListView extends StatelessWidget {
  const EmptyListView({
    super.key,
    required this.title,
    required this.subtitle,
  });
  final String title;
  final String subtitle;
  const EmptyListView.empty({super.key})
      : title = 'Welcome to WeatherAround!',
        subtitle = 'Start your search and see the weather around the world!';
  @override
  Widget build(BuildContext context) {
    return Container(
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
          )
        ],
      ),
    );
  }
}
