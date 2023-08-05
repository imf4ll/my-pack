import 'package:flutter/material.dart';

import '../controllers/packages_controller.dart';

import '../widgets/package_widget.dart';
import '../widgets/empty_widget.dart';

class DeliveredPage extends StatefulWidget {
  const DeliveredPage({ super.key });

  @override
  State createState() => _DeliveredPageState();
}

class _DeliveredPageState extends State<DeliveredPage> {
  @override
  Widget build(context) {
    var packagesController = PackagesController.instance;

    return AnimatedBuilder(
      animation: packagesController,
      builder: (context, child) {
        return Scaffold(
          appBar: AppBar(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            title: const Text('Delivered'),
            titleSpacing: 0,
          ),
          body: ListView(
            padding: const EdgeInsets.all(10),
            children: [
              if (packagesController.packages.where((i) => i['delivered']).isNotEmpty) ...[
                for (var package in packagesController.packages.reversed.where((i) => i['delivered']))
                  PackageWidget(
                    name: package['name'],
                    id: package['id'],
                    description: package['description'],
                    delivered: package['delivered'],
                    lastUpdate: package['lastUpdate'],
                  ),  
                ] else ...[ const EmptyWidget() ],
            ],
          ),
        );
      }
    );
  }
}
