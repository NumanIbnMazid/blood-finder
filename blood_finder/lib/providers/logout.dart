import 'package:blood_finder/utils/apiUrls.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:blood_finder/utils/deviceInfo.dart';
import 'package:get_storage/get_storage.dart';

class UserLogout {
  int statusCode;
  String tokenValue;

  UserLogout({this.statusCode});

  logoutCall() async {
    final urlInstance = APIurl();

    // Get token
    // if (getDevice() == 'web') {
    //   SharedPreferences prefs = await SharedPreferences.getInstance();
    //   tokenValue = await prefs.getString('token') ?? null;
    //   print("providers : user => 18 (preference tokenValue read) => $tokenValue");
    // } else {
    //   final storage = FlutterSecureStorage();
    //   tokenValue = await storage.read(key: 'token') ?? null;
    //   print("providers : user => 22 (storage tokenValue read) => $tokenValue");
    // }

    final box = GetStorage();
    tokenValue = await box.read('token') ?? null;
    // print("providers : user => 31 (box tokenValue read) => $tokenValue");

    final response = await http.post(
      urlInstance.getLogoutURL(),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Token $tokenValue',
      },
    );

    final data = json.decode(response.body);

    // print("providers: logout 43 => (response.statusCode) => ${response.statusCode}");
    // print("providers: logout 44 => (data) => $data");

    // Delete Storage (Should be comment)
    _deleteStorage();

    if (response.statusCode == 200) {
      this.statusCode = 200;
      // Delete Storage (Should be uncomment)
      // _deleteStorage();
    } else {
      this.statusCode = 0;
      throw Exception("Failed to logout user!");
    }
  }

  void _deleteStorage() async {
    try {
      // if (getDevice() == 'web') {
      //   SharedPreferences prefs = await SharedPreferences.getInstance();
      //   await prefs.remove('token');
      // } else {
      //   final storage = FlutterSecureStorage();
      //   await storage.delete(key: 'token');
      // }
      final box = GetStorage();
      // await box.remove('token');
      await box.erase();
    } catch (e) {
      throw Exception("Could not delete the token for the user!");
    }
  }

  read() async {
    // if (getDevice() == 'web') {
    //   SharedPreferences prefs = await SharedPreferences.getInstance();
    //   final value = await prefs.getString('token') ?? null;
    //   print("providers : logout => 53 (preference value read) => $value");
    // } else {
    //   final storage = FlutterSecureStorage();
    //   String value = await storage.read(key: 'token') ?? null;
    //   print("providers : logout => 57 (storage value read) => $value");
    // }

    final box = GetStorage();
    String value = await box.read('token') ?? null;
    // print("providers : logout => 84 (box value read) => $value");
  }
}
