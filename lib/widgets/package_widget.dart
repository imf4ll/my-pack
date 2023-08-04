import 'package:flutter/material.dart';

import '../themes/dark_theme.dart';

import '../screens/package_page.dart';

import '../controllers/packages_controller.dart';

class PackageWidget extends StatelessWidget {
  final String? name;
  final String? id;
  final String? description;
  final int? created;
  final bool? delivered;
  final Icon? icon;

  const PackageWidget({
    super.key,
    this.name,
    this.id,
    this.description,
    this.created,
    this.delivered,
    this.icon,
  });

  final String lastUpdate = 'há 3 horas';

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
        builder: (context) {
          return BottomSheet(
            onClosing: () => {},
            constraints: const BoxConstraints(maxHeight: 120),
            backgroundColor: Colors.transparent,
            builder: (context) {
              return Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () => print('edit'),
                    child: const Padding(
                      padding: EdgeInsets.all(12),
                      child: Row(
                        children: [
                          Icon(Icons.edit, size: 24, color: DarkTheme.iconPrimary),
                          SizedBox(width: 10),
                          Text('Edit', style: TextStyle(fontWeight: FontWeight.w500, color: DarkTheme.secondary, fontSize: 18)),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      packagesController.removePackage(id!);

                      Navigator.pop(context);
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

    String since(int timestamp) {
      double since = (DateTime.now().millisecondsSinceEpoch - timestamp) / 1000 / 60;

      switch (since) {
        case < 60:
          return 'Criado há ${ since.round() } minutos';

        default:
          return 'Criado há ${ (since / 24).round() } dias';
      }
    }

    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) =>
          PackagePage(
              name: name,
              id: id,
              created: since(created!),
            )
          )
        );
      },
      onLongPress: () => showPackageModal(),
      child: Card(
        color: const Color(0xFF222222),
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
              Text(
                'Objeto em trânsito, por favor aguarde',
                //description!,
                style: const TextStyle(
                  color: DarkTheme.primary,
                  fontSize: 15,
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: icon,
              ),
              const SizedBox(height: 15),
              Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  lastUpdate,
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
