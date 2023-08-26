import 'package:animated_digit/animated_digit.dart';
import 'package:flutter/material.dart';

class WeatherDigitWidget extends StatefulWidget {
  final int? value;
  final String suffix;
  final TextStyle? style;
  final int min;
  final int max;
  final String? prefix;
  const WeatherDigitWidget({
    super.key,
    required this.value,
    required this.suffix,
    required this.style,
    required this.min,
    required this.max,
    this.prefix,
  });

  const WeatherDigitWidget.degrees({
    super.key,
    required this.value,
    required this.style,
    this.prefix,
  })  : suffix = "°",
        min = 12,
        max = 30;
  @override
  State<WeatherDigitWidget> createState() => _WeatherDigitWidgetState();
}

class _WeatherDigitWidgetState extends State<WeatherDigitWidget>
    with SingleTickerProviderStateMixin {
  final AnimatedDigitController _animatedDigitController =
      AnimatedDigitController(0);

  @override
  void initState() {
    super.initState();
    _addValue();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedDigitWidget(
      controller: _animatedDigitController,
      duration: const Duration(seconds: 1),
      suffix: widget.suffix,
      prefix: widget.prefix,
      textStyle: widget.style,
      valueColors: [
        ValueColor(
          condition: () => true,
          color: Colors.white,
        ),
        ValueColor(
          condition: () => _animatedDigitController.value < widget.min,
          color: Colors.blueAccent,
        ),
        ValueColor(
          condition: () => _animatedDigitController.value > widget.max,
          color: Colors.redAccent,
        ),
      ],
    );
  }

  void _addValue() {
    _animatedDigitController.addValue(widget.value ?? 0);
  }

  @override
  void dispose() {
    _animatedDigitController.dispose();
    super.dispose();
  }
}
