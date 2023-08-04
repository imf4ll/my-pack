import 'package:flutter/material.dart';

import '../themes/dark_theme.dart';

import '../controllers/packages_controller.dart';

import '../widgets/packagedetails_widget.dart';

class PackagePage extends StatefulWidget {
  final String? name;
  final String? id;
  final String? created;

  const PackagePage({
    super.key,
    this.name,
    this.id,
    this.created,
  });

  @override
  State createState() => _PackagePageState();
}

class _PackagePageState extends State<PackagePage> {
  @override
  Widget build(context) {
    var packagesController = PackagesController.instance;
    
    return Scaffold(
      backgroundColor: DarkTheme.background,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(200),
        child: AppBar(
          title: Text('${ widget.name }') ,
          backgroundColor: DarkTheme.foreground,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          titleSpacing: 0,
          actions: [
            GestureDetector(
              onTap: () => print('edit'),
              child: const Padding(
                padding: EdgeInsets.all(5),
                child: Icon(Icons.edit, size: 24),
              ),
            ),
            GestureDetector(
              onTap: () => print('refresh'),
              child: const Padding(
                padding: EdgeInsets.all(5),
                child: Icon(Icons.refresh, size: 24),
              ),
            ),
            GestureDetector(
              onTap: () {
                packagesController.removePackage(widget.id!);

                Navigator.pop(context);
              },
              child: const Padding(
                padding: EdgeInsets.all(5),
                child: Icon(Icons.delete, size: 24),
              ),
            ),
            const SizedBox(width: 10),
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(0),
            child: Column(
              children: [
                const Icon(Icons.inventory_2, size: 48, color: DarkTheme.primary),
                const SizedBox(height: 10),
                Text('${ widget.id }', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: DarkTheme.primary)),
                const SizedBox(height: 10),
                Text('${ widget.created }', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: DarkTheme.primary)),
                const SizedBox(height: 15),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
            children: const [
            //for (var detail in details)
            PackageDetailsWidget(
              icon: Icon(Icons.local_shipping_rounded, size: 36, color: DarkTheme.iconPending),
              title: 'Objeto em trânsito - por favor aguarde',
              description: 'de Unidade de Logística Integrada, CURITIBA - PR para Unidade de Tratamento, INDAIATUBA - SP',
              lastUpdate: 'há 3 horas',
            ),
            SizedBox(height: 10),
            SizedBox(
              height: 30,
              child: VerticalDivider(
                thickness: 1.5,
                color: DarkTheme.iconPending,
              ),
            ),
            SizedBox(height: 10),
            PackageDetailsWidget(
              icon: Icon(Icons.local_shipping_rounded, size: 36, color: DarkTheme.iconPending),
              title: 'Objeto em trânsito - por favor aguarde',
              description: 'de Unidade de Logística Integrada, CURITIBA - PR para Unidade de Tratamento, INDAIATUBA - SP',
              lastUpdate: 'há 3 horas',
            ),
          ],
        ),
      ),
    );
  }
}
