import 'dart:async';
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
  List list = [];
  var dateNow;
  var dateStart;
  late Timer _timer;

  _getHistory() async {
    ApiResponse response = await getHistoryProfile();
    print('info ===============');
    setState(() {
      list = response.data as List;
    });
    for (int i = 0; i < list.length; i++) {
      if (list[i]['time_end'].toString() == 'null') {
        setState(() {
          dateStart = DateTime.parse(list[i]['time_start']);
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _getHistory();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (this.mounted) {
        setState(() {
          dateNow = "${DateTime.now().difference(dateStart)}";
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
        title: Text(
          'История',
          style: TextStyle(color: Colors.blue),
        ),
      ),
      backgroundColor: Colors.grey[200],
      body: Container(

          //child: Text('History'),
          child: ListView.builder(
        padding: EdgeInsets.all(6),
        itemCount: list.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
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
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Text('Чек ${list[index]['id']}'),
                ),
                ListTile(
                    title: Text('Дата начала'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            '${DateTime.parse(list[index]['time_start']).year} - ${DateTime.parse(list[index]['time_start']).month} - ${DateTime.parse(list[index]['time_start']).day}'),
                        Text(
                            '${DateTime.parse(list[index]['time_start']).hour}:${DateTime.parse(list[index]['time_start']).minute}:${DateTime.parse(list[index]['time_start']).second}'),
                      ],
                    )),
                ListTile(
                    title: Text(list[index]['time_end'].toString() != 'null'
                        ? 'Дата окончание'
                        : 'Аренда действует'),
                    subtitle: list[index]['time_end'].toString() != 'null'
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  '${DateTime.parse(list[index]['time_end']).year} - ${DateTime.parse(list[index]['time_end']).month} - ${DateTime.parse(list[index]['time_end']).day}'),
                              Text(
                                  '${DateTime.parse(list[index]['time_end']).hour}:${DateTime.parse(list[index]['time_end']).minute}:${DateTime.parse(list[index]['time_end']).second}'),
                            ],
                          )
                        : Text('${dateNow}')),
                Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Text('сумма ${list[index]['money']}'),
                ),
              ],
            ),
          );
        },
      )),
    );
  }
}
