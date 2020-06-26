import 'package:blood_finder/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

readStorageToken(context) async {
  final box = GetStorage();
  String value = await box.read('token') ?? null;
  print("utils : constants => 8 (box token value read) => $value");

  if (value == null) {
    Navigator.of(context).push(new MaterialPageRoute(
      builder: (BuildContext context) => LoginPage(),
    ));
  }
}
