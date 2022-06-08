import 'package:flutter/material.dart';
import 'package:mobileapp_diplom2022_1_0_0/screens/home.dart';
import 'package:mobileapp_diplom2022_1_0_0/services/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class InfoPage3 extends StatefulWidget {
  const InfoPage3(
      {Key? key,
      required this.cardNumber,
      required this.cardHolderName,
      required this.expiryDate,
      required this.cvvCode})
      : super(key: key);
  final String cardNumber;
  final String cardHolderName;
  final String expiryDate;
  final String cvvCode;

  @override
  State<InfoPage3> createState() => _InfoPage3State();
}

class _InfoPage3State extends State<InfoPage3> {
  _addCard() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final response = await http.post(Uri.parse(addCard), headers: {
      'Accept': 'application/json'
    }, body: {
      'id_user': pref.getInt('userId').toString(),
      'number_card': widget.cardNumber,
      'name_user': widget.cardHolderName,
      'expiryDate': widget.expiryDate,
      'code_cvc': widget.cvvCode,
    });
    print('response ${response.body}');

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute<void>(builder: (BuildContext context) => Home()),
      ModalRoute.withName('/'),
    );
  }

  @override
  void initState() {
    super.initState();
  }

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
            "Отлично!!!",
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
            "Ваша карта привязано",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.white,
                decoration: TextDecoration.none),
          ),
          SizedBox(
            height: 200,
          ),
          ElevatedButton(
            onPressed: () {
              _addCard();
            },
            child: Text(
              "Принято",
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
