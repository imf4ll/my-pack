import 'package:flutter/material.dart';

import '../themes/dark_theme.dart';

import '../services/storage_service.dart';

import '../controllers/packages_controller.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({ super.key });

  @override
  Widget build(context) {
    var packagesController = PackagesController.instance;

    return Scaffold(
      backgroundColor: DarkTheme.background,
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        titleSpacing: 0,
        title: const Text(
          'Settings',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 20,
          ),
        ),
        backgroundColor: DarkTheme.foreground,
        actions: const [
          Center(child: Padding(
            padding: EdgeInsets.only(right: 15),
            child: Text('v1.0.0', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: DarkTheme.secondary)),
          )),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(5),
        physics: const ScrollPhysics(),
        children: [
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
            color: DarkTheme.cardBackground,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Storage', style: TextStyle(fontSize: 15, color: DarkTheme.terciary, fontWeight: FontWeight.w500)),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Clear storage', style: TextStyle(fontSize: 18, color: DarkTheme.primary, fontWeight: FontWeight.w500)),
                      ElevatedButton(
                        onPressed: () {
                          clearStorage().then((_) {
                            packagesController.clearPackages();

                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                content: Text('Storage cleared succesfully'),
                            ));
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: DarkTheme.buttonRed,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
                        ),
                        child: const Text('Clear', style: TextStyle(fontSize: 15, color: DarkTheme.primary, fontWeight: FontWeight.w500)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),  
    );
  }
}
