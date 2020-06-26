import 'package:blood_finder/widgets/login-signup/logoutDialog.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:blood_finder/widgets/bazierContainer.dart';
import 'package:blood_finder/screens/signup.dart';
import 'package:blood_finder/widgets/appTitle.dart';
import 'package:blood_finder/widgets/login-signup/facebookLogin.dart';
import 'package:blood_finder/widgets/login-signup/createAccountLabel.dart';
import 'package:blood_finder/widgets/backButton.dart';
import 'package:blood_finder/widgets/divider.dart';
import 'package:blood_finder/widgets/login-signup/formField.dart';
import 'package:blood_finder/widgets/appBgColor.dart';
import 'package:blood_finder/utils/deviceInfo.dart';
import 'package:blood_finder/widgets/login-signup/buttonStyle.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:blood_finder/providers/login.dart';
import 'package:blood_finder/screens/home.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_storage/get_storage.dart';


class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  read() async {
    String value;
    // if (getDevice() == 'web') {
    //   SharedPreferences prefs = await SharedPreferences.getInstance();
    //   value = await prefs.getString('token') ?? null;
    //   print("screens : login => 45 (preference value read) => $value");
    // } else {
    //   final storage = FlutterSecureStorage();
    //   value = await storage.read(key: 'token') ?? null;
    //   print("screens : login => 49 (storage value read) => $value");
    // }

    final box = GetStorage();
    value = await box.read('token') ?? null;
    // print("screens : login => 56 (box value read) => $value");

    if (value != null) {
      Navigator.of(context).push(new MaterialPageRoute(
        builder: (BuildContext context) => HomePage(),
      ));
    }
  }

  @override
  initState() {
    super.initState();
    read();
  }

  // user login instance
  UserLogin userLogin = UserLogin();
  String resultStatus = "";

  _onPressed() {
    setState(() {
      if (_formKey.currentState.validate()) {
        if (_emailController.text.trim().toLowerCase().isNotEmpty &&
            _passwordController.text.trim().isNotEmpty) {
          userLogin
              .loginData(_emailController.text.trim().toLowerCase(),
                  _passwordController.text.trim())
              .whenComplete(() {
            if (userLogin.statusCode == 200) {
              _formKey.currentState.save();
              Navigator.pushReplacementNamed(context, '/home');
            } else {
              resultStatus = 'Please check again your credentials!';
              _loginErrorDialog(context,
                  message: resultStatus, messageTitle: "Error!");
            }
          });
        }
      }
    });
  }

  Widget _emailPasswordWidget() {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          formField("Email",
            isEmail: true, controller: _emailController, doValidate: true
          ),
          formField(
            "Password",
            isPassword: true,
            controller: _passwordController,
            doValidate: true
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
      height: height,
      child: Stack(
        children: <Widget>[
          // Positioned(
          //   top: -height * .15,
          //   right: -MediaQuery.of(context).size.width * .4,
          //   child: BezierContainer()
          // ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            height: MediaQuery.of(context).size.height,
            decoration: appBgColor(),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: height * .2),
                  appTitle(context),
                  SizedBox(height: 50),
                  Container(
                      width: isLargeScreen(context) == true
                          ? SizeChooser().getcWidth(context) * 60
                          : SizeChooser().getdWidth(context),
                      child: Column(
                        children: [
                          _emailPasswordWidget(),
                          SizedBox(height: 20),
                          GestureDetector(
                            onTap: _onPressed,
                            child: buttonStyle(context, title: 'Login'),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            alignment: Alignment.centerRight,
                            child: Text('Forgot Password ?',
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w500)),
                          ),
                          divider(),
                          facebookLogin(context),
                          // SizedBox(height: height * .055),
                          SizedBox(height: 10),
                        ],
                      )),
                  createAccountLabel(context),
                ],
              ),
            ),
          ),
          Positioned(top: 40, left: 0, child: backButton(context)),
        ],
      ),
    ));
  }

  // Show Dialog
  _loginErrorDialog(context, {String message, String messageTitle}) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(child: Text(messageTitle)),
            content: Text(message),
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
}
