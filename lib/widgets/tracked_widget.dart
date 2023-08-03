import 'package:flutter/material.dart';

import '../controllers/homepage_controller.dart';

class TrackedWidget extends StatelessWidget {
  final String? id;
  final int? index;
  final String? description;
  final String? date;

  const TrackedWidget({ super.key, this.id, this.index, this.description, this.date });

  @override
  Widget build(context) {
    var controller = HomePageController.instance;

    return GestureDetector(
      onTap: () => {},
      onLongPress: () => controller.removePackage(index!),
      child: Card(
        color: const Color(0xFF222222),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                id!,
                style: const TextStyle(
                  color: Colors.white70,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                description!,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 15),
              Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  date!,
                  style: const TextStyle(
                    color: Color(0xFFAAAAAA),
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
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
