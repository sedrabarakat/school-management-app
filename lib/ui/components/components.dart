import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:school_app/theme/colors.dart';
import 'package:school_app/ui/screens/home.dart';

import '../../cubit/home_cubit.dart';

IconButton circleiconbutton(width, iconColor, circleColor, icon, Function) {
  return IconButton(
    iconSize: width * 0.07,
    icon: CircleAvatar(
      radius: width * 0.09,
      backgroundColor: circleColor,
      child: Icon(
        icon,
        color: iconColor,
      ),
    ),
    onPressed: Function,
  );
}

Widget RowText({text1, text2, width}) {
  return Row(
    children: <Widget>[
      Text(
        text1,
        style: TextStyle(
            color: Color.fromARGB(255, 209, 193, 193),
            fontSize: width * 0.045,
            fontWeight: FontWeight.w700),
      ),
      SizedBox(
        width: width * 0.03,
      ),
      Text(
        text2,
        style: TextStyle(color: Colors.white, fontSize: width * 0.04),
      )
    ],
  );
}

Widget RowIcon({icon, text, width, sufix, context, rout}) {
  return InkWell(
    onTap: () {
      if (text == 'Switch Accounts')
        HomeCubit.get(context).ChangeShowaccounts();
     else  Navigator.of(context).pushNamed('/$rout');
     
    },
    child: Row(
      children: <Widget>[
        Icon(
          icon,
          color: iconColor,
        ),
        SizedBox(
          width: width * 0.04,
        ),
        Text(
          text,
          style: TextStyle(
              color: Colors.white,
              fontSize: width * 0.05,
              fontWeight: FontWeight.w500),
        ),
        Icon(
          sufix,
          color: iconColor,
          size: width * 0.1,
        ),
      ],
    ),
  );
}

CircleAvatar logo(height, width) {
  return CircleAvatar(
    radius: width * 0.17,
    backgroundColor: Colors.white,
    child: Image.asset(
      // height: height * 0.5,
      'assets/home/logo.png',
      //fit: BoxFit.fill,
    ),
  );
}
