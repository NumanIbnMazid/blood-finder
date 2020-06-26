import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:blood_finder/utils/themeConfig.dart';
// Screens Import
import 'package:blood_finder/screens/welcome.dart';
import 'package:blood_finder/screens/home.dart';
import 'package:blood_finder/screens/login.dart';
import 'package:blood_finder/screens/signup.dart';
import 'package:blood_finder/screens/userListScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  // SharedPreferences.setMockInitialValues({});
  await GetStorage.init();
  runApp(BloodFinderApp());
}

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   SharedPreferences.setMockInitialValues({});
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   var token = prefs.getString('token');
//   print(token);
//   runApp(MaterialApp(home: token == null ? WelcomePage() : HomePage()));
// }

class BloodFinderApp extends StatelessWidget {

  final appTitle = 'Blood Finder';

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            SizeConfig().init(constraints, orientation);
            return MaterialApp(
              title: appTitle,
              theme: ThemeData(
                primarySwatch: Colors.red,
                textTheme: GoogleFonts.latoTextTheme(textTheme).copyWith(
                  bodyText1:
                      GoogleFonts.montserrat(textStyle: textTheme.bodyText1),
                ),
              ),
              debugShowCheckedModeBanner: false,
              // home: WelcomePage(),
              routes: <String, WidgetBuilder>{
                '/': (BuildContext context) => WelcomePage(),
                '/home': (BuildContext context) => HomePage(),
                '/login': (BuildContext context) => LoginPage(),
                '/signup': (BuildContext context) => SignUpPage(),
                '/users': (BuildContext context) => UserListView(),
                '/welcome': (BuildContext context) => WelcomePage(),
              },
            );
          },
        );
      },
    );
  }
}
