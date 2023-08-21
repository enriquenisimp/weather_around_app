class _AssetsConstants {
  static const assetsPath = 'assets';
  static const iconsPath = '$assetsPath/icons';
  static const weatherPath = '$iconsPath/weather';
  static const conditionsPath = '$assetsPath/conditions';
}

class WeatherConstants {
  static const _dayWeatherPath = '${_AssetsConstants.weatherPath}/day';
  static const _nightWeatherPath = '${_AssetsConstants.weatherPath}/night';
  static getWeatherIcon(bool isNight, int code) {
    if (isNight) return '$_nightWeatherPath/$code.png';
    return '$_dayWeatherPath/$code.png';
  }
}

class WeatherConditionsConstants {
  static const weatherConditionsPath =
      '${_AssetsConstants.conditionsPath}/conditions.json';
}
