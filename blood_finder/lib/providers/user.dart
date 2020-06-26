import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:blood_finder/models/user.dart';
import 'package:flutter/foundation.dart';
import 'package:blood_finder/utils/apiUrls.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:blood_finder/utils/deviceInfo.dart';
import 'package:get_storage/get_storage.dart';

Future<List<User>> fetchUsers() async {
  var urlInstance = APIurl();
  String value;

  // if (getDevice() == 'web') {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   value = await prefs.getString('token') ?? null;
  //   print("providers : user => 18 (preference value read) => $value");
  // } else {
  //   final storage = FlutterSecureStorage();
  //   value = await storage.read(key: 'token') ?? null;
  //   print("providers : user => 22 (storage value read) => $value");
  // }

  final box = GetStorage();
  value = await box.read('token') ?? null;
  // print("providers : user => 28 (box value read) => $value");

  try {
    final response = await http.get(urlInstance.getUserListURL(), headers: {
      'Accept': 'application/json',
      'Authorization': 'Token $value',
      // "Access-Control-Allow-Origin": "*",
      // "Access-Control-Allow-Methods": "DELETE, POST, GET, OPTIONS",
      // "Access-Control-Allow-Headers":
      //     "Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With"
    });

    if (response.statusCode == 200) {
      return compute(parsedUsers, response.body);
    } else {
      throw Exception('Failed to load users');
    }
  } catch (e) {
    print(e);
    throw Exception('HTTP get failed!!!');
  }
}

List<User> parsedUsers(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<User>((json) => User.fromJson(json)).toList();
}
