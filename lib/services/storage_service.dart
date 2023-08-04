import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

Future<void> createStorage() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  if (prefs.getString('packages') == null) {
    await prefs.setString('packages', '');

  }
}

Future<void> storePackages(List packages) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  List<String> packagesToJson = [];

  packages.forEach((i) => packagesToJson.add(json.encode(i)));

  await prefs.setString('packages', packagesToJson.toString());
}

Future<List?> getPackages() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  final packages = prefs.getString('packages');

  if (packages != null) {
    return json.decode(packages);

  } else {
    return [];

  }
}

Future<void> clearStorage() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  await prefs.clear();
}
