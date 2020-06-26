import 'package:flutter/material.dart';
import 'package:blood_finder/screens/userListScreen.dart';

facebookLogin(context) {
  return GestureDetector(
    onTap: () {
      // Navigator.pop(context);
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => UserListView(),
        ),
      );
    },
      child: Container(
      height: 50,
      margin: EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xff2872ba),
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(5),
                    topRight: Radius.circular(5)),
              ),
              alignment: Alignment.center,
              child: Text('Log in with Facebook',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w400)),
            ),
          ),
        ],
      ),
    ),
  );
}
