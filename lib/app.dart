import 'package:flutter/material.dart';

import './screens/home_page.dart';

class App extends StatelessWidget {
  const App({ super.key });

  @override
  Widget build(context) {
    return MaterialApp(
      title: 'My Pack',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
