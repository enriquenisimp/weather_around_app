import 'package:flutter/material.dart';

class EmptyListView extends StatelessWidget {
  const EmptyListView({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 20,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 20,
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.blue),
      child: Text(text),
    );
  }
}
