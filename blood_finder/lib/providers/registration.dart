import 'package:blood_finder/utils/apiUrls.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get_storage/get_storage.dart';

class UserRegistration {
  String token;
  int statusCode;
  Map<String, dynamic> data;

  UserRegistration({this.token, this.statusCode});

  userRegistrationCall(
      {String username,
      String email,
      String password1,
      String password2,
      String bloodGroup}) async {
    var urlInstance = APIurl();

    final response = await http.post(urlInstance.getRegistrationURL(), 
    headers: {
      'Accept': 'application/json'
    }, 
    body: {
      "username": "$username",
      "email": "$email",
      "blood_group": "$bloodGroup",
      "password1": "$password1",
      "password2": "$password2",
    });

    data = json.decode(response.body);
    // print("providers : registration => 34 (data value read) => $data");

    Map<String, dynamic> jsonObj = jsonDecode(response.body);

    try {
      final String token = jsonObj['key'];
      final int id = jsonObj['user']['id'];
      final int profileID = jsonObj['user']['profile_id'];
      final String profileSlug = jsonObj['user']['profile_slug'];

      // print("providers : registration => 44 (token value read) => $token");
      // print("providers : registration => 45 (id value read) => $id");
      // print(
      //     "providers : registration => 46 (profileID value read) => $profileID");
      // print(
      //     "providers : registration => 47 (profileSlug value read) => $profileSlug");

      // print(
      //     "providers : registration => 48 (response.statusCode value read) => ${response.statusCode}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        this.statusCode = 201;
        // Save objects to local storage
        await _save(token,
            id: id, profileID: profileID, profileSlug: profileSlug);
      } else {
        this.statusCode = 0;
        throw Exception('Failed to register user!');
      }
    } catch (e) {
      throw Exception('Failed to get user profile object!');
    }

    this.data = data;
  }

  _save(String token, {int id, int profileID, String profileSlug}) async {
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
    // print("""providers : registration => 73 (box value read) =>
    //   (tId) => $tId,
    //   (tProfileID) => $tProfileID,
    //   (tProfileSlug) => $tProfileSlug,
    //   """);
  }

  read() async {
    final box = GetStorage();
    await box.read('token');
    // String value = await box.read('token') ?? null;
    // print("providers : registration => 85 (box token value read) => $value");
  }
}
