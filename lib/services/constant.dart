import 'package:flutter/material.dart';

const mainURL = 'http://192.168.38.156:8080';
const baseURL = mainURL + '/api';
const loginURL = baseURL + '/login';
const registerURL = baseURL + '/register';
const logoutURL = baseURL + '/logout';
const userURL = baseURL + '/get_user';
const commentURL = baseURL + '/comments';
//sms
const sendSmsURL = baseURL + '/sms';
const checkSmsURL = baseURL + '/check';
const listPostURL = baseURL + '/list';
//images
const getImage = mainURL + '/images';

//Rent action
const startRent = baseURL + '/start';
const closeRent = baseURL + '/end';
const getHistoryURL = baseURL + '/get_history';

//Card
const addCard = baseURL + '/add_card';
const deleteCard = baseURL + '/delete_card';

//User
const editUser = baseURL + '/edit_user';
//Error
const serverError = 'Server error';
const unauthorized = 'Unauthorized';
const somethingWentWrong = 'Something went wrong, try again';

InputDecoration kInputDecoration(String label) {
  return InputDecoration(
      labelText: label,
      contentPadding: EdgeInsets.all(10),
      border: OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: Colors.black)));
}

TextButton ktextButton(String label, Function onPressed) {
  return TextButton(
    child: Text(label, style: TextStyle(color: Colors.white)),
    style: ButtonStyle(
        backgroundColor:
            MaterialStateColor.resolveWith((states) => Colors.blue),
        padding: MaterialStateProperty.resolveWith(
            (states) => EdgeInsets.symmetric(vertical: 10))),
    onPressed: () => onPressed(),
  );
}

Row kLoginRegisterHint(String text, String label, Function onTap) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(text),
      GestureDetector(
        child: Text(
          label,
          style: TextStyle(color: Colors.blue),
        ),
        onTap: () => onTap(),
      )
    ],
  );
}
