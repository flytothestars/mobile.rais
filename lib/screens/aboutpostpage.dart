import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'home.dart';

class AboutPostPage extends StatefulWidget {
  const AboutPostPage({Key? key}) : super(key: key);

  @override
  State<AboutPostPage> createState() => _AboutPostPageState();
}

class _AboutPostPageState extends State<AboutPostPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _willPop(context),
      child: Scaffold(
        body: Center(
          child: Text('Info post'),
        ),
      ),
    );
  }

  Future<bool> _willPop(BuildContext context) {
    final completer = Completer<bool>();
    Navigator.of(this.context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => Home()), (route) => false);
    completer.complete(true);
    return completer.future;
  }
}
