/*
var side_text=TextStyle(fontSize: 13,fontWeight: FontWeight.w500,
      color: Colors.grey.shade300);

*/

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:school_app/theme/colors.dart';

BoxDecoration boxdecorationitem(
  color,
  double x,
  double y, {
  double circler = 20,
  double blurRadius = 2,
  double spreadRadius = 2,
  colorshado = const Color.fromARGB(66, 192, 37, 37),
}) {
  return BoxDecoration(
    borderRadius: BorderRadius.circular(circler),
    color: color,
    boxShadow: [
      BoxShadow(
        offset: Offset(x, y),
        blurRadius: blurRadius,
        spreadRadius: spreadRadius,
        //color: color.withOpacity(0.5),
        color: colorshado,
      ),
    ],
  );
}

TextStyle mytextstyle(width) {
  return TextStyle(
    color: Color.fromARGB(255, 53, 53, 51),
    fontSize: width * 0.035,
    fontWeight: FontWeight.w700,
  );
}

TextStyle titleStyle(width) {
  return TextStyle(color: basicColor,
      fontSize: width * 0.07,
      fontWeight: FontWeight.bold
  );
}

TextStyle buttonTextStyle(width) {
  return TextStyle(
    color: Colors.white,
    fontSize: width * 0.04,
    fontWeight: FontWeight.bold,
  );
}