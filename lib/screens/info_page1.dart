import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:mobileapp_diplom2022_1_0_0/screens/home.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({Key? key}) : super(key: key);

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.blueAccent),
      child: Column(
        children: [
          SizedBox(
            height: 100,
          ),
          Text(
            "Круто!!!",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 40,
                color: Colors.white,
                decoration: TextDecoration.none),
          ),
          SizedBox(
            height: 100,
          ),
          Text(
            "Вы арендовали PowerBank, ползуйтесь на здоровье",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.white,
                decoration: TextDecoration.none),
          ),
          SizedBox(
            height: 100,
          ),
          Text(
            "Прочитайте инструкцию",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Colors.white,
                decoration: TextDecoration.none),
          ),
          SizedBox(
            height: 200,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute<void>(
                    builder: (BuildContext context) => Home()),
                ModalRoute.withName('/'),
              );
            },
            child: Text(
              "Принято!!!",
              style: TextStyle(color: Colors.blue, fontSize: 30),
            ),
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                      side: BorderSide(color: Colors.white))),
              padding:
                  MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(15)),
              backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
