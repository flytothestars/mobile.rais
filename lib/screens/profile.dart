import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobileapp_diplom2022_1_0_0/screens/widgets/widgetButton.dart';

class Profile extends StatefulWidget {
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        body: Column(
          children: [
            SizedBox(
              height: 70,
            ),
            //ProfilePicture
            SizedBox(
                height: 115,
                width: 115,
                child: Stack(
                  fit: StackFit.expand,
                  overflow: Overflow.visible,
                  children: [
                    CircleAvatar(
                        backgroundImage: NetworkImage(
                            'https://www.ixbt.com/img/x780/n1/news/2022/2/1/elon-musk_large.jpg')),
                    Positioned(
                        right: -12,
                        bottom: 0,
                        child: SizedBox(
                          height: 40,
                          width: 40,
                          child: FlatButton(
                              padding: EdgeInsets.zero,
                              shape: RoundedRectangleBorder(
                                  side: BorderSide(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(50)),
                              color: Colors.white,
                              onPressed: () {},
                              child: Container(
                                  width: 20,
                                  height: 20,
                                  child: new Image.asset(
                                      'assets/camera_48px.png'))),
                        ))
                  ],
                )),
            SizedBox(
              height: 20,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Spacer(),
                SizedBox(
                  child: TextButton(
                    onPressed: () {},
                    child: new Image.asset('assets/star_160px.png'),
                    style: TextButton.styleFrom(
                      primary: Colors.grey[850],
                      padding: EdgeInsets.all(20),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      backgroundColor: Colors.white,
                    ),
                  ),
                  height: 100,
                  width: 100,
                ),
                Spacer(),
                SizedBox(
                  child: TextButton(
                    onPressed: () {},
                    child: Text("Бонус"),
                    style: TextButton.styleFrom(
                      primary: Colors.grey[850],
                      padding: EdgeInsets.all(20),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      backgroundColor: Colors.white,
                    ),
                  ),
                  height: 100,
                  width: 200,
                ),
                Spacer(),
              ],
            ),
            // Button
            ProfileMenu(
                icon: FontAwesomeIcons.person, text: 'Профиль', press: () {}),
            ProfileMenu(
                icon: FontAwesomeIcons.bell, text: 'Уведомление', press: () {}),
            ProfileMenu(
                icon: FontAwesomeIcons.gears, text: 'Настройки', press: () {}),
            ProfileMenu(
                icon: FontAwesomeIcons.personCircleCheck,
                text: 'Служба поддержка',
                press: () {}),
            ProfileMenu(
                icon: FontAwesomeIcons.arrowRight, text: 'Выйти', press: () {}),
          ],
        ));
  }
}
