/*
var side_text=TextStyle(fontSize: 13,fontWeight: FontWeight.w500,
      color: Colors.grey.shade300);

*/

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'colors.dart';

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

BoxDecoration three_color_container({
  double borderradius=29,
  Color first_color=Colors.blue,
  Color sec_color=Colors.lightBlue,
  Color third_color=Colors.lightBlueAccent,
  bool with_shadow=true
}){
  return BoxDecoration(
    borderRadius: BorderRadius.circular(borderradius),
    gradient:  LinearGradient(
        begin: Alignment.bottomLeft,
        end: Alignment.topRight,
        colors: [third_color,first_color,sec_color,third_color,]
    ),
    boxShadow: [
      (with_shadow)?BoxShadow(
        color: Colors.grey.shade500,
        blurRadius: 13.0,
        spreadRadius: 3,
        offset: Offset(8, 10,),
      ):const BoxShadow(color: Colors.white,spreadRadius: 0)
    ],
  );
}

TextStyle normal_TextStyle({
  required width,
  Color color=Colors.white
}){
  return TextStyle(
    fontWeight: FontWeight.w500,fontSize: width/20,color: color,
    overflow: TextOverflow.ellipsis,
  );
}

var blue_gardinaeet= BoxDecoration(
  gradient: LinearGradient(
      colors: <Color>[
        Color.fromARGB(255, 18, 170, 225),
        Color.fromARGB(255, 11, 143, 252),
        Colors.blue,
        Colors.lightBlue,
        Color.fromARGB(255, 18, 170, 225),
        Colors.lightBlueAccent]),
);
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

TextStyle email_TextStyle({
  required width,
}){
  return TextStyle(
    fontWeight: FontWeight.w400,fontSize: width/28,color: Colors.grey.shade400,
    overflow: TextOverflow.ellipsis,
  );
}

