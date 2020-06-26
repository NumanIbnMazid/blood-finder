import 'package:blood_finder/widgets/login-signup/logoutDialog.dart';
import 'package:flutter/material.dart';
import 'package:blood_finder/screens/signup.dart';
import 'package:blood_finder/screens/login.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:blood_finder/widgets/appBgColor.dart';
import 'package:blood_finder/widgets/appTitle.dart';
import 'package:blood_finder/widgets/login-signup/loginButton.dart';
import 'package:blood_finder/widgets/login-signup/signupButton.dart';


class WelcomePage extends StatefulWidget {
  WelcomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SingleChildScrollView(
        child:Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            height: MediaQuery.of(context).size.height,
            decoration: appBgColor(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                appTitle(context),
                SizedBox(
                  height: 80,
                ),
                loginButton(context),
                SizedBox(
                  height: 20,
                ),
                signupButton(context),
                SizedBox(
                  height: 20,
                ),
                Container(
                  color: Colors.red,
                  child: ListTile(
                    title: Center(child: Text('Logout')),
                    onTap: () async {
                      logoutDialog(context,
                            message: "Are you sure you want to logout?",
                            messageTitle: "Logout");
                    },
                  ),
                ),
              ],
            ),
          ),
      ),
    );
  }
}