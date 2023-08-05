import 'package:flutter/material.dart';

import '../themes/dark_theme.dart';

class EmptyWidget extends StatefulWidget {
  const EmptyWidget({ super.key });

  @override
  State createState() => _EmptyWidgetState();
}

class _EmptyWidgetState extends State<EmptyWidget> {
  double margin = 0;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() => margin = 100);

    }); 
  }

  @override
  Widget build(context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 800),
      margin: EdgeInsets.only(top: margin),
      curve: Curves.easeInOut,
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
