import 'package:flutter/material.dart';
import 'package:mobileapp_diplom2022_1_0_0/screens/loading.dart';
import 'package:mobileapp_diplom2022_1_0_0/screens/login.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Login(),
    );
  }
}
