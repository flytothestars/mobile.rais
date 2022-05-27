import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/api_response.dart';
import '../screens/register.dart';
import '../services/constant.dart';
import '../services/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';
import 'home.dart';

class LogReg extends StatefulWidget {
  @override
  _LogRegState createState() => _LogRegState();
}

class _LogRegState extends State<LogReg> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController txtNumber = TextEditingController();
  TextEditingController txtCode = TextEditingController();
  bool smsModel = false;
  bool sended = false;
  var code;

  void _loginUser() async {
    print('======================');
    final response = await http.post(Uri.parse(sendSmsURL), headers: {
      'Accept': 'application/json'
    }, body: {
      'number': txtNumber.text,
    });
    print('====================');
    print(jsonDecode(response.body));
    setState(() {
      code = jsonDecode(response.body)['code'];
    });
  }

  void _confirmCode() async {
    print(code);
    if (txtCode.text == code.toString()) {
      ApiResponse response =
          await checkSms(txtNumber.text, code.toString(), txtCode.text);
      if (response.error == null) {
        _saveAndRedirectTohome(response.data as User);
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('${response.error}')));
      }
    } else {}
  }

  void _saveAndRedirectTohome(User user) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('token', user.token ?? '');
    await pref.setInt('userId', user.id ?? 0);
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => Home()), (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RaiS'),
        centerTitle: true,
      ),
      body: Form(
        key: formKey,
        child: ListView(
          padding: EdgeInsets.all(32),
          children: [
            Text(
              'Номер телефона',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'На него придет код подтверждения',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 17),
            ),
            SizedBox(
              height: 50,
            ),
            TextFormField(
                keyboardType: TextInputType.phone,
                controller: txtNumber,
                validator: (val) =>
                    val!.isEmpty ? 'Invalid number phone' : null,
                decoration: kInputDecoration('777-777-77-77')),
            SizedBox(
              height: 10,
            ),
            AnimatedOpacity(
                // If the widget is visible, animate to 0.0 (invisible).
                // If the widget is hidden, animate to 1.0 (fully visible).
                opacity: smsModel ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 500),
                // The green box must be a child of the AnimatedOpacity widget.
                child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: txtCode,
                    validator: (val) => val!.isEmpty ? 'Invalid code' : null,
                    decoration: kInputDecoration('000-000'))),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (!smsModel) {
            setState(() {
              _loginUser();
              smsModel = true;
            });
          } else {
            setState(() {
              _confirmCode();
            });
          }
        },
        label: smsModel ? Text('Войти') : Text('Отправить код'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
