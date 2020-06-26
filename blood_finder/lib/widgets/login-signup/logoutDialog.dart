import 'package:flutter/material.dart';
import 'package:blood_finder/providers/logout.dart';
import 'package:blood_finder/widgets/errorDialog.dart';

// Show Dialog
Widget logoutDialog(context, {String message, String messageTitle}) {
  UserLogout userLogout = UserLogout();
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.red[100],
          title: Center(child: Text(messageTitle)),
          content: Text(message),
          actions: <Widget>[
            RaisedButton(
              color: Colors.green,
              child: Text(
                'Yes',
              ),
              onPressed: () async {
                userLogout.logoutCall().whenComplete(() {
                  if (userLogout.statusCode == 200) {
                    Navigator.pushReplacementNamed(context, '/login');
                  } else {
                    errorDialog(context,
                        message: "Something went wrong", messageTitle: "OOPS!");
                  }
                });
              },
            ),
            RaisedButton(
              color: Colors.red,
              child: Text(
                'Close',
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      });
}
