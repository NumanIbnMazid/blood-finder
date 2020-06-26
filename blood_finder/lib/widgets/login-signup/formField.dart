import 'package:flutter/material.dart';

Widget formField(String title,
    {TextEditingController controller,
    bool isPassword = false,
    bool isEmail = false,
    bool doValidate = false,
    bool isPassword2 = false,
    TextEditingController password1Controller}) {
  return Column(
    children: [
      Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Text(
            //   title,
            //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            // ),
            SizedBox(
              height: 7,
            ),
            TextFormField(
              validator: (value) {
                if (doValidate == true) {
                  if (value.isEmpty) {
                    return 'Please enter this field!';
                  }
                  if (isEmail == true) {
                    bool isValidEmail = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value);
                    // print(isValidEmail);
                    if (isValidEmail == false) {
                      return "Please enter a valid email!";
                    }
                  }
                  if (isPassword2 == true) {
                    if (value != password1Controller.text) {
                      return "Password doesn't match!";
                    }
                  }
                }
                return null;
              },
              controller: controller,
              // keyboardType: TextInputType.emailAddress,
              obscureText: isPassword,
              decoration: InputDecoration(
                border: InputBorder.none,
                fillColor: Color(0xfff3f3f4),
                filled: true,
                labelText: title
              )
            )
          ],
        ),
      ),
    ],
  );
}
              
