import 'package:flutter/material.dart';
import 'package:blood_finder/screens/home.dart';
import 'package:blood_finder/screens/userListScreen.dart';

Widget submitButton(context, String title) {
  return GestureDetector(
    onTap: () {
      // Navigator.pop(context);
      // Navigator.of(context).push(
      //   MaterialPageRoute(
      //     builder: (context) => UserListView(),
      //   ),
      // );
    },
    child: Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(vertical: 15),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey.shade200,
                offset: Offset(2, 4),
                blurRadius: 5,
                spreadRadius: 2)
          ],
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Colors.amber[400], Colors.redAccent[400]])),
      child: Text(
        title,
        style: TextStyle(fontSize: 20, color: Colors.white),
      ),
    ),
  );
}
