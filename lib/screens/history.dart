import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobileapp_diplom2022_1_0_0/models/api_response.dart';
import 'package:mobileapp_diplom2022_1_0_0/services/post_service.dart';
import 'package:mobileapp_diplom2022_1_0_0/services/user_service.dart';
import '../models/post.dart';
import 'package:http/http.dart' as http;

import '../services/constant.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'История',
          style: TextStyle(color: Colors.blue),
        ),
      ),
      body: Container(
        child: Center(),
      ),
    );
  }
}
