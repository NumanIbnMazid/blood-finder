import 'package:blood_finder/utils/apiUrls.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get_storage/get_storage.dart';


class UserProfile {
  int statusCode;
  String profileSlug;
  String tokenValue;

  UserProfile({this.statusCode, this.profileSlug, this.tokenValue});

  getProfileDataCall() async {

    final urlInstance = APIurl();
    final box = GetStorage();

    // Get profileSlug from storage
    profileSlug = await box.read("profileSlug") ?? null;
    // Get token value from storage
    tokenValue = await box.read("token") ?? null;

    // print("providers : userProfile => 24 (box profileSlug read) => $profileSlug");
    // print("providers : userProfile => 25 (box tokenValue read) => $tokenValue");

    // fetch data from api get request
    final response = await http.get(
      "${urlInstance.getUserProfileURL()}$profileSlug/",
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Token $tokenValue',
      },
    );

    // decode json data
    final data = json.decode(response.body);

    // print("providers: userProfile 39 => (response.statusCode) => ${response.statusCode}");
    // print("providers: userProfile 40 => (data) => \n $data \n");

    if (response.statusCode == 200 || response.statusCode == 201) {
      this.statusCode = 200;
    } else {
      this.statusCode = 0;
      throw Exception('Failed to get user profile!');
    }
    return data;
  }
}