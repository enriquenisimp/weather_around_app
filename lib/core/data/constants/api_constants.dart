class ApiConstants {
  static const String _baseUrl = 'https://api.weatherapi.com/v1';
  static String citySearch = "search.json";
  static String currentWeather = "current.json";
  static String forecastDetailWeather = "forecast.json";

  static String getAPiByEndPoint(String endPoint) {
    return "$_baseUrl/$endPoint";
  }

  static String apiKey = "a646078b00ed4d2cb89100129231708";
}
