import 'package:flutter/material.dart';

import '../themes/dark_theme.dart';

class SeparatorWidget extends StatelessWidget {
  const SeparatorWidget({ super.key });
  
  @override
  Widget build(context) {
    return const Padding(
      padding: EdgeInsets.only(left: 30),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          children: [
            SizedBox(height: 5),
            SizedBox(
              height: 25,
              child: VerticalDivider(
                thickness: 2,
                color: DarkTheme.iconPending,
              ),
            ),
            SizedBox(height: 5),
          ],
        ),
      ),
    );
  }
}
