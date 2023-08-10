import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../theme/styles.dart';

Widget animation_column({
  required double height,
  required double width,
  required List<Widget> children,
  int speed=500,
  double horizontalOffset=200.0
}){
  return AnimationLimiter(
    child: Column(
      children: AnimationConfiguration.toStaggeredList(
        duration: Duration(milliseconds: speed),
        childAnimationBuilder: (widget) => SlideAnimation(
          horizontalOffset:horizontalOffset,
          child: FadeInAnimation(
            child: widget,
          ),
        ),
        children:children,
      ),
    ),
  );
}


Widget days_container({
  required double height,
  required double width,
  required String day,
}){
  return Padding(
    padding: EdgeInsets.only(bottom: height/25,left: width/30),
    child: Container(
      height: height/10,
      width: width/3,
      decoration: three_color_container(borderradius: 15),
      child: Center(child: Text('$day',style:normal_TextStyle(width: width),)),
    ),
  );
}

Widget sch_container({
  required double height,
  required double width,
  required String Subject,
}){
  return Padding(
    padding: EdgeInsets.only(
        top: height/25, left: width/15
    ),
    child: Container(
      padding: EdgeInsets.all(height/100),
      height: height/10,
      width: width/20,
      decoration: BoxDecoration(
          color: Colors.white,
          border:Border.all(
            color: Colors.lightBlue,width: 4,
          ),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [BoxShadow(
            color: Colors.grey.shade400,
            blurRadius: 13.0,
            spreadRadius: 3,
            offset: Offset(8, 10,),
          )]
      ),
      child: Center(child: Text('$Subject',style:normal_TextStyle(width: width,
          color: Colors.lightBlue),)),
    ),
  );
}

