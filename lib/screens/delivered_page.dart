import 'package:flutter/material.dart';

import '../themes/dark_theme.dart';

import '../controllers/packages_controller.dart';

import '../widgets/package_widget.dart';
import '../widgets/empty_widget.dart';

class DeliveredPage extends StatelessWidget {
  const DeliveredPage({ super.key });

  @override
  Widget build(context) {
    var packagesController = PackagesController.instance;

    return Scaffold(
      backgroundColor: DarkTheme.background,
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        title: const Text('Delivered'),
        titleSpacing: 0,
        backgroundColor: DarkTheme.foreground,
      ),
      body: ListView(
        padding: const EdgeInsets.all(5),
        children: [
          if (packagesController.packages.where((i) => i.delivered!).isNotEmpty) ...[
            for (var package in packagesController.packages.reversed.where((i) => i.delivered!))
              PackageWidget(
                name: package.name,
                id: package.id,
                description: package.description,
                created: package.created,
                delivered: package.delivered,
                icon: const Icon(Icons.pending, color: Colors.white),
              ),  
            ] else ...[ const EmptyWidget() ],
        ],
      ),
    );
  }
}
