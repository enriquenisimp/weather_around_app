import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({super.key, required this.onSearch});
  final Function(String? cityName) onSearch;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onSearch,
      decoration: const InputDecoration(
        hintText: 'Search...',
        prefixIcon: Icon(Icons.search),
      ),
    );
  }
}
