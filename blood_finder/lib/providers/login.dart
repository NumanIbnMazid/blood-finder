import 'package:blood_finder/utils/apiUrls.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:blood_finder/utils/deviceInfo.dart';
import 'package:get_storage/get_storage.dart';

class UserLogin {
  String token;
  int statusCode;

  UserLogin({this.token, this.statusCode});

  loginData(String email, String password) async {
    var urlInstance = APIurl();

    final response = await http.post(urlInstance.getLoginURL(),
        headers: {'Accept': 'application/json'},
        body: {"email": "$email", "password": "$password"});

    // var data = json.decode(response.body);
    // print("providers : login => 23 (data value read) => $data");

    Map<String, dynamic> jsonObj = jsonDecode(response.body);

    final String token = jsonObj['key'];
    final int id = jsonObj['user']['id'];
    final int profileID = jsonObj['user']['profile_id'];
    final String profileSlug = jsonObj['user']['profile_slug'];

    // print("providers : login => 32 (token value read) => $token");
    // print("providers : login => 33 (id value read) => $id");
    // print("providers : login => 34 (profileID value read) => $profileID");
    // print("providers : login => 35 (profileSlug value read) => $profileSlug");

    if (response.statusCode == 200) {
      this.statusCode = 200;
      // Save objects to local storage
      await _save(token, id: id, profileID: profileID, profileSlug: profileSlug);
    } else {
      this.statusCode = 0;
      throw Exception('Failed to authorize user!');
    }
  }

  _save(String token, {int id, int profileID, String profileSlug}) async {
    // if (getDevice() == 'web') {
    //   SharedPreferences prefs = await SharedPreferences.getInstance();
    //   await prefs.setString('token', token);
    // } else {
    //   final storage = FlutterSecureStorage();
    //   await storage.write(key: 'token', value: token);
    // }
    final box = GetStorage();
    await box.write('token', token);

    if (id != null) {
      await box.write('userID', id);
    }
    if (profileID != null) {
      await box.write('profileID', profileID);
    }
    if (profileSlug != null) {
      await box.write('profileSlug', profileSlug);
    }

    // int tId = await box.read('userID') ?? null;
    // int tProfileID = await box.read('profileID') ?? null;
    // String tProfileSlug = await box.read('profileSlug') ?? null;
    // print(
    //   """providers : login => 72 (box value read) =>
    //   (tId) => $tId,
    //   (tProfileID) => $tProfileID,
    //   (tProfileSlug) => $tProfileSlug,
    //   """
    // );
  }

  read() async {
    // if (getDevice() == 'web') {
    //   SharedPreferences prefs = await SharedPreferences.getInstance();
    //   String value = await prefs.getString('token') ?? null;
    //   print("providers : login => 84 (preference value read) => $value");
    // } else {
    //   final storage = FlutterSecureStorage();
    //   String value = await storage.read(key: 'token') ?? null;
    //   print("providers : login => 88 (storage value read) => $value");
    // }
    final box = GetStorage();
    await box.read('token');
    // String value = await box.read('token') ?? null;
    // print("providers : login => 93 (box value read) => $value");
  }
}
