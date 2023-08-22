import 'package:flutter/material.dart';
import 'package:weather_around_app/core/presentation/theme/theme_constants.dart';

class WeatherBox extends StatelessWidget {
  const WeatherBox({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    this.units,
  });
  final IconData icon;
  final String title;
  final String value;
  final String? units;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: ThemeConstants.dimensionSmall,
        vertical: ThemeConstants.dimensionSmall,
      ),
      margin: const EdgeInsets.symmetric(
        horizontal: ThemeConstants.dimensionExtraSmall,
        vertical: ThemeConstants.dimensionMedium,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.4),
        borderRadius: BorderRadius.circular(ThemeConstants.dimensionLarge),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: Colors.white,
              ),
              const SizedBox(
                width: 4,
              ),
              Text(title, style: Theme.of(context).textTheme.bodyMedium)
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Expanded(
            child: Center(
              child: RichText(
                text: TextSpan(
                  text: value,
                  style: Theme.of(context).textTheme.displaySmall,
                  children: [
                    if (units != null)
                      TextSpan(
                        text: units,
                        style: Theme.of(context).textTheme.bodyMedium,
                      )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
