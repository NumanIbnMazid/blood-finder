import 'package:flutter/material.dart';
// internal imports
import 'package:blood_finder/models/user.dart';
import 'package:blood_finder/widgets/user/userList.dart';
import 'package:blood_finder/providers/user.dart';
import 'package:blood_finder/widgets/drawerList.dart';
import 'package:blood_finder/widgets/appBar.dart';
import 'package:blood_finder/utils/constants.dart';

class UserListView extends StatefulWidget {
  // final String title;
  // final appTitle = 'Blood Finder Users';

  // UserListView({Key key, this.title}) : super(key: key);

  @override
  _UserListViewState createState() => _UserListViewState();
}

class _UserListViewState extends State<UserListView> {

  @override
  void initState() { 
    super.initState();
    readStorageToken(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('All Users'),
      drawer: appDrawer(context),
      body: FutureBuilder<List<User>>(
        future: fetchUsers(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? ListViewUsers(users: snapshot.data)
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
