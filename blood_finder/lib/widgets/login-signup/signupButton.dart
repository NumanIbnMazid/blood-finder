import 'package:flutter/material.dart';
import 'package:blood_finder/screens/signup.dart';

Widget signupButton(context) {
  return InkWell(
    onTap: () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => SignUpPage()));
    },
    child: Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(vertical: 13),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        color: Colors.blue
      ),
      child: Text(
        'Create Account',
        style: TextStyle(fontSize: 20, color: Colors.white),
      ),
    ),
  );
}
