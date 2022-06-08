import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobileapp_diplom2022_1_0_0/screens/info_page1.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/api_response.dart';
import '../services/constant.dart';
import '../services/post_service.dart';
import 'home.dart';
import 'info_page2.dart';

class AboutPostPage extends StatefulWidget {
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
  @override
  State<AboutPostPage> createState() => _AboutPostPageState();
}

class _AboutPostPageState extends State<AboutPostPage> {
  bool checkActive = false;
  bool isCard = false;

  _checkCard() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    final response = await http.post(Uri.parse(userURL), headers: {
      'Accept': 'application/json'
    }, body: {
      'id_user': pref.getInt('userId').toString(),
    });
    if (jsonDecode(response.body)['card'] == 'true') {
      setState(() {
        isCard = false;
      });
    } else {
      setState(() {
        isCard = true;
      });
    }
  }

  _checkActive() async {
    print(checkActive);
    ApiResponse response = await getHistory();
    if (response.data == null) {
      setState(() {
        checkActive = true;
      });
      print(checkActive);
    } else {
      List listHis = response.data as List;
      print("=======================History========================");
      print(listHis[0].toString());
      if (listHis[0]['is_active'].toString() == 'true') {
        setState(() {
          checkActive = true;
        });
      }
      print(checkActive);
    }
    print(checkActive);
  }

  _startRent(context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    print('${widget.id}');
    final response = await http.post(Uri.parse(startRent), headers: {
      'Accept': 'application/json'
    }, body: {
      'id_user': pref.getInt('userId').toString(),
      'id_post_first': widget.id.toString(),
    });
    var checkStart = jsonDecode(response.body)['message'].toString();
    print(checkStart);
    if (checkStart == 'true') {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => InfoPage()));
    } else {
      print("==================== error about page =========================");
    }
  }

  _closeRent(context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    print('${widget.id}');
    final response = await http.post(Uri.parse(closeRent), headers: {
      'Accept': 'application/json'
    }, body: {
      'id_user': pref.getInt('userId').toString(),
      'id_post_first': widget.id.toString(),
    });
    var checkStart = jsonDecode(response.body)['message'].toString();
    print('======================= ${checkStart}');
    if (checkStart == 'true') {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => InfoPage2()));
    } else {
      print("==================== error about page =========================");
    }
  }

  @override
  void initState() {
    _checkActive();
    _checkCard();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _willPop(context),
      child: Scaffold(
          appBar: AppBar(
            title: Text('Postomat: ${widget.qr_code}'),
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
                      Text('Доступно: ${widget.slot - widget.freeslot}',
                          style: TextStyle(fontSize: 18, color: Colors.green)),
                      Text('Свободные слоты: ${widget.freeslot}',
                          style: TextStyle(fontSize: 18))
                    ],
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        checkActive
                            ? ElevatedButton(
                                onPressed: () {
                                  if (isCard) {
                                    _startRent(context);
                                  } else {
                                    showAlertDialog(context);
                                  }
                                },
                                child: Text('Арендовать'))
                            : ElevatedButton(
                                onPressed: () {
                                  _closeRent(context);
                                },
                                child: Text('Вернуть')),
                      ])
                ],
              ))),
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Внимание"),
      content: Text("Добавьте банковскую карту"),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
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
