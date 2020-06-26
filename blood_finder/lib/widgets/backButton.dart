import 'package:flutter/material.dart';
import 'package:blood_finder/screens/welcome.dart';

Widget backButton(context) {
  return InkWell(
    onTap: () {
      // Navigator.pop(context);
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => WelcomePage(),
        ),
      );
    },
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
            child: Icon(Icons.keyboard_arrow_left, color: Colors.black),
          ),
          Text('Back',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
        ],
      ),
    ),
  );
}
