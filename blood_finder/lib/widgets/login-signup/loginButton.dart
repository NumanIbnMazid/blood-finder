import 'package:flutter/material.dart';
import 'package:blood_finder/screens/login.dart';

Widget loginButton(context) {
  return InkWell(
    onTap: () {
      // print(MediaQuery.of(context).size.width);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    },
    child: Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(vertical: 13),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          color: Colors.green),
      child: Text(
        'Login',
        style: TextStyle(
          fontSize: 20, 
          color: Colors.white
        ),
      ),
    ),
  );
}
