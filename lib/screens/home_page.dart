import 'package:flutter/material.dart';

import '../controllers/packages_controller.dart';
import '../controllers/homepage_controller.dart';

import './search_page.dart';
import './delivered_page.dart';

import '../widgets/package_widget.dart';
import '../widgets/empty_widget.dart';

import '../themes/dark_theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({ super.key });

  @override
  State createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var packagesController = PackagesController.instance;
  var homePageController = HomePageController.instance;

  @override
    void initState() {
      super.initState();

      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (packagesController.packages.isEmpty) {
          showAddModal();

        }
      });
    }

  void showAddModal() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
      ),
      isScrollControlled: true,
      backgroundColor: DarkTheme.background,
      builder: (context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: BottomSheet(
            onClosing: () => {},
            constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.32),
            backgroundColor: Colors.transparent,
            builder: (context) {
              return Container(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 20),
                          child: Row(
                          children: [
                            Icon(Icons.inventory_2, color: DarkTheme.iconPrimary, size: 28),
                            SizedBox(width: 10),
                            Text('Add package', style: TextStyle(color: DarkTheme.secondary, fontWeight: FontWeight.w600, fontSize: 18)),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(left: 40, right: 40),
                        child: Column(
                          children: [
                            TextField(
                              decoration: const InputDecoration(
                              hintText: 'Name',
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
                              onChanged: (value) => setState(() => homePageController.packageName = value),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 5),
                            TextField(
                              decoration: const InputDecoration(
                                hintText: 'Package ID',
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
                              onChanged: (value) => setState(() => homePageController.packageID = value),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () => setState(() => homePageController.addPackage() ? Navigator.pop(context) : {}),
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
            }
          ),
        );
      }
    );
  }

  @override
  Widget build(context) { 
    return AnimatedBuilder(
      animation: Listenable.merge(
        [ homePageController, packagesController ],
      ),
      builder: (context, child) {
        return Scaffold(
          backgroundColor: DarkTheme.background,
          drawer: Drawer(
            backgroundColor: DarkTheme.background,
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
                  ),
                  icon: const Icon(Icons.check_circle, size: 28, color: DarkTheme.iconPrimary),
                  label: const Text('Delivered', style: TextStyle(fontSize: 16)),
                ),
                ElevatedButton.icon(
                  onPressed: () => {},
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
              'My Pack',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
            ),
            backgroundColor: DarkTheme.foreground,
          ),
          body: RefreshIndicator(
            onRefresh: () => Future<void>.delayed(const Duration(seconds: 3)),
            backgroundColor: DarkTheme.background,
            color: DarkTheme.primary,
            child: ListView(
              padding: const EdgeInsets.all(5),
              children: [
                if (packagesController.packages.isNotEmpty) ...[
                  for (var package in packagesController.packages.reversed)
                    PackageWidget(
                      name: package.name,
                      id: package.id,
                      description: package.description,
                      created: package.created,
                      delivered: package.delivered,
                      icon: const Icon(Icons.pending, color: DarkTheme.iconPrimary),
                    ),
                ] else ...[ const EmptyWidget() ],
              ],
            ),
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
