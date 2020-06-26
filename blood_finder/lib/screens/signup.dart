import 'package:blood_finder/widgets/login-signup/buttonStyle.dart';
import 'package:flutter/material.dart';
import 'package:blood_finder/widgets/bazierContainer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:blood_finder/screens/login.dart';
import 'package:blood_finder/screens/home.dart';
import 'package:blood_finder/widgets/appTitle.dart';
import 'package:blood_finder/widgets/backButton.dart';
import 'package:blood_finder/widgets/login-signup/alreadyAccount.dart';
import 'package:blood_finder/widgets/login-signup/formField.dart';
import 'package:blood_finder/widgets/login-signup/submitButton.dart';
import 'package:blood_finder/widgets/appBgColor.dart';
import 'package:blood_finder/utils/deviceInfo.dart';
import 'package:blood_finder/providers/registration.dart';
import 'package:get_storage/get_storage.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:blood_finder/widgets/defaultCircularProgress.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String _selectedBloodGroup;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool isLoading = false;

  List bloodGroupChoicesDataSource = [
    // {"display": "--- Select ---", "value": ""},
    {"display": "A+", "value": "A_POSITIVE"},
    {"display": "A-", "value": "A_NEGATIVE"},
    {"display": "B+", "value": "B_POSITIVE"},
    {"display": "B-", "value": "B_NEGATIVE"},
    {"display": "O+", "value": "O_POSITIVE"},
    {"display": "O-", "value": "O_NEGATIVE"},
    {"display": "AB+", "value": "AB_POSITIVE"},
    {"display": "AB-", "value": "AB_NEGATIVE"}
  ];

  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _password1Controller = TextEditingController();
  final _password2Controller = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _password1Controller.dispose();
    _password2Controller.dispose();
    super.dispose();
  }

  read() async {
    final box = GetStorage();
    String value = await box.read('token') ?? null;
    // print("screens : signup => 47 (box token value read) => $value");

    if (value != null) {
      Navigator.of(context).push(new MaterialPageRoute(
        builder: (BuildContext context) => HomePage(),
      ));
    }
  }

  @override
  void initState() {
    super.initState();
    read();
    _selectedBloodGroup = '';
  }

  // User registration instance
  UserRegistration userRegistration = UserRegistration();
  String resultStatus;

  _onPressed() async {
    setState(() {
      _selectedBloodGroup = _selectedBloodGroup;
    });

    if (_formKey.currentState.validate()) {
      if (_usernameController.text.trim().toLowerCase().isNotEmpty &&
          _emailController.text.trim().toLowerCase().isNotEmpty &&
          _password1Controller.text.trim().isNotEmpty &&
          _password2Controller.text.trim().isNotEmpty) {
        setState(() {
          isLoading = true;
        });
        // print("screens : signup => 88 (_selectedBloodGroup value read) => $_selectedBloodGroup");
        userRegistration
            .userRegistrationCall(
                username: _usernameController.text.trim().toLowerCase(),
                email: _emailController.text.trim().toLowerCase(),
                bloodGroup: _selectedBloodGroup,
                password1: _password1Controller.text.trim(),
                password2: _password2Controller.text.trim())
            .whenComplete(() {
          setState(() {
            isLoading = false;
          });
          // print("screens : signup => 101 (this.data value read) => ${userRegistration.data}");
          if (userRegistration.statusCode == 200 ||
              userRegistration.statusCode == 201) {
            _formKey.currentState.save();
            Navigator.pushReplacementNamed(context, '/home');
          } else {
            if (userRegistration.data == null) {
              resultStatus = "Something went wrong ! Please try again";
            } else {
              var errorList = [];
              var concatenate = StringBuffer();
              userRegistration.data
                  .forEach((key, value) => errorList.add(["$key: $value"]));
              errorList.forEach((item) {
                concatenate.write(
                    "$item \n \n".replaceAll('[', '').replaceAll(']', ''));
              });
              // print("screens : signup => 117 (concatenate value read) => $concatenate");
              resultStatus = concatenate.toString();
            }
            _registrationErrorDialog(context,
                message: resultStatus, messageTitle: "Error!");
          }
        });
      }
    }
  }

  Widget _emailPasswordWidget() {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          formField("Username",
              controller: _usernameController, doValidate: true),
          formField("Email",
              isEmail: true, controller: _emailController, doValidate: true),
          Container(
            color: Colors.white,
            child: DropDownFormField(
              titleText: 'Blood Group',
              hintText: 'Please Select Blood Group',
              value: _selectedBloodGroup,
              onSaved: (value) {
                setState(() {
                  _selectedBloodGroup = value;
                });
              },
              onChanged: (value) {
                setState(() {
                  _selectedBloodGroup = value;
                });
              },
              dataSource: bloodGroupChoicesDataSource,
              textField: 'display',
              valueField: 'value',
            ),
          ),
          formField("Password",
              isPassword: true,
              controller: _password1Controller,
              doValidate: true),
          formField("Confirm Password",
              isPassword: true,
              isPassword2: true,
              controller: _password2Controller,
              password1Controller: _password1Controller,
              doValidate: true),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    // if (isLoading == true) {
    //   _scaffoldKey.currentState.showSnackBar(SnackBar(
    //     duration: Duration(seconds: 4),
    //     backgroundColor: Colors.red[400],
    //     content: Row(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: [
    //         CircularProgressIndicator(),
    //         Text("  Creating account ...")
    //       ],
    //     ),
    //   ));
    // }
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        height: height,
        child: Stack(
          children: <Widget>[
            // Positioned(
            //   top: -MediaQuery.of(context).size.height * .15,
            //   right: -MediaQuery.of(context).size.width * .4,
            //   child: BezierContainer(),
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
                    SizedBox(height: height * .13),
                    appTitle(context),
                    SizedBox(
                      height: 23,
                    ),
                    Container(
                        width: isLargeScreen(context) == true
                            ? SizeChooser().getcWidth(context) * 60
                            : SizeChooser().getdWidth(context),
                        child: Column(
                          children: [
                            _emailPasswordWidget(),
                            SizedBox(
                              height: 20,
                            ),
                            GestureDetector(
                              onTap: _onPressed,
                              child:
                                  buttonStyle(context, title: 'Create Account'),
                            ),
                          ],
                        )),
                    // SizedBox(height: height * .09),
                    SizedBox(height: 10),
                    isLoading ? defaultCircularProgress(
                      progressTitle: "Creating account ..."
                    ) : alreadyAccountLabel(context),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ),
            Positioned(top: 40, left: 0, child: backButton(context)),
          ],
        ),
      ),
    );
  }

  // Registration Error Dialog
  _registrationErrorDialog(context, {String message, String messageTitle}) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.red[100],
            title: Center(
                child: Text(
              messageTitle,
              style: TextStyle(
                  fontSize: 23,
                  color: Colors.red[900],
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic),
            )),
            content: Text(
              message,
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.red[800],
                  fontWeight: FontWeight.bold),
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
}
