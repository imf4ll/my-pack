import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './packages_controller.dart';

class HomePageController extends ChangeNotifier {
  static HomePageController instance = HomePageController();

  String packageName = '';
  String packageID = '';

  bool addPackage() {
    if (packageName != '' && packageID != '') {
      PackagesController.instance.addPackage(packageName, packageID);

      packageName = '';
      packageID = '';
    
      notifyListeners();

      return true;
    
    } else {
      HapticFeedback.vibrate();

      sleep(const Duration(milliseconds: 200));
      
      HapticFeedback.vibrate();

      return false;
    }
  }

  void removePackage(String id) {
    PackagesController.instance.removePackage(id);

    notifyListeners();
  }
}
