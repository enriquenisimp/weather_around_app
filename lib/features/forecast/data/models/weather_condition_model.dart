import 'package:equatable/equatable.dart';

class WeatherConditionModel extends Equatable {
  final int code;
  final String description;
  final String iconUrl;

  const WeatherConditionModel({
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

  @override
  List<Object?> get props => [code, description, iconUrl];
}
