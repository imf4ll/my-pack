import 'package:flutter/material.dart';

import './screens/home_page.dart';

import './themes/dark_theme.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({ super.key });

  @override
  Widget build(context) {
    return MaterialApp(
      title: 'My Pack',
      theme: ThemeData(
        fontFamily: 'Poppins',
        scaffoldBackgroundColor: DarkTheme.background,
        appBarTheme: const AppBarTheme(
          backgroundColor: DarkTheme.foreground,
        ),
        drawerTheme: const DrawerThemeData(
          backgroundColor: DarkTheme.background,
        ),
        bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: DarkTheme.background,
          modalBackgroundColor: Colors.transparent,
        ),
      ),
      home: const HomePage(),
    );
  }
}
