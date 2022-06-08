import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class InfoPage4 extends StatefulWidget {
  const InfoPage4({Key? key}) : super(key: key);

  @override
  State<InfoPage4> createState() => _InfoPage4State();
}

class _InfoPage4State extends State<InfoPage4> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            'Информация',
            style: TextStyle(color: Colors.blue),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  '1. Использование до 1 часа PowerBank будет с вас списаться 300 тг',
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ],
          ),
        ));
  }
}
