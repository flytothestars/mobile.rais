import 'package:shared_preferences/shared_preferences.dart';

import '../models/api_response.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/post.dart';
import 'constant.dart';

Future<ApiResponse> getPost() async {
  ApiResponse apiResponse = ApiResponse();
  try {
    final response = await http
        .get(Uri.parse(listPostURL), headers: {'Accept': 'application/json'});
    switch (response.statusCode) {
      case 200:
        print("response body");
        print(response.body);
        apiResponse.data = jsonDecode(response.body)['post'];
        break;
      case 422:
        final errors = jsonDecode(response.body)['errors'];
        apiResponse.error = errors[errors.keys.ElementAt(0)];
        break;
      case 403:
        apiResponse.error = jsonDecode(response.body)['message'];
        break;
      default:
        apiResponse.error = somethingWentWrong;
    }
  } catch (e) {
    apiResponse.error = serverError;
  }

  return apiResponse;
}

Future<ApiResponse> getPowerBank(String idUser, String idPost) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    final response = await http.post(Uri.parse(checkSmsURL),
        headers: {'Accept': 'application/json'}, body: {});

    switch (response.statusCode) {
      case 200:
        break;
      case 422:
        final errors = jsonDecode(response.body)['errors'];
        apiResponse.error = errors[errors.keys.ElementAt(0)];
        break;
      case 403:
        apiResponse.error = jsonDecode(response.body)['message'];
        break;
      default:
        apiResponse.error = somethingWentWrong;
    }
  } catch (e) {
    apiResponse.error = serverError;
  }

  return apiResponse;
}

Future<ApiResponse> getHistory() async {
  ApiResponse apiResponse = ApiResponse();
  try {
    SharedPreferences pref = await SharedPreferences.getInstance();

    final response = await http.post(Uri.parse(getHistoryURL), headers: {
      'Accept': 'application/json'
    }, body: {
      'id_user': pref.getInt('userId').toString(),
    });
    switch (response.statusCode) {
      case 200:
        print("response body");
        print(response.body);
        apiResponse.data = jsonDecode(response.body)['history'];
        break;
      case 422:
        final errors = jsonDecode(response.body)['errors'];
        apiResponse.error = errors[errors.keys.ElementAt(0)];
        break;
      case 403:
        apiResponse.error = jsonDecode(response.body)['message'];
        break;
      default:
        apiResponse.error = somethingWentWrong;
    }
  } catch (e) {
    apiResponse.error = serverError;
  }
  return apiResponse;
}
