import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school_app/constants.dart';
import 'package:school_app/cubit/profile/profile_cubit.dart';
import 'package:school_app/theme/colors.dart';
import 'package:school_app/ui/components/components.dart';

class StudentProfile extends StatelessWidget {
  const StudentProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) => ProfileCubit()..getStudentProfile(student_id: 3),
      child: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          var cubit = ProfileCubit.get(context);

          if (state is ErrorGetStudentProfile) {
            showToast(
                text: 'Error in Getting Student Profile',
                state: chooseToastColor(ToastState.error));
          }
        },
        builder: (context, state) {
          var cubit = ProfileCubit.get(context);
          return Scaffold(
            backgroundColor: backgroundColor,
            appBar: null,
            body: ConditionalBuilder(
              condition: cubit.studentModel != null,
              builder: (context) => SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: height * 0.53,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                            Color(0XFF0287D0),
                            Color(0xFF1C76D1),
                          ]),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(50),
                            bottomRight: Radius.circular(50),
                          ),
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: width * 0.03, vertical: height * 0.02),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: Icon(
                                    Icons.arrow_back_outlined,
                                    color: Colors.white,
                                    size: 50.sp,
                                  ),
                                ),
                                SizedBox(
                                  width: width * 0.24,
                                ),
                                Text(
                                  'Profile',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 60.sp,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: height * 0.03,
                            ),
                            FadeAnimation(
                              1,
                              Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      border: Border.all(
                                          color: Colors.blue, width: 1),
                                      color: Colors.white),
                                  clipBehavior: Clip.hardEdge,
                                  width: width * 0.3,
                                  height: height * 0.15,
                                  child: CachedNetworkImage(
                                    fadeInCurve: Curves.easeIn,
                                    imageUrl: cubit
                                        .studentModel!.data!.studentData!.img!,
                                    imageBuilder: (context, imageProvider) =>
                                        CircleAvatar(
                                      backgroundImage: imageProvider,
                                    ),
                                    placeholder: (context, url) =>
                                        SpinKitApp(width),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                  )),
                            ),
                            SizedBox(
                              height: height * 0.01,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  cubit.studentModel!.data!.studentData!.name!,
                                  style: TextStyle(
                                      fontSize: 35.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                SizedBox(
                                  width: width * 0.02,
                                ),
                                cubit.studentModel!.data!.studentData!.gender ==
                                        'Male'
                                    ? Icon(
                                        Icons.male_outlined,
                                        size: 50.sp,
                                        color: Colors.blue,
                                      )
                                    : Icon(
                                        Icons.female_outlined,
                                        size: 50.sp,
                                        color: Colors.pink,
                                      ),
                              ],
                            ),
                            SizedBox(
                              height: height * 0.01,
                            ),
                            Text(
                              cubit.studentModel!.data!.studentData!.birthDate!,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 35.sp),
                            ),
                            SizedBox(
                              height: height * 0.018,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Class: ${Mapclasses[cubit.studentModel!.data!.studentData!.grade!]} | ',
                                  style: TextStyle(
                                      fontSize: 35.sp,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.white),
                                ),
                                SizedBox(
                                  width: width * 0.01,
                                ),
                                Text(
                                  'Section: ${cubit.studentModel!.data!.studentData!.sectionNumber!}',
                                  style: TextStyle(
                                      fontSize: 35.sp,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: height * 0.015,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.place_outlined,
                                  size: 35.sp,
                                  color: Colors.black,
                                ),
                                SizedBox(
                                  width: width * 0.02,
                                ),
                                Text(
                                  cubit.studentModel!.data!.studentData!
                                      .address!,
                                  style: TextStyle(
                                      fontSize: 35.sp,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.white54),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: height * 0.03,
                            ),
                            FadeAnimation(
                              1.2,SizedBox(
                                height: height * 0.06,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          cubit.studentModel!.data!.marksRate!
                                              .toStringAsFixed(2),
                                          style: TextStyle(
                                              fontSize: 45.sp,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                        SizedBox(
                                          height: height * 0.01,
                                        ),
                                        Text(
                                          'Marks Rate',
                                          style: TextStyle(
                                              fontSize: 25.sp,
                                              fontWeight: FontWeight.w300,
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                    VerticalDivider(
                                      color: Colors.white,
                                      width: width * 0.1,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          cubit.studentModel!.data!.absenceRate!
                                              .toStringAsFixed(2),
                                          style: TextStyle(
                                              fontSize: 45.sp,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                        SizedBox(
                                          height: height * 0.01,
                                        ),
                                        Text(
                                          'Absence Rate',
                                          style: TextStyle(
                                              fontSize: 25.sp,
                                              fontWeight: FontWeight.w300,
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: height * 0.05,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: width * 0.06),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Email',
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 35.sp),
                            ),
                            SizedBox(
                              height: height * 0.01,
                            ),
                            Text(
                              cubit.studentModel!.data!.studentData!.email!,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 40.sp),
                            ),
                            SizedBox(
                              height: height * 0.01,
                            ),
                            Divider(
                              thickness: 1,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              height: height * 0.01,
                            ),
                            Text(
                              'Phone Number',
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 35.sp),
                            ),
                            SizedBox(
                              height: height * 0.01,
                            ),
                            Text(
                              cubit.studentModel!.data!.studentData!
                                  .phoneNumber!,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 40.sp),
                            ),
                            SizedBox(
                              height: height * 0.01,
                            ),
                            Divider(
                              thickness: 1,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              height: height * 0.01,
                            ),
                            FadeAnimation(
                              1.2,Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    width: width * 0.4,
                                    height: height * 0.15,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          offset: const Offset(0, 3),
                                          color:
                                              Colors.blueAccent.withOpacity(0.3),
                                          blurRadius: 5,
                                        )
                                      ],
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: width * 0.01,
                                        vertical: height * 0.02),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Icon(
                                          Icons.bus_alert,
                                          size: 50.sp,
                                          color: Colors.blue,
                                        ),
                                        SizedBox(
                                          height: height * 0.01,
                                        ),
                                        Text(
                                          cubit.studentModel!.data!.studentData!
                                                      .isInBus! ==
                                                  1
                                              ? cubit.studentModel!.data!
                                                  .studentData!.leftForBus!
                                                  .toString()
                                              : 'Not Registered',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 40.sp),
                                        ),
                                        SizedBox(
                                          height: height * 0.01,
                                        ),
                                        Text(
                                          'Bus Installment',
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 35.sp),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: width * 0.4,
                                    height: height * 0.15,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          offset: const Offset(0, 3),
                                          color:
                                              Colors.blueAccent.withOpacity(0.3),
                                          blurRadius: 5,
                                        )
                                      ],
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: width * 0.01,
                                        vertical: height * 0.02),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Icon(
                                          Icons.monetization_on_outlined,
                                          size: 50.sp,
                                          color: Colors.blue,
                                        ),
                                        SizedBox(
                                          height: height * 0.01,
                                        ),
                                        Text(
                                          cubit.studentModel!.data!.studentData!
                                              .leftForQusat!
                                              .toString(),
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 40.sp),
                                        ),
                                        SizedBox(
                                          height: height * 0.01,
                                        ),
                                        Text(
                                          'Installment',
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 35.sp),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              fallback: (context) => SpinKitApp(width),
            ),
          );
        },
      ),
    );
  }
}
