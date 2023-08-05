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
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(context) {
    var packagesController = PackagesController.instance;

    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        title: Padding(
          padding: const EdgeInsets.only(right: 15),
          child: TextField(
            controller: searchController,
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
            onChanged: (value) => setState(() => {}),
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
      ),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          for (var package in packagesController.packages.reversed.where((i) =>
            i['name']!.toLowerCase().contains(searchController.text) || i['id'].toLowerCase().contains(searchController.text))
          )
            PackageWidget(
              name: package['name'],
              id: package['id'],
              description: package['description'],
              delivered: package['delivered'],
              lastUpdate: package['lastUpdate'],
            ),
        ],
      ),
    );
  }
}
