import 'package:flutter/material.dart';

class HorizontalDivider extends StatelessWidget {
  final double width;
  final double height;
  final Color color;
  final double borderRadius;
  final double? padding;
  const HorizontalDivider(
      {Key? key,
      this.width: 3,
      required this.height,
      this.color: Colors.white,
      this.borderRadius: 60,
      this.padding})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          top: 6, bottom: 6, left: padding ?? 10, right: padding ?? 10),
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(
          borderRadius,
        ),
      ),
    );
  }
}
