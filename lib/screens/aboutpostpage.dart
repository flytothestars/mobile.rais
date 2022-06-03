import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobileapp_diplom2022_1_0_0/screens/info_page1.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/constant.dart';
import 'home.dart';

class AboutPostPage extends StatelessWidget {
  AboutPostPage(
      {Key? key,
      required this.qr_code,
      required this.id,
      required this.address,
      required this.slot,
      required this.freeslot})
      : super(key: key);
  final int id;
  final String address;
  final String qr_code;
  final int slot;
  final int freeslot;

  _startRent(context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    print('${id}');
    final response = await http.post(Uri.parse(startRent), headers: {
      'Accept': 'application/json'
    }, body: {
      'id_user': pref.getInt('userId').toString(),
      'id_post_first': id.toString(),
    });
    var checkStart = jsonDecode(response.body)['message'].toString();
    print(checkStart);
    if (checkStart == 'true') {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => InfoPage()));
    } else {
      print("==================== eror aboput page =========================");
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _willPop(context),
      child: Scaffold(
          appBar: AppBar(
            title: Text('Postomat: ${qr_code}'),
          ),
          body: Container(
              padding: const EdgeInsets.only(
                  top: 20, left: 10, right: 10, bottom: 30),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.all(0),
                        child: Image(
                            width: 380,
                            image: NetworkImage('${getImage}/postomat.png')),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        '',
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text('Доступно: ${slot - freeslot}',
                          style: TextStyle(fontSize: 18, color: Colors.green)),
                      Text('Свободные слоты: ${freeslot}',
                          style: TextStyle(fontSize: 18))
                    ],
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              _startRent(context);
                            },
                            child: Text('Арендовать')),
                        ElevatedButton(
                            onPressed: () {}, child: Text('Вернуть')),
                      ])
                ],
              ))),
    );
  }

  Future<bool> _willPop(BuildContext context) {
    final completer = Completer<bool>();
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => Home()), (route) => false);
    completer.complete(true);
    return completer.future;
  }
}
