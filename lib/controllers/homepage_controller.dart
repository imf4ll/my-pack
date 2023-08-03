import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePageController extends ChangeNotifier {
  static HomePageController instance = HomePageController();

  List<String> packages = [];
  String packageID = '';

  void addPackage() {
    packages.add(packageID);

    notifyListeners();
  }

  void removePackage(int index) {
    packages.removeAt(index);

    HapticFeedback.vibrate();

    notifyListeners();
  }
}
