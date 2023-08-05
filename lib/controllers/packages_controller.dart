import 'package:flutter/material.dart';

import '../models/package_model.dart';

import '../services/storage_service.dart';
import '../services/vibrate_service.dart';

class PackagesController extends ChangeNotifier {
  static PackagesController instance = PackagesController();
  
  var storageService = StorageService();
  var vibrateService = VibrateService();

  List packages = [];

  void clearPackages() {
    packages = [];

    notifyListeners();
  }

  void setPackages(List pkgs) => packages = pkgs;

  bool addPackage(String packageName, String packageID) {
    if (packages.where((i) => i['id'] == packageID).isEmpty) {
      packages.add(PackageModel(
        name: packageName,
        id: packageID,
        description: 'Tap to update',
        delivered: false,
        lastUpdate: 'Just now',
      ).toJson());

      storageService.storePackages(packages);
      
      vibrateService.vibrateDelete();

      notifyListeners();
      
      return true;
    }

    return false;
  }

  void removePackage(String id) {
    packages.removeWhere((i) => i['id'] == id);
    
    storageService.storePackages(packages);
    
    vibrateService.vibrateDelete();

    notifyListeners();
  }

  void updateDescription(String id, String description) {
    packages[packages.indexWhere((i) => i['id'] == id)]['description'] = description;
    
    storageService.storePackages(packages);

    notifyListeners();
  }

  void updateDelivered(String id) {
    packages[packages.indexWhere((i) => i['id'] == id)]['delivered'] = true;

    storageService.storePackages(packages);

    notifyListeners();
  }

  void updateDate(String id, int timestamp) {
    packages[packages.indexWhere((i) => i['id'] == id)]['lastUpdate'] = _since(timestamp);

    storageService.storePackages(packages);

    notifyListeners();
  }

  String _since(int timestamp) {
    int difference = DateTime.now().difference(DateTime.fromMillisecondsSinceEpoch(timestamp)).inMinutes;

    switch (difference) {
      case > 60 * 24: return '${ (difference / 24 / 60).round() } days ago';

      case > 60: return '${ (difference / 60).round() } hours ago';
      
      default: return '$difference minutes ago';
    }
  }
}
