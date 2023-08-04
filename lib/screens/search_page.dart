import 'package:flutter/material.dart';

import '../themes/dark_theme.dart';

import '../controllers/packages_controller.dart';

import '../widgets/package_widget.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({ super.key });

  @override
  State createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String query = '';

  @override
  Widget build(context) {
    var packagesController = PackagesController.instance;

    return Scaffold(
      backgroundColor: DarkTheme.background,
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        title: Padding(
          padding: const EdgeInsets.only(right: 15),
          child: TextField(
            maxLines: 1,
            maxLength: 30,
            decoration: const InputDecoration(
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              hintText: 'Search',
              hintStyle: TextStyle(fontWeight: FontWeight.w500, color: DarkTheme.secondary),
              counterText: '',
            ),
            style: const TextStyle(fontSize: 18, color: DarkTheme.primary),
            textAlign: TextAlign.center,
            onChanged: (value) => setState(() => query = value),
          ),
        ),
        centerTitle: true,
        titleSpacing: 0,
        actions: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.clear_rounded, size: 24, color: Colors.white),
          ),
          const SizedBox(width: 15),
        ],
        backgroundColor: DarkTheme.foreground,
      ),
      body: ListView(
        padding: const EdgeInsets.all(5),
        children: [
           for (var package in packagesController.packages.reversed.where((i) => i['name']!.toLowerCase().contains(query) || i['id'].toLowerCase().contains(query)))
            PackageWidget(
              name: package['name'],
              id: package['id'],
              description: package['description'],
              delivered: package['delivered'],
            ),
        ],
      ),
    );
  }
}
