import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';


class User {
  final int id;
  final String username;
  final String email;
  final String token;

  // Constructor
  User({this.id, this.username, this.email, this.token});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      username: json['username'] as String, 
      email: json['email'] as String, 
      token: json['token'] as String,
    );
  }

  // dynamic toJson() => {'username': username, 'email': email, 'password': password};

}
