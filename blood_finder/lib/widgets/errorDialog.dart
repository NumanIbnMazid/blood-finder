import 'package:flutter/material.dart';

errorDialog(context, {String message, String messageTitle}) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.red[100],
          title: Center(
            child: Text(
              messageTitle,
              style: TextStyle(
                color: Colors.red,
                fontSize: 23,
                fontWeight: FontWeight.bold,
                letterSpacing: 2
              ),
            )
          ),
          content: Text(
            message,
            style: TextStyle(
              color: Colors.red[600],
              fontSize: 20,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),
          actions: <Widget>[
            RaisedButton(
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
