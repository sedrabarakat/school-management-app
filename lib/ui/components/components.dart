import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:school_app/theme/colors.dart';
import 'package:simple_animations/multi_tween/multi_tween.dart';
import 'package:simple_animations/stateless_animation/play_animation.dart';

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


TextFormField def_chat_TextFromField({
  required TextInputType keyboardType,
  required TextEditingController controller,
  required FocusNode focusNode,
  GestureTapCallback? onTap,
  ValueChanged<String>? onChanged,
  ValueChanged<String>? onFieldSubmitted,
  FormFieldValidator? validator,
  Widget? prefixIcon,
  Widget? suffixIcon,
  bool obscureText = false,
  int maxLines = 6,
  minLines = 1,
  String label = 'Tap here to write ',
  TextStyle labelStyle = const TextStyle(),
  Color cursorColor =  Colors.blue,
  Color borderSideColor =  primaryColor2,
  Color focusedBorderColor = primaryColor2,
  Color fillColor = const Color.fromARGB(255, 236, 236, 237),
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled,
}) {
  return TextFormField(
    onTap: onTap,
    keyboardType: keyboardType,
    controller: controller,
    validator: validator,
    focusNode: focusNode,
    obscureText: obscureText,
    readOnly: false,
    onFieldSubmitted: onFieldSubmitted,
    onChanged: onChanged,
    minLines: minLines,
    maxLines: obscureText?1:maxLines,
    cursorColor: cursorColor,
    autovalidateMode: autovalidateMode,
    /*decoration: InputDecoration(
      border: InputBorder.none,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      labelText: label,
      labelStyle: labelStyle,
      fillColor: fillColor,
      filled: true,
    ),*/
    decoration: InputDecoration(
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      labelText: label,
      labelStyle: labelStyle,
      fillColor: fillColor,
      filled: true,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(35.0),
        borderSide: BorderSide(
          color: borderSideColor,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25.0),
        borderSide: const BorderSide(
          color: Colors.black,
          width: 2.0,
        ),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25.0),
        borderSide: const BorderSide(
          color: Colors.black,
          width: 1.5,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25.0),
        borderSide: const BorderSide(
          color: Colors.red,
          width: 1.5,
        ),
      ),
    ),
  );
}

//Animatation

enum AniProps { opacity, translateY }

class FadeAnimation extends StatelessWidget {
  final double delay;
  final Widget child;

  FadeAnimation(this.delay, this.child);

  @override
  Widget build(BuildContext context) {
    final tween = MultiTween<AniProps>()
      ..add(AniProps.opacity, Tween(begin: 0.0, end: 1.0))
      ..add(AniProps.translateY, Tween(begin: -30.0, end: 0.0), Duration(milliseconds: 500), Curves.easeOut);

    return PlayAnimation<MultiTweenValues<AniProps>>(
      delay: Duration(milliseconds: (500 * delay).round()),
      duration: tween.duration,
      tween: tween,
      child: child,
      builder: (context, child, animation) => Opacity(
        opacity: animation.get(AniProps.opacity),
        child: Transform.translate(
            offset: Offset(0, animation.get(AniProps.translateY)),
            child: child
        ),
      ),
    );
  }
}


//SPINKIT

Widget SpinKitApp(width){
  return SpinKitFadingCube(
    color: Colors.blueAccent,
    size: width*0.06,
  );
}


//TOASTTTT

void showToast ({
  required String text, required state,
}) => Fluttertoast.showToast(
  msg: text,
  toastLength: Toast.LENGTH_LONG,
  gravity: ToastGravity.BOTTOM,
  timeInSecForIosWeb: 5,
  //backgroundColor: chooseToastColor(state),

  textColor: Colors.black87,
  fontSize: 17.0,
);

enum ToastState { success, error, warning }

Color chooseToastColor(ToastState state) {
  Color color;
  switch (state) {
    case ToastState.success:
      color = Colors.green;
      break;
    case ToastState.error:
      color = Colors.red;
      break;
    case ToastState.warning:
      color = Colors.amber;
      break;
  }
  return color;
}