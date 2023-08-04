import 'package:flutter/material.dart';

import './screens/home_page.dart';

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
