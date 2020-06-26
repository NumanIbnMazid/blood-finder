import 'package:flutter/material.dart';
import 'package:blood_finder/models/user.dart';

class ListViewUsers extends StatelessWidget {
  final List<User> users;

  ListViewUsers({Key key, this.users}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
          itemCount: users.length,
          padding: const EdgeInsets.all(15.0),
          itemBuilder: (context, index) {
            return Column(
              children: <Widget>[
                Divider(height: 5.0),
                ListTile(
                  title: Text(
                    '${users[index].username}',
                    style: TextStyle(
                      fontSize: 22.0,
                      color: Colors.deepOrangeAccent,
                    ),
                  ),
                  subtitle: Text(
                    '${users[index].email}',
                    style: new TextStyle(
                      fontSize: 18.0,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  leading: Column(
                    children: <Widget>[
                      Expanded(
                        child: CircleAvatar(
                          backgroundColor: Colors.blueAccent,
                          radius: 35.0,
                          child: Text(
                            'User ${users[index].id}',
                            style: TextStyle(
                              fontSize: 22.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  onTap: () {},
                ),
              ],
            );
          }),
    );
  }
}
