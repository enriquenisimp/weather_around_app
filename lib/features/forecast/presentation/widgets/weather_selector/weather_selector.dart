import 'package:flutter/material.dart';
import 'package:weather_animation/weather_animation.dart';
import 'package:weather_around_app/features/forecast/domain/entities/enums/period_day.dart';
import 'package:weather_around_app/features/forecast/domain/entities/enums/weather_type.dart';

class WeatherSelector extends StatelessWidget {
  const WeatherSelector({
    super.key,
    required this.weatherType,
    required this.periodOfDay,
  });
  final WeatherType weatherType;
  final PeriodOfDay periodOfDay;
  @override
  Widget build(BuildContext context) {
    switch (weatherType) {
      case WeatherType.snowing:
        return const SnowWidget();
      case WeatherType.raining:
        return Stack(
          fit: StackFit.expand,
          children: [
            RainWidget(
              rainConfig: RainConfig(
                  widthDrop: 2,
                  areaYStart: 250,
                  areaYEnd: MediaQuery.of(context).size.height,
                  color: Colors.white),
            ),
            customCloudWidget(color: Colors.grey),
          ],
        );
        break;
      case WeatherType.clear:
        if (periodOfDay.isNight) {
          return SunWidget(
            sunConfig: const SunConfig(
              blurSigma: 700,
              isLeftLocation: false,
              coreColor: Colors.white,
              midColor: Colors.white,
              outColor: Colors.white,
              animMidMill: 2000,
              animOutMill: 2000,
            ).copyWith(width: MediaQuery.of(context).size.width * 0.5),
          );
        } else {
          return const SunWidget(
            sunConfig: SunConfig(
              isLeftLocation: false,
              blurSigma: 700,
            ),
          );
        }
      case WeatherType.cloudy:
        return customCloudWidget();
      case WeatherType.storm:
        return Stack(
          children: [
            customCloudWidget(),
            const ThunderWidget(),
          ],
        );
    }
  }

  Widget customCloudWidget({Color? color}) {
    return Stack(
      children: [
        Positioned.fill(
          child: CloudWidget(
            cloudConfig: CloudConfig(
              size: 150,
              color: (color ?? Colors.white).withOpacity(0.7),
            ),
          ),
        ),
        CloudWidget(
          cloudConfig: CloudConfig(
            size: 300,
            color: (color ?? Colors.white).withOpacity(0.7),
          ),
        ),
      ],
    );
  }
}
