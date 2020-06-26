import 'package:flutter/material.dart';
import 'package:blood_finder/screens/signup.dart';

Widget createAccountLabel(context) {
  return InkWell(
    onTap: () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => SignUpPage()));
    },
    child: Container(
      margin: EdgeInsets.symmetric(vertical: 7),
      padding: EdgeInsets.all(13),
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Don\'t have an account ?',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            'Register',
            style: TextStyle(
                color: Colors.blueGrey,
                fontSize: 17,
                fontWeight: FontWeight.w600),
          ),
        ],
      ),
    ),
  );
}
