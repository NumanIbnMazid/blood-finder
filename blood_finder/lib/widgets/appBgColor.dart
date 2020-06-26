import 'package:flutter/material.dart';

appBgColor() {
  return BoxDecoration(
    borderRadius: BorderRadius.all(Radius.circular(5)),
    boxShadow: <BoxShadow>[
      BoxShadow(
          color: Colors.grey.shade200,
          offset: Offset(2, 4),
          blurRadius: 5,
          spreadRadius: 2)
    ],
    gradient: LinearGradient(
      colors: [Colors.red[100], Colors.red[300]],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  );
}
