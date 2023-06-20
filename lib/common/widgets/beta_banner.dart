import 'package:flutter/material.dart';
import 'package:project_reunite/constants/export.dart';

Widget betaBanner() {
  return Container(
    height: 5,
    width: double.infinity,
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Colors.indigo,
          Colors.cyan,
          Colors.amber,
          Colors.deepPurple
        ]),
    ),
    // child: Text('App is in beta testing ⚠️',
    // textAlign: TextAlign.center,
    // style: GoogleFonts.robotoFlex(
    //   fontWeight: FontWeight.bold,
    //   letterSpacing: 1
    // ),),
  );
}

Widget betaBanner1() {
  return Container(
    height: 25 ,
    width: double.infinity,
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Colors.indigo,
          Colors.cyan,
          Colors.amber,
          Colors.deepPurple
        ]),
    ),
    child: Text('App still is in beta test ⚠️',
    textAlign: TextAlign.center,
    style: GoogleFonts.robotoFlex(
      fontWeight: FontWeight.bold,
      letterSpacing: 1,
      color: Colors.white,
    ),),
  );
}
