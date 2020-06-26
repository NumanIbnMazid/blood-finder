import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget appTitle(context) {
  return RichText(
    textAlign: TextAlign.center,
    text: TextSpan(
        text: 'Blood',
        style: GoogleFonts.portLligatSans(
          textStyle: Theme.of(context).textTheme.headline4,
          fontSize: 30,
          fontWeight: FontWeight.w700,
          color: Colors.redAccent[700],
        ),
        children: [
          TextSpan(
            text: 'Finder',
            style: TextStyle(color: Colors.black, fontSize: 30),
          ),
        ]),
  );
}
