import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:school_app/theme/colors.dart';
import 'package:school_app/theme/styles.dart';
import 'package:school_app/ui/screens/home.dart';
import 'package:school_app/ui/widgets/library%20widget.dart';

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

Widget RowIcon({icon, text, width, sufix,required BuildContext context, rout,
double ?height}) {
  return InkWell(
    onTap: () {
      if (text == 'Switch Accounts')
        HomeCubit.get(context).ChangeShowaccounts();
      if(rout=='contactus'){
        HomeCubit.get(context).ChangeDrawer(width, height).then((value){
        show_contact_us(context: context, width: width, height: height!);
        });
      }
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
var Contact_controller=TextEditingController();
Future show_contact_us({
  required BuildContext context,
  required double width,
  required double height
}){
  return  context.showModalFlash(
      builder: (context, controller) => Flash(
        controller: controller,
        dismissDirections: FlashDismissDirection.values,
        slideAnimationCreator: (context, position, parent, curve, reverseCurve) {
          return controller.controller.drive(Tween(begin: Offset(0.1, 0.1), end: Offset.zero));
        },
        child:AlertDialog(
          scrollable: true,
          actionsPadding: EdgeInsets.zero,
          shadowColor: Colors.blue,
          title: Text("Contact Us",style: TextStyle(
              fontSize:width/15,color: Colors.blue
          ),),
          content: Container(
            height: height/4.3,width: width/1.2,
            child: Column(
              children: [
                Text('Don\'t hesitate to tell us about any problem your'
                    ' complaint will directly go to the management',
                style: email_TextStyle(width: width),),
                SizedBox(height: height/30,),
                default_TextFromField(
                    width: width,
                    prefixcolor: Colors.blue,
                    prefixicon: Icons.text_snippet,
                    is_there_prefix: true,
                    height: height,
                    controller: Contact_controller,
                    keyboardtype: TextInputType.text,
                    hintText: 'Write Your Problem')
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed:(){
                Contact_controller.clear();
                controller.dismiss();
              },
              child: Text('Submit'),
            ),
            TextButton(
              onPressed: (){
                Contact_controller.clear();
                controller.dismiss();
              },
              child: Text('Cancel'),
            ),
          ],
        ),
      )
  );
}

Widget Top_Image({
  required double height,
  required double width,
  required String image_path
}){
  return ClipPath(
    clipper: OvalBottomBorderClipper(),
    child: Container(
        height: height/3.3,
        decoration: BoxDecoration(
            border: Border.all(
              color: Color.fromARGB(255, 241, 246, 252),
            )
        ),
        child:Image.asset('$image_path',
          width: width,height: height,
          fit: BoxFit.fill,)),
  );
}

TextFormField def_TextFromField({
  required TextInputType keyboardType,
  required TextEditingController controller,
  required FocusNode focusNode,
  GestureTapCallback? onTap,
  ValueChanged<String>? onChanged,
  ValueChanged<String>? onFieldSubmitted,
  FormFieldValidator? validator,
  Widget? prefixIcon,
  Widget? suffixIcon,
  int? maxLength,
  String? counterText = '',
  MaxLengthEnforcement? maxLengthEnforcement,
  bool obscureText = false,
  int maxLines = 1,
  int minLines = 1,
  String label = 'Tap here to write ',
  TextStyle labelStyle = const TextStyle(),
  Color cursorColor = Colors.blue,

  Color borderFocusedColor = primaryColor2,
  Color borderNormalColor = Colors.black,


  Color fillColor = const Color.fromARGB(255, 236, 236, 237),
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled,
  double br = 25.0,
}) {
  return TextFormField(
    onTap: onTap,
    maxLength: maxLength,
    maxLengthEnforcement:
    maxLengthEnforcement,
    keyboardType: keyboardType,
    controller: controller,
    validator: validator,
    focusNode: focusNode,
    obscureText: obscureText,
    readOnly: false,
    onFieldSubmitted: onFieldSubmitted,
    onChanged: onChanged,
    minLines: minLines,
    maxLines: obscureText ? 1 : maxLines,
    cursorColor: cursorColor,
    autovalidateMode: autovalidateMode,
    decoration: InputDecoration(
      counterText: counterText,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      labelText: label,
      labelStyle: labelStyle,
      fillColor: fillColor,
      filled: true,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(br),
        borderSide: BorderSide(
            color: borderFocusedColor,
            width: 2,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(br),
        borderSide:  BorderSide(
          color: borderNormalColor,
          width: 2,
        ),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(br),
        borderSide:  BorderSide(
          color: borderNormalColor,
          width: 1,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(br),
        borderSide: const BorderSide(
          color: Colors.red,
          width: 1.0,
        ),
      ),
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
  backgroundColor: chooseToastColor(state),

  textColor: Colors.black87,
  fontSize: 17.0,
);

enum ToastState { success, error, warning }

Color chooseToastColor(ToastState state) {
  Color color;
  switch (state) {
    case ToastState.success:
      color = Colors.blue;
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

