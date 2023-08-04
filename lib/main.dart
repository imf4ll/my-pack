import 'package:flutter/material.dart';

import './screens/home_page.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({ super.key });

  @override
  Widget build(context) {
    return MaterialApp(
      title: 'My Pack',
      theme: ThemeData(
        fontFamily: 'Poppins',
      ),
      home: const HomePage(),
    );
  }
}
