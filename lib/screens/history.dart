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

  List<dynamic> _postList = [];
  int userId = 0;
  bool _loading = true;

  

  Future<void> retrievePosts() async {
      ApiResponse response = await getPost();
      print(response.data);
      setState(() {
        _loading = _loading ? !_loading : _loading;
      });
    
  }

  @override
  void initState() {
    retrievePosts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _loading ? Center(child: CircularProgressIndicator()) : 
      ListView.builder(itemCount: _postList.length, itemBuilder: (BuildContext context, int index){
        Post post = _postList[index];
        return Text('${post.address}');
      });
    }
}