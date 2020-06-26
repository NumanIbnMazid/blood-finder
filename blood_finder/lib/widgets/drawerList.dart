import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:blood_finder/widgets/login-signup/logoutDialog.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:blood_finder/utils/deviceInfo.dart';
import 'package:get_storage/get_storage.dart';
import 'package:blood_finder/widgets/appTitle.dart';
import 'package:blood_finder/providers/userProfile.dart';
import 'package:blood_finder/widgets/defaultCircularProgress.dart';

Future getData() async {
  // if (getDevice() == 'web') {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   value = await prefs.getString('token') ?? null;
  //   print("widgets : drawerList => 12 (preference value read) => $value");
  // } else {
  //   final storage = FlutterSecureStorage();
  //   value = await storage.read(key: 'token') ?? null;
  //   print("widgets : drawerList => 16 (storage value read) => $value");
  // }
  final box = GetStorage();
  String value = await box.read('token') ?? null;
  // print("widgets : drawerList => 24 (box value read) => $value");

  UserProfile userProfileInstance = UserProfile();
  var profileData = await userProfileInstance.getProfileDataCall() ?? null;
  // print("widgets : drawerList => 28 (profileData value read) => \n $profileData \n");

  final data = {'token': value, 'profileData': profileData};
  // final data = null;

  // print("widgets : drawerList => 33 (data value read) => \n $data \n");

  return data;
}

// snapshot.data['profileData']['get_dynamic_name']
Widget appDrawer(context) {
  return FutureBuilder(
    future: getData(),
    builder: (BuildContext context, snapshot) {
      if (snapshot.hasData) {
        return SafeArea(
          child: Drawer(
            child: Container(
              color: Colors.red[50],
              child: ListView(
                // Important: Remove any padding from the ListView.
                padding: EdgeInsets.zero,
                children: <Widget>[
                  DrawerHeader(
                    decoration: BoxDecoration(
                      color: Colors.red[100]
                    ),
                    child: Container(
                        child: Column(
                      children: [
                        appTitle(context),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.fromLTRB(0, 15, 0, 5),
                              child: Text(
                                "${snapshot.data['profileData']['get_dynamic_name']}",
                                style: GoogleFonts.portLligatSans(
                                  textStyle:
                                      Theme.of(context).textTheme.headline4,
                                  fontSize: 23,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey[800],
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                              child: Text(
                                "${snapshot.data['profileData']['user__email']}",
                                style: GoogleFonts.portLligatSans(
                                  textStyle:
                                      Theme.of(context).textTheme.headline4,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey[800],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )),
                  ),
                  ListTile(
                    title: Text('Welcome Page'),
                    onTap: () {
                      // Navigator.of(context).push(
                      //   MaterialPageRoute(
                      //     builder: (BuildContext context) => WelcomePage(),
                      //   ),
                      // );
                      Navigator.pushReplacementNamed(context, '/welcome');
                    },
                  ),
                  ListTile(
                    title: Text('Users'),
                    onTap: () {
                      // Navigator.of(context).push(MaterialPageRoute(
                      //   builder: (BuildContext context) => UserListView(),
                      // ));
                      Navigator.pushReplacementNamed(context, '/users');
                    },
                  ),
                  ListTile(
                    title: Text(snapshot.data != null ? 'Logout' : 'Login'),
                    onTap: () {
                      // print(
                      //   "widgets : drawerList => 77 (snapshot data value read) => \n ${snapshot.data} \n"
                      // );
                      // print(
                      //   "widgets : drawerList => 80 (snapshot data username value read) => \n ${snapshot.data['profileData']['user__username']} \n"
                      // );
                      if (snapshot.data['token'] != null) {
                        // Navigator.pushReplacementNamed(context, '/logout');
                        logoutDialog(context,
                            message: "Are you sure you want to logout?",
                            messageTitle: "Logout");
                      } else {
                        Navigator.pushReplacementNamed(context, '/login');
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      }
      return defaultCircularProgress();
    },
  );
}
