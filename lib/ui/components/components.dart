import 'package:animated_text_kit/animated_text_kit.dart';
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
            fontWeight: FontWeight.w700,
            ),
      ),
      SizedBox(
        width: width * 0.03,
      ),
      Expanded(
        child: Text(
          text2,
          style: TextStyle(color: Colors.white, fontSize: width * 0.04),maxLines: 2,
                          overflow: TextOverflow.ellipsis,
        ),
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
          width: width * 0.03,
        ),
        Text(
          text,
          style: TextStyle(
              color: Colors.white,
              fontSize: width * 0.05,
              fontWeight: FontWeight.w500),maxLines: 1,
                          overflow: TextOverflow.ellipsis,
        ),
        Icon(
          sufix,
          color: iconColor,
          size: width * 0.08,
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

Widget Animated_Text({
  required double width,
  required String text,
  int speed=500,
  bool isRepeating=false,
  List<Color>colors_list= const [Colors.white,Colors.blue,
    Colors.lightBlue],
}){
  return AnimatedTextKit(
    isRepeatingAnimation: isRepeating,
    animatedTexts: [
      ColorizeAnimatedText(text,
          speed: Duration(milliseconds: speed),
          colors: colors_list,
          textStyle:
          TextStyle(fontWeight: FontWeight.bold,
            fontSize: width / 10,
            fontFamily: 'Bobbers',)),
    ],
  );
}


ElevatedButton elevatedbutton({
  required VoidCallback Function,
  required double widthSize,
  required double heightSize,
  required String text,
  Color textcolor=Colors.white,
  Color backgroundColor=Colors.lightBlue,
  Color  foregroundColor=Colors.white54,
  Color shadowColor=Colors.grey,
  double elevation=10,
  double borderRadius=10,
  // required double widthSize,
  //   required double heightSize,
}){
  return ElevatedButton(
    onPressed:Function,
    child: Text(text,
      style: TextStyle(color: textcolor),),
    style: ElevatedButton.styleFrom(
        elevation:elevation,
        fixedSize:Size(widthSize, heightSize),
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        shadowColor:shadowColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius)
        ),
        animationDuration: Duration(seconds: 100),
        splashFactory: InkSplash.splashFactory
    ),
  );
}

Widget circle_icon_button({
  required VoidCallback button_Function,
  required IconData icon,
  required String hint_message,
  Color icon_color=Colors.lightBlue,
  Color backgroundColor=const Color.fromARGB(255, 239, 244, 249),
  double radius=50
}){
  return Tooltip(
    waitDuration: Duration(milliseconds:500),
    message: hint_message,
    child: CircleAvatar(
        radius: radius,
        backgroundColor: backgroundColor,
        child: IconButton(onPressed: button_Function,icon: Icon(icon,color:icon_color,
        ),)
    ),
  );
}
