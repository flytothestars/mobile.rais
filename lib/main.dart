import 'package:flutter/material.dart';
import 'package:mobileapp_diplom2022_1_0_0/screens/splash.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  final ThemeData theme = ThemeData(primaryColor: Colors.yellow);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: this.theme,
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
