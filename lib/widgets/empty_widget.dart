import 'package:flutter/material.dart';

import '../themes/dark_theme.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({ super.key });

  @override
  Widget build(context) {
    return Center(
      heightFactor: 2.5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/empty_box.png', scale: 3),
          const SizedBox(height: 25),
          const Text(
            'Oh, there\'s an empty_box!',
            style: TextStyle(
              color: DarkTheme.primary,
              fontSize: 20,
              fontWeight: FontWeight.w600
            )
          ),
        ],
      ),
    );
  }
}
