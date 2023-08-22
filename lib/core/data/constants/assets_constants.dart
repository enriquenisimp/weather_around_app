class _AssetsConstants {
  static const assetsPath = 'assets';
  static const imagesPath = '$assetsPath/images';
}

class WeatherConstants {
  static const _imagePath = _AssetsConstants.imagesPath;
  static const weatherNotification = 'weather_notification.svg';
  static getWeatherImage(String asset) {
    return '$_imagePath/$asset';
  }
}

class MockConstants {
  static const _mockAPi = "${_AssetsConstants.assetsPath}/mocks";
  static const weatherNotification = 'weather_notification.svg';
  static getMockAPi(String asset) {
    return '$_mockAPi/$asset';
  }
}
