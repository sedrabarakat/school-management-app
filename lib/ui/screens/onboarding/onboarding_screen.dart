import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:school_app/cubit/onboarding_screens/onboarding_cubit.dart';
import 'package:school_app/network/local/cash_helper.dart';
import 'package:school_app/theme/colors.dart';

class OnboardingScreen extends StatelessWidget {
  OnboardingScreen({Key? key}) : super(key: key);

  PageController controller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    var cubit = OnboardingCubit.get(context);

    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: width * 0.7),
                child: TextButton(
                  onPressed: () {
                    controller.animateToPage(
                      2,
                      duration: Duration(milliseconds: 400),
                      curve: Curves.easeInOut,
                    );
                  },
                  child: Text(
                    'Skip',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: width * 0.04,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.06,
              ),
              Expanded(
                child: PageView.builder(
                  controller: controller,
                  itemCount: contents.length,
                  onPageChanged: (int index) {
                    cubit.changeOnboaringIndictor(index);
                  },
                  itemBuilder: (_, i) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: width * 0.1, vertical: height * 0.04),
                      child: Column(
                        children: [
                        Image.asset(contents[i].ImageURL,height: height*0.25,width:width*0.75 , fit: BoxFit.fill,),
                          BlocBuilder<OnboardingCubit, OnboardingState>(
                            builder: (context, state) {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: contents.asMap().entries.map((entry) {
                                  final index = entry.key;
                                  return Container(
                                    width: 8.0,
                                    height: 8.0,
                                    margin: EdgeInsets.symmetric(
                                        vertical: height * 0.015,
                                        horizontal: width * 0.01),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: cubit.current == index
                                            ? Color(0xFF7395B5)
                                            : Color(0xFFF5F5F5)),
                                  );
                                }).toList(),
                              );
                            },
                          ),
                          SizedBox(
                            height: height * 0.07,
                          ),
                          Text(
                            contents[i].title,
                            style: TextStyle(
                                fontSize: width * 0.06,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          ),
                          SizedBox(height: height * 0.04),
                          Text(
                            contents[i].description,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: width * 0.04,
                              color: Colors.grey,
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
              BlocBuilder<OnboardingCubit, OnboardingState>(
                builder: (context, state) {
                  return cubit.current == 0
                      ? Container(
                    height: height * 0.07,
                    margin: EdgeInsets.symmetric(
                        horizontal: width * 0.025,
                        vertical: height * 0.05),
                    width: double.infinity,
                    child: ElevatedButton(
                      child: Text(
                        'Next',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: width * 0.032),
                      ),
                      onPressed: () {
                        controller.nextPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: nextColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  )
                      : Row(

                    children: [
                      Container(
                        height: height * 0.07,
                        margin: EdgeInsets.symmetric(
                            horizontal: width * 0.025,
                            vertical: height * 0.05),
                        width: width * 0.45,
                        child: ElevatedButton(
                          child: Text(
                            'Back',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: width * 0.032),
                          ),
                          onPressed: () {
                            controller.previousPage(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: backColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: height * 0.07,
                        margin: EdgeInsets.symmetric(
                            horizontal: width * 0.025,
                            vertical: height * 0.05),
                        width: width * 0.45,
                        child: ElevatedButton(
                          child: Text(cubit.current == contents.length - 1
                              ? "Go"
                              : "Next"),
                          onPressed: () {
                            if (cubit.current == contents.length - 1) {
                              CacheHelper.saveData(key: 'isonboarding', value: true).then((value) {
                                if (value) {
                                  Navigator.of(context).pushReplacementNamed('/login');
                                }
                              });
                            }
                            controller.nextPage(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: nextColor,
                            //textStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.w500, fontFamily: 'IBM Plex Sans',fontSize: width*0.032),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      )
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  PageDecoration getPageDecoration() {
    return const PageDecoration(
      titleTextStyle: TextStyle(
          fontSize: 60,
          fontWeight: FontWeight.w600,
          fontFamily: 'Pacifico',
          color: Colors.black),
      bodyTextStyle: TextStyle(fontSize: 20, color: Colors.black),
      imagePadding: EdgeInsets.all(24),
      titlePadding: EdgeInsets.zero,
      bodyPadding: EdgeInsets.all(24),
      //pageColor: primaryGradient,
    );
  }

  DotsDecorator getDotDecoration() {
    return DotsDecorator(
        color: Colors.black,
        size: const Size(10, 10),
        activeSize: const Size(22, 10),
        activeColor: Colors.greenAccent,
        activeShape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)));
  }
}

class Onboarding {
  final int id;
  final String title;
  final String ImageURL;
  final String description;

  Onboarding(this.id, this.title, this.ImageURL, this.description);
}

List<Onboarding> contents = [
  Onboarding(0, 'Your Academic Journey Starts Here', 'assets/image/school bus.gif',
      'Welcome to our school app! This is your gateway to an enriching academic experience. View your profile, track your results, and stay updated with your academic progress.'),
  Onboarding(1, 'Stay on Track, Stay Ahead', 'assets/image/Kids Studying from Home.gif',
      'We understand the importance of staying organized. Access your marks, assignments, and homework in one place. Receive real-time notifications to stay on top of important updates.'),
  Onboarding(
      2,
      'Discover Insights Beyond the Classroom',
      'assets/image/Knowledge.gif',
      "The library's treasures are now digital. Expand your horizons with our curated articles. Ask questions, seek guidance, and foster your learning journey through interactive conversations."),
];
