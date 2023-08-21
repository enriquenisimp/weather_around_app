class WeatherConditionModel {
  final int code;
  final String description;
  final String iconUrl;

  WeatherConditionModel({
    required this.code,
    required this.description,
    required this.iconUrl,
  });

  static WeatherConditionModel fromJson(Map<String, dynamic> conditionJson) {
    final code = conditionJson["code"];
    final description = conditionJson["text"];
    final iconUrl = "https:${conditionJson["icon"]}";

    return WeatherConditionModel(
      code: code,
      description: description,
      iconUrl: iconUrl,
    );
  }
}
