import 'package:flutter/material.dart';

import '../themes/dark_theme.dart';

import '../controllers/packages_controller.dart';

import '../services/fetch_service.dart';

import '../widgets/packagedetails_widget.dart';
import '../widgets/separator_widget.dart';

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
  var packagesController = PackagesController.instance;
  
  Map<String, dynamic>? package;
  bool isLoading = true;
  bool isDelivered = false;

  void fetchPackage() => getPackage(widget.id!).then((r) => setState(() {
      package = r;

      if (r['latestTrace']['desc'] == 'Delivered') {
        isDelivered = true;

        packagesController.updateDelivered(widget.id!);
      }

      packagesController.updateDate(widget.id!, r['latestTrace']['time']);

      packagesController.updateDescription(widget.id!, r['latestTrace']['standerdDesc']);

      isLoading = false;

  })).onError((error, stackTrace) {
    Navigator.pop(context);
  
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Failed to get data, try again later.'),
    ));
  });

  @override
  void initState() {
    fetchPackage();
 
    super.initState();
  }

  IconData setIcon(String actionCode) {
    switch (actionCode) {
      case 'CC_EX_START' || 'CC_EX_SUCCESS' || 'CC_IM_SUCCESS':
        return Icons.anchor;

      case 'LH_HO_AIRLINE' || 'LH_DEPART':
        return Icons.flight_takeoff_rounded;

      case 'LH_ARRIVE' || 'GTMS_ACCEPT':
        return Icons.flight_land_rounded;

      case 'GTMS_SIGNED':
        return Icons.check_circle_rounded;

      default:
        return Icons.local_shipping_rounded;
    }
  }
  
  @override
  Widget build(context) {
    
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
              onTap: () {
                packagesController.removePackage(widget.id!);

                Navigator.pop(context);
                
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Successfully removed.')));
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
                Icon(isDelivered ? Icons.check_circle_rounded : Icons.inventory_2, size: 48, color: DarkTheme.primary),
                const SizedBox(height: 10),
                Text('${ widget.id }', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: DarkTheme.primary)),
                const SizedBox(height: 10),
                if (!isLoading) ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(package!['originCountry'], style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: DarkTheme.primary)),
                      const Icon(Icons.navigate_next_rounded, color: DarkTheme.iconPrimary),
                      Text(package!['destCountry'], style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: DarkTheme.primary)),
                    ],
                  ),
                ] else ...[ const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(color: DarkTheme.primary, strokeWidth: 3)),
                ],
                const SizedBox(height: 15),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 7, right: 7, top: 10),
        child: RefreshIndicator(
          onRefresh: () => Future<void>.microtask(() => fetchPackage()),
          backgroundColor: DarkTheme.cardBackground,
          color: DarkTheme.primary,
          child: ListView(
            children: [
              if (!isLoading) ...[
                for (var detail in package!['detailList']) ...[
                  PackageDetailsWidget(
                    icon: setIcon(detail['actionCode']),
                    title: detail['descTitle'],
                    description: detail['standerdDesc'],
                    lastUpdate: detail['time'],
                  ),
                  const SeparatorWidget(),  
                ],
              ] else ...[
                const SizedBox(height: 10),
                const Center(child: CircularProgressIndicator(color: DarkTheme.foreground)),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
