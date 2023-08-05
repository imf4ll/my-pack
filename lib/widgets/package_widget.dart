import 'package:flutter/material.dart';

import '../themes/dark_theme.dart';

import '../screens/package_page.dart';

import '../controllers/packages_controller.dart';

class PackageWidget extends StatelessWidget {
  final String? name;
  final String? id;
  final String? description;
  final String? lastUpdate;
  final bool? delivered;
  final int? created;

  const PackageWidget({
    super.key,
    this.name,
    this.id,
    this.description,
    this.delivered,
    this.lastUpdate,
    this.created,
  });

  @override
  Widget build(context) {
    var packagesController = PackagesController.instance;

    void showPackageModal() {
      showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
        ),
        isScrollControlled: true,
        builder: (context) {
          return BottomSheet(
            onClosing: () => {},
            constraints: const BoxConstraints(maxHeight: 50),
            builder: (context) {
              return ListView(
                physics: const ScrollPhysics(),
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      packagesController.removePackage(id!);

                      Navigator.pop(context);

                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Successfully removed.')));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.all(10),
                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                    ),
                    icon: const Icon(Icons.delete_rounded, size: 24, color: DarkTheme.buttonRed),
                    label: const Text('Delete', style: TextStyle(fontWeight: FontWeight.w500, color: DarkTheme.buttonRed, fontSize: 16)),
                  ),
                ],
              );
            },
          );
        }
      );
    }

    return ElevatedButton(
      onPressed: () => {
        Navigator.push(context, MaterialPageRoute(builder: (context) =>
          PackagePage(name: name, id: id, created: created)),
        )
      },
      onLongPress: () => showPackageModal(),
      style: ElevatedButton.styleFrom(
        backgroundColor: DarkTheme.cardBackground,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
        padding: const EdgeInsets.only(top: 10, bottom: 10, left: 12.5, right: 12.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(delivered! ? Icons.check_circle : Icons.pending, color: DarkTheme.iconPrimary, size: 20),
              const SizedBox(width: 7),
              Text(
                '$name · $id',
                style: const TextStyle(
                  color: DarkTheme.secondary,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
            ]
          ),
          const SizedBox(height: 15),
          Text(
            description!,
            style: const TextStyle(
              color: DarkTheme.primary,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            maxLines: 2,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.bottomRight,
            child: Text(
              lastUpdate!,
              style: const TextStyle(
                color: DarkTheme.terciary,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
