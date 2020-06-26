import 'package:flutter/material.dart';
import 'package:blood_finder/widgets/drawerList.dart';
import 'package:blood_finder/widgets/appBar.dart';


class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('Home Page'),
      drawer: appDrawer(context),
      body: Center(
        child: Text("Welcome to Blood Finder"),
      ),
    );
  }
}