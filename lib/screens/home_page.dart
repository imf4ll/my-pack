import 'package:flutter/material.dart';

import '../controllers/packages_controller.dart';

import './search_page.dart';
import './delivered_page.dart';
import './settings_page.dart';

import '../widgets/package_widget.dart';
import '../widgets/empty_widget.dart';

import '../themes/dark_theme.dart';

import '../services/storage_service.dart';
import '../services/vibrate_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({ super.key });

  @override
  State createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var packagesController = PackagesController.instance;
  var storageService = StorageService();
  var vibrateService = VibrateService();

  TextEditingController packageNameController = TextEditingController();
  TextEditingController packageIDController = TextEditingController();

  List packages = [];

  @override
  void initState() {
    storageService.createStorage();

    storageService.getPackages().then((r) => setState(() {
      packages = r!;

      packagesController.setPackages(r);
    }));

    super.initState();
  }

  void addPackage() {
    var packageName = packageNameController.text;
    var packageID = packageIDController.text;

    if (packageName != '' && packageID != '') {
      if (packagesController.addPackage(packageNameController.text, packageIDController.text)) {
        packageNameController.clear();
        packageIDController.clear();
        
        Navigator.pop(context);

      } else {
        vibrateService.vibrateError();

      }
    
    } else {
      vibrateService.vibrateError();

    }
  }

  void showAddModal() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
      ),
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: BottomSheet(
            onClosing: () => {},
            constraints: const BoxConstraints(maxHeight: 275),
            builder: (context) {
              return Container(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        padding: const EdgeInsets.only(left: 20),
                        child: const Row(
                          children: [
                            Icon(Icons.local_shipping_rounded, color: DarkTheme.iconPrimary, size: 28),
                            SizedBox(width: 10),
                            Text('Add package', style: TextStyle(color: DarkTheme.primary, fontWeight: FontWeight.w600, fontSize: 18)),
                          ],  
                        ),
                      ),
                      const SizedBox(height: 15),
                      Padding(
                        padding: const EdgeInsets.only(left: 40, right: 40),
                        child: Column(
                          children: [
                            TextField(
                              controller: packageNameController,
                              decoration: const InputDecoration(
                              hintText: 'Description',
                                hintStyle: TextStyle(
                                  color: DarkTheme.terciary,
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.transparent),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(width: 2, color: DarkTheme.foreground),
                                ),
                              ),
                              style: const TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w500),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 10),
                            TextField(
                              controller: packageIDController,
                              decoration: const InputDecoration(
                                hintText: 'Tracking ID (ex: NL1232938445BR)',
                                hintStyle: TextStyle(
                                  color: DarkTheme.terciary,
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.transparent),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(width: 2, color: DarkTheme.foreground),
                                ),
                              ),
                              style: const TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w500),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () => addPackage(),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: DarkTheme.buttonPrimary,
                              ),
                              child: const Padding(
                                padding: EdgeInsets.only(top: 7.5, bottom: 7.5, right: 10, left: 10),
                                child: Icon(Icons.check),
                              ),
                            ),
                          ],  
                        ),
                      ),  
                    ],
                  ),
                ),
              );
            },
          ),
        );
      }
    );
  }

  @override
  Widget build(context) { 
    return AnimatedBuilder(
      animation: packagesController, 
      builder: (context, child) {
        return Scaffold(
          drawerEnableOpenDragGesture: true,
          drawerEdgeDragWidth: MediaQuery.of(context).size.width,
          drawer: Drawer(
            child: ListView(
              padding: const EdgeInsets.only(left: 10, right: 10),
              children: [
                const SizedBox(height: 40),
                ElevatedButton.icon(
                  onPressed: () => Navigator.push(context, MaterialPageRoute(
                      builder: (context) => const DeliveredPage(),
                  )),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: DarkTheme.background,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.all(10),
                    elevation: 0,
                  ),
                  icon: const Icon(Icons.check_circle, size: 28, color: DarkTheme.iconPrimary),
                  label: const Text('Delivered', style: TextStyle(fontSize: 16)),
                ),
                const SizedBox(height: 5),
                ElevatedButton.icon(
                  onPressed: () => Navigator.push(context, MaterialPageRoute(
                      builder: (context) => const SettingsPage(),
                  )),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: DarkTheme.background,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.all(10),
                  ),
                  icon: const Icon(Icons.settings_rounded, size: 28, color: DarkTheme.iconPrimary),
                  label: const Text('Settings', style: TextStyle(fontSize: 16)),
                ),
              ],
            ),
          ),
          appBar: AppBar(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            titleSpacing: 0,
            actions: [
              GestureDetector(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const SearchPage())),
                child: const Icon(Icons.search, size: 28, color: Colors.white),
              ),
              const SizedBox(width: 10),
            ],
            title: const Text(
              'Packages',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
            ),
          ),
          body: ListView(
            padding: const EdgeInsets.all(10),
            children: [
              if (packages.where((i) => i['delivered'] == false) .isNotEmpty) ...[
                for (var package in packages.where((i) => i['delivered'] == false).toList().reversed)
                  ...[
                    PackageWidget(
                      name: package['name'],
                      id: package['id'],
                      description: package['description'],
                      delivered: package['delivered'],
                      lastUpdate: package['lastUpdate'],
                      created: package['created'],
                    ),
                    const SizedBox(height: 10),
                  ]
              ] else ... [ const EmptyWidget() ],
            ],
          ),
          floatingActionButton: Padding(
            padding: const EdgeInsets.only(bottom: 15, right: 5),
            child: FloatingActionButton(
              onPressed: () => showAddModal(),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              backgroundColor: DarkTheme.buttonPrimary,
              child: const Icon(Icons.add_rounded, size: 30, color: Colors.white),
            ),
          ),
        );
      }
    );
  }
}
