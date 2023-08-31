

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school_app/constants.dart';

Widget teacherSubjects(width,height,int gradeNumber,String subjectName) {
  return Container(
    width: width * 0.6,
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(
          color: Color(0xFF1C76D1),
          width: 1
      ),
      borderRadius: BorderRadius.circular(15),
    ),
    padding: EdgeInsets.symmetric(
        horizontal: width * 0.01,
        vertical: height * 0.02),
    child: Column(
      mainAxisAlignment:
      MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment:
          MainAxisAlignment.center,
          children: [
            Text(
              'Class: ',
              style: TextStyle(
                  color: Color(0xFF64B5F5),
                  fontWeight: FontWeight.w400,
                  fontSize: 45.sp),
            ),
            Text(
              '${Mapclasses[gradeNumber]}',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 45.sp),
            ),
          ],
        ),
        SizedBox(
          height: height * 0.03,
        ),
        Text(
          subjectName,
          style: TextStyle(
              color: Color(0xFF1C76D1),
              fontWeight: FontWeight.w600,
              fontSize: 55.sp),
        ),
      ],
    ),
  );
}