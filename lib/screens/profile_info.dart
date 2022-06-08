import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobileapp_diplom2022_1_0_0/services/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'card_page.dart';

class ProfileInfo extends StatefulWidget {
  const ProfileInfo({Key? key}) : super(key: key);

  @override
  State<ProfileInfo> createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> {
  String userNumber = "";
  String cardNumber = "";
  String userName = "";
  bool editor = false;
  TextEditingController name = TextEditingController();

  _getUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    final response = await http.post(Uri.parse(userURL), headers: {
      'Accept': 'application/json'
    }, body: {
      'id_user': pref.getInt('userId').toString(),
    });
    setState(() {
      userName = jsonDecode(response.body)['user']['name'].toString();
      userNumber = jsonDecode(response.body)['user']['email'].toString();
    });
    if (jsonDecode(response.body)['card'] == 'true') {
      setState(() {
        cardNumber = "";
      });
    } else {
      setState(() {
        cardNumber =
            jsonDecode(response.body)['card']['number_card'].toString();
      });
    }
    // print('================ Info');
    print('info ${userNumber}');
    print('info ${cardNumber}');
    print('info ${userName}');
  }

  _deleteCard() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    final response = await http.post(Uri.parse(deleteCard), headers: {
      'Accept': 'application/json'
    }, body: {
      'id_user': pref.getInt('userId').toString(),
    });
    setState(() {
      cardNumber = "";
    });
  }

  _addName() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    final response = await http.post(Uri.parse(editUser), headers: {
      'Accept': 'application/json'
    }, body: {
      'id_user': pref.getInt('userId').toString(),
      'name': name.text,
    });

    print('info ${name.text}');
    setState(() {
      userName = name.text;
    });
  }

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
          backgroundColor: Colors.white,
          title: Center(
            child: Text(
              "Профиль",
              style: TextStyle(color: Colors.blue),
            ),
          )),
      body: Container(
        child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Card(
                  child: Column(
                    children: [
                      ListTile(
                        title: Text('Ваш номер'),
                        subtitle: Text('${userNumber}'),
                      )
                    ],
                  ),
                ),
                Card(
                  child: Column(
                    children: [
                      ListTile(
                          onTap: () {
                            setState(() {
                              editor = true;
                            });
                          },
                          title: Text('Имя'),
                          subtitle: editor
                              ? TextFormField(
                                  keyboardType: TextInputType.name,
                                  controller: name,
                                  decoration: const InputDecoration(
                                    border: UnderlineInputBorder(),
                                    labelText: 'Введите свое имя',
                                  ),
                                )
                              : (Text(userName == 'null'
                                  ? 'Как Вас зовут?'
                                  : '${userName}'))),
                      editor
                          ? ElevatedButton(
                              style: ButtonStyle(
                                minimumSize: MaterialStateProperty.all<Size>(
                                    Size(200, 40)),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        side: BorderSide(color: Colors.white))),
                              ),
                              onPressed: () {
                                setState(() {
                                  editor = false;
                                  _addName();
                                });
                              },
                              child: Text('Сохранить'),
                            )
                          : SizedBox(
                              height: 1,
                            )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  height: 1,
                  color: Colors.black,
                ),
                SizedBox(
                  height: 10,
                ),
                Card(
                  child: Column(
                    children: [
                      ListTile(
                        title: Text('Банковская карта'),
                        subtitle: Text(cardNumber.isEmpty
                            ? 'Не привязан карта'
                            : '**** **** **** ${cardNumber.substring(15, 19)}'),
                      ),
                      cardNumber.isEmpty
                          ? ElevatedButton(
                              style: ButtonStyle(
                                minimumSize: MaterialStateProperty.all<Size>(
                                    Size(200, 40)),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        side: BorderSide(color: Colors.white))),
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MyCard()));
                              },
                              child: Text('Добавить карту'),
                            )
                          : ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.red),
                                minimumSize: MaterialStateProperty.all<Size>(
                                    Size(200, 40)),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        side: BorderSide(color: Colors.white))),
                              ),
                              onPressed: () {
                                _deleteCard();
                              },
                              child: Text('Удалить карту'),
                            )
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
