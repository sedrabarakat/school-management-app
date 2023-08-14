
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_app/cubit/auth_cubit.dart';
import 'package:school_app/theme/colors.dart';
import 'package:school_app/theme/styles.dart';
import 'package:school_app/ui/components/components.dart';
import 'package:school_app/ui/screens/login.dart';
import 'package:sensors_plus/sensors_plus.dart';


//Wave
Widget Wave(width){
  return CustomPaint(
    size: Size(width, (width * 1.1).toDouble()),
    painter: RPSCustomPainter(),
  );
}

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint0 = Paint()
      ..color =  basicColor
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;

    Path path0 = Path();
    path0.moveTo(0, 0);
    path0.lineTo(0, size.height * 0.7155556);
    path0.quadraticBezierTo(size.width * 0.0391667, size.height * 0.7272222,
        size.width * 0.1166667, size.height * 0.8000000);

    path0.cubicTo(
        size.width * 0.6420833,
        size.height * 1.3350000,
        size.width * 0.8204167,
        size.height * 0.3816667,
        size.width,
        size.height * 0.3222222);
    path0.quadraticBezierTo(
        size.width * 1.0108333, size.height * 0.2416667, size.width, 0);

    canvas.drawPath(path0, paint0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

///////////////////////////////////////////////
//Logo
Widget Logo(width){
  return FadeAnimation(
    1,
    Image.asset(
      'assets/home/logo.png',
      width: width * 0.9,
    ),
  );
}

/////////////////////////////////////
//White Container

Widget WhiteContainer(context,width,height,cubit,emailController,passwordController,emailFocusNode,passwordFocusNode,formkey){


  double posX = 0, posY = -60;

  double minPosX = -10;
  double maxPosX = 10;
  double minPosY = -70;
  double maxPosY = -50;

  return StreamBuilder<GyroscopeEvent>(
    stream: SensorsPlatform.instance.gyroscopeEvents,
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        posX = posX + (snapshot.data!.y * 1.5);
        posY = posY + (snapshot.data!.x * 1.5);

        // Limit posX within the range
        posX = posX.clamp(minPosX, maxPosX);

        // Limit posY within the range
        posY = posY.clamp(minPosY, maxPosY);

      }
      return Transform.translate(
        offset: Offset(posX, posY),
        child: Container(
          height: height * 0.5,
          width: width * 0.85,
          padding: EdgeInsets.symmetric(
              horizontal: width * 0.04, vertical: height * 0.04),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 4),
                color: shadow.withOpacity(0.7),
                blurRadius: 5,
              )
            ],
          ),
          child: Form(
            key: formkey,
            child: BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                        'Login Here',
                        style: titleStyle(width)

                    ),
                    SizedBox(
                      height: height * 0.05,
                    ),
                    EmailTextFormField(context, emailController, emailFocusNode, passwordFocusNode),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    PasswordTextFormField(cubit, passwordController, passwordFocusNode),
                    SizedBox(
                      height: height * 0.036,
                    ),
                    Button(height, width, formkey, emailController, passwordController, cubit),
                  ],
                );
              },
            ),
          ),
        ),
      );
    },
  );

}

/////////////////////////////////////

Widget EmailTextFormField(context,emailController,emailFocusNode,passwordFocusNode){
  return FadeAnimation(
    1.1,
    def_chat_TextFromField(
      cursorColor: Colors.blueAccent,
      focusNode: emailFocusNode,
      onFieldSubmitted: (val) {
        FocusScope.of(context)
            .requestFocus(passwordFocusNode);
      },
      keyboardType: TextInputType.emailAddress,
      controller: emailController,
      autovalidateMode:
      AutovalidateMode.onUserInteraction,
      label: 'Enter Email',
      labelStyle: const TextStyle(
        color: Colors.black87,
      ),
      prefixIcon: Icon(
        Icons.email,
        color: basicColor,
      ),
      validator: (value) {
        if (!EmailValidator.validate(value!)) {
          return 'Please enter a valid Email';
        }
        return null;
      },
    ),
  );
}

Widget PasswordTextFormField(cubit,passwordController,passwordFocusNode){

  return FadeAnimation(
    1.2,
    def_chat_TextFromField(
      cursorColor: Colors.blueAccent,
      focusNode: passwordFocusNode,
      keyboardType: TextInputType.emailAddress,
      controller: passwordController,
      obscureText: cubit.isPassword,
      autovalidateMode:
      AutovalidateMode.onUserInteraction,
      label: 'Enter Password',
      labelStyle: const TextStyle(
        color: Colors.black87,
      ),
      prefixIcon: const Icon(
        Icons.lock,
        color: basicColor,
      ),
      suffixIcon: IconButton(
        onPressed: () {
          cubit.changePasswordVisibility();
        },
        icon: Icon(
          cubit.suffix,
          color: basicColor,
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter your Password';
        }
        return null;
      },
    ),
  );

}

Widget Button(height,width,formkey,emailController,passwordController,AuthCubit cubit){
  return ConditionalBuilder(
      condition: !cubit.isAnimated,
      builder: (context) => AnimatedContainer(
        duration:
        const Duration(milliseconds: 800),
        curve: Curves.easeIn,
        onEnd: () {
          cubit.login(
              email: emailController.text,
              password: passwordController.text);
        },
        height: height * 0.06,
        width: width * cubit.ratioButtonWidth,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          gradient: primaryGradient,
          border: Border.all(
              color: Colors.blue
          ),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            // highlightColor: Colors.orange.withOpacity(0.3),
            splashColor: Colors.blue,
            borderRadius:
            BorderRadius.circular(30),
            onTap: () {
              if (formkey.currentState!
                  .validate()) {
                cubit.animateTheButton();
                //toast(text: 'Login Successfulyy');
              }
            },
            child: Row(
              mainAxisAlignment:
              MainAxisAlignment.center,
              children: [
                FittedBox(
                  child: Text(
                    'Login',
                    style: buttonTextStyle(width),
                  ),
                ),
                SizedBox(
                  width: width * 0.01,
                ),
                Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                  size: width*0.028,
                )
              ],
            ),
          ),
        ),
      ),
      fallback: (context) => SpinKitApp(width)
  );
}