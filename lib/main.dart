import 'package:flutter/material.dart';

import './screens/home_page.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({ super.key });

  @override
  Widget build(context) {
    return const MaterialApp(
      title: 'My Pack',
      home: HomePage(),
    );
  }
}
