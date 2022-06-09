import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobileapp_diplom2022_1_0_0/screens/chat.dart';
import 'package:mobileapp_diplom2022_1_0_0/screens/history.dart';
import 'package:mobileapp_diplom2022_1_0_0/screens/logreg.dart';
import 'package:mobileapp_diplom2022_1_0_0/screens/setting.dart';
import 'package:mobileapp_diplom2022_1_0_0/screens/widgets/widgetButton.dart';
import 'package:mobileapp_diplom2022_1_0_0/services/user_service.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../services/constant.dart';
import 'info_page4.dart';
import 'profile_info.dart';

class Profile extends StatefulWidget {
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String timeNow = "";
  late Timer _timer;
  var dateStart;
  bool checkTimeRent = false;
  String userNumber = "";
  _getUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    final response = await http.post(Uri.parse(userURL), headers: {
      'Accept': 'application/json'
    }, body: {
      'id_user': pref.getInt('userId').toString(),
    });
    setState(() {
      userNumber = jsonDecode(response.body)['user']['email'].toString();
    });
  }

  _getDifferentTime() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    final response = await http.post(Uri.parse(getHistoryURL), headers: {
      'Accept': 'application/json'
    }, body: {
      'id_user': pref.getInt('userId').toString(),
    });
    print("Profile");
    print(jsonDecode(response.body)['history']['time_start']);
    setState(() {
      checkTimeRent = true;
      dateStart =
          DateTime.parse(jsonDecode(response.body)['history']['time_start']);
    });
  }

  @override
  void initState() {
    super.initState();
    _getUser();
    _getDifferentTime();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (this.mounted) {
        setState(() {
          timeNow = "${DateTime.now().difference(dateStart)}";
          // Your state change code goes here
        });
      }
    });
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.white,
            title: Center(
              child: Text(
                "Личный кабинет",
                style: TextStyle(color: Colors.blue),
              ),
            )),
        backgroundColor: Colors.grey[200],
        body: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            //ProfilePicture
            // SizedBox(
            //     height: 115,
            //     width: 115,
            //     child: Stack(
            //       fit: StackFit.expand,
            //       children: [Text(' ${timeNow}')],
            //     )),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              //child: Container(
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20), // if you need this
                  side: BorderSide(
                    color: Colors.grey.withOpacity(0.1),
                    width: 1,
                  ),
                ),
                elevation: 5,
                child: Column(
                  children: [
                    ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfileInfo()));
                      },
                      leading: Icon(
                        FontAwesomeIcons.user,
                        color: Colors.blue,
                      ),
                      title: Text('${userNumber}'),
                      subtitle: Text(
                        'Профиль',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            checkTimeRent
                ? Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(20), // if you need this
                        side: BorderSide(
                          color: Colors.grey.withOpacity(0.1),
                          width: 1,
                        ),
                      ),
                      elevation: 5,
                      child: Column(
                        children: [
                          ListTile(
                            leading: Icon(
                              FontAwesomeIcons.timeline,
                              color: Colors.blue,
                            ),
                            title: Text("Время аренды"),
                            subtitle: Text(
                              ' ${timeNow}',
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : SizedBox(
                    height: 20,
                  ),
            // Button
            ProfileMenu(
                icon: FontAwesomeIcons.bell,
                text: 'История поездок',
                press: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HistoryPage()));
                }),
            ProfileMenu(
                icon: FontAwesomeIcons.gears,
                text: 'Настройки',
                press: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SettingPage()));
                }),
            ProfileMenu(
                icon: FontAwesomeIcons.personCircleCheck,
                text: 'Тарифы',
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const InfoPage4()),
                  );
                }),
            ProfileMenu(
                icon: FontAwesomeIcons.personCircleCheck,
                text: 'Служба поддержка',
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ChatPage()),
                  );
                }),
            ProfileMenu(
                icon: FontAwesomeIcons.arrowRight,
                text: 'Выйти',
                press: () {
                  logout();
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => LogReg()),
                      (route) => false);
                }),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 100,
                  height: 40,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                            "https://www.flytothestar.ru/images/RAIS_free-file.png")),
                  ),
                ),
                Text(
                  'by Ramazan and Islambek',
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ],
            )
          ],
        ));
  }
}
