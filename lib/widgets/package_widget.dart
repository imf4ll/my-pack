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

  const PackageWidget({
    super.key,
    this.name,
    this.id,
    this.description,
    this.delivered,
    this.lastUpdate,
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
        backgroundColor: DarkTheme.background,
        isScrollControlled: true,
        builder: (context) {
          return BottomSheet(
            onClosing: () => {},
            constraints: const BoxConstraints(maxHeight: 60),
            backgroundColor: Colors.transparent,
            builder: (context) {
              return Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const SizedBox(height: 5),
                  GestureDetector(
                    onTap: () {
                      packagesController.removePackage(id!);

                      Navigator.pop(context);

                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Successfully removed.')));
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(12),
                      child: Row(
                        children: [
                          Icon(Icons.delete_rounded, size: 24, color: DarkTheme.buttonRed),
                          SizedBox(width: 10),
                          Text('Delete', style: TextStyle(fontWeight: FontWeight.w500, color: DarkTheme.buttonRed, fontSize: 18)),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        }
      );
    }

    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) =>
          PackagePage(name: name, id: id)),
        );
      },
      onLongPress: () => showPackageModal(),
      child: Card(
        color: DarkTheme.cardBackground,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$name · $id',
                style: const TextStyle(
                  color: DarkTheme.terciary,
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    flex: 20,
                    child: Text(
                      description!,
                      style: const TextStyle(
                        color: DarkTheme.primary,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 2,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const Spacer(),
                  delivered! ? const Icon(Icons.check_circle, color: DarkTheme.iconPrimary) : const Icon(Icons.pending, color: DarkTheme.iconPrimary),
                ],
              ),
              const SizedBox(height: 15),
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
        ),
      ),
    );
  }
}
