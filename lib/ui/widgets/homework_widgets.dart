import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:school_app/cubit/homeworks/homework_cubit.dart';

Widget buildHomeworkCard(double height, double width, String name,
    String subject, String body, String dateString, String file, context , HomeworkCubit cubit) {
  final outputFormat = DateFormat('yyyy-MM-dd HH');

  String outputDatetimeString = outputFormat.format(
    DateFormat('yyyy-MM-dd HH:mm:ss').parse(dateString),
  );

  return Column(
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      Container(
        padding: EdgeInsets.symmetric(
            horizontal: width * 0.04, vertical: height * 0.015),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 3),
              color: Colors.blueAccent.withOpacity(0.3),
              blurRadius: 5,
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: Text(
                  '${subject}',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 50.sp,
                      color: Colors.blue,letterSpacing: 1.5),
                  overflow: TextOverflow.ellipsis,
                ),),
                Text(
                  outputDatetimeString,
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 25.sp,
                      color: Colors.grey),
                ),
              ],
            ),
            SizedBox(
              height: height * 0.005,
            ),
            Text(
              '${name}',
              style: TextStyle(
                  fontSize: 25.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey),
              textAlign: TextAlign.start,
            ),
            SizedBox(
              height: height * 0.03,
            ),
            Text(
              'Homework Text',
              style: TextStyle(
                  fontSize: 30.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.blueAccent,
              ),
              textAlign: TextAlign.start,
            ),
            SizedBox(
              height: height * 0.01,
            ),
            Text(
              '${body}',
              style: TextStyle(
                  fontSize: 25.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.black),
              maxLines: 10,
            )
          ],
        ),
      ),

      file != ''
          ? Container(
              height: height * 0.05,
              width: width * 0.3,
              child: ElevatedButton(
                child: Text(
                  'Download File',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: width * 0.032),
                ),
                onPressed: () {
                  cubit.downloadFile(file);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            )
          : Container(),
    ],
  );
}
