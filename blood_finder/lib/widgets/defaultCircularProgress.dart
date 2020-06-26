import 'package:flutter/material.dart';

Widget defaultCircularProgress({String progressTitle}) {
  return Container(
      child: Center(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: SizedBox(
            height: 33,
            width: 33,
            child: CircularProgressIndicator(
              backgroundColor: Colors.red,
              strokeWidth: 3,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 13),
          child: Center(
            child: Text(
              progressTitle != null ? progressTitle : "Loading ...",
              style: TextStyle(
                fontSize: 16,
                color: Colors.blue,
                fontStyle: FontStyle.italic
              ),
            ),
          ),
        )
      ],
    ),
  ));
}
