import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/package_model.dart';
import '../models/update_model.dart';

class PackagesController extends ChangeNotifier {
  static PackagesController instance = PackagesController();

  List<PackageModel> packages = [];

  void addPackage(String packageName, String packageID) {
    packages.add(PackageModel(
        name: packageName,
        id: packageID,
        description: '',
        created: DateTime.now().millisecondsSinceEpoch,
        updates: List<UpdateModel>.empty(),
        delivered: false,
    ));
    
    HapticFeedback.vibrate();

    notifyListeners();
  }

  void removePackage(String id) {
    packages.removeWhere((i) => i.id == id);
    
    HapticFeedback.vibrate();

    notifyListeners();
  }
}
