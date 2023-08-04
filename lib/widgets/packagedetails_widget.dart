import 'package:flutter/material.dart';

import '../themes/dark_theme.dart';

class PackageDetailsWidget extends StatelessWidget {
  final String? title;
  final String? description;
  final int? lastUpdate;
  final IconData? icon;

  const PackageDetailsWidget({
    super.key,
    this.title,
    this.description,
    this.lastUpdate,
    this.icon,
  });

  String since(int timestamp) {
    int difference = DateTime.now().difference(DateTime.fromMillisecondsSinceEpoch(timestamp)).inMinutes;

    switch (difference) {
      case > 60 * 24: return '${ (difference / 24 / 60).round() } days ago';

      case > 60: return '${ (difference / 60).round() } hours ago';
      
      default: return '$difference minutes ago';
    }
  }

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
          child: Icon(icon!, color: DarkTheme.iconPending),
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
                  fontSize: 12
                ),
                softWrap: true,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 7),
              Text(since(lastUpdate!), style: const TextStyle(color: DarkTheme.terciary, fontWeight: FontWeight.w500, fontSize: 12)),
            ],
          ),
        ),
      ],
    );
  }
}
