import 'package:flutter/material.dart';

import '../themes/dark_theme.dart';

class PackageDetailsWidget extends StatelessWidget {
  final Icon? icon;
  final String? title;
  final String? description;
  final String? lastUpdate;

  const PackageDetailsWidget({
    super.key,
    this.icon,
    this.title,
    this.description,
    this.lastUpdate,
  });

  @override
  Widget build(context) {
    return Row(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: DarkTheme.iconBackground,
            borderRadius: BorderRadius.circular(10),
          ),
          child: icon,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('$title', style: const TextStyle(color: DarkTheme.primary, fontWeight: FontWeight.w600, fontSize: 13)),
              const SizedBox(height: 7),
              Text(
                '$description',
                style: const TextStyle(
                  color: DarkTheme.secondary,
                  fontWeight: FontWeight.w400,
                  fontSize: 11
                ),
                softWrap: true,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 7),
              Text('$lastUpdate', style: const TextStyle(color: DarkTheme.terciary, fontWeight: FontWeight.w400, fontSize: 11)),
            ],
          ),
        ),
      ],
    );
  }
}
