import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './packages_controller.dart';

class HomePageController extends ChangeNotifier {
  static HomePageController instance = HomePageController();
  
  var packagesController = PackagesController.instance;

  String packageName = '';
  String packageID = '';

  bool addPackage() {
    if (packageName != '' && packageID != '') {
      if (packagesController.addPackage(packageName, packageID)) {
        packageName = '';
        packageID = '';
      
        notifyListeners();

        return true;
      
      } else {
        _vibrate();
        
        return false;
      }

    } else {
      _vibrate();

      return false;
    }
  }

  void _vibrate() {
      HapticFeedback.vibrate();

      sleep(const Duration(milliseconds: 200));
      
      HapticFeedback.vibrate();
  }

  void removePackage(String id) {
    packagesController.removePackage(id);

    notifyListeners();
  }
}
