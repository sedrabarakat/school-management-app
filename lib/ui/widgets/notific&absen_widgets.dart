import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:school_app/theme/colors.dart';

Widget absencesImage (height,width) {

  return Image.asset(
    'assets/images/notific/absen.png',
    fit: BoxFit.fill,
    height: height * 0.1,
    width: width * 0.21,
    color: Colors.blueAccent,
  );

}


Widget buildAbsencesCard(double height, double width, String name,String dateString, String dataGood, context) {
  DateTime date = DateTime.parse(dateString);

  String formattedDay = DateFormat.E().format(date).substring(0, 3);
  int dayNumber = date.day;

  return Stack(
    alignment: Alignment.topRight,
    children:[
      Container(
      padding: EdgeInsets.symmetric(horizontal: width * 0.05),
      height: height * 0.15,
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Color(0xFFF6FAFE)),
            width: width * 0.17,
            height: height * 0.08,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  formattedDay,
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 36.sp,
                      color: Color(0xFF99CEF9)),
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                Text(
                  dayNumber.toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 36.sp,
                      color: Color(0xFF99CEF9)),
                ),
              ],
            ),
          ),
          SizedBox(
            width: width * 0.02,
          ),
          Expanded(
            child: Row(
              children:[
                Expanded(
                  child: Text(
                    'Student ${name} was Absent!',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 36.sp,
                        color: Colors.blueAccent),
                  ),
                ),
                SizedBox(width: width*0.01,),
                Icon(Icons.check_box_outlined,color: Colors.blue,size: 45.sp,)
              ]
            ),
          ),

        ],
      ),
    ),
      Container(
        width: width*0.3,
        height: height*0.025,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
              color: Colors.blue
          ),
        ),
        child: Center(child: Text('${dataGood}',style: TextStyle(color: Colors.white,fontSize: 32.sp,fontWeight: FontWeight.w600),)),
      )
    ],
  );
}


Widget buildNotificationsCard(double height, double width, String dateString,String title, String body,String sender, context) {
  final outputFormat = DateFormat('yyyy-MM-dd HH');

  String outputDatetimeString = outputFormat.format(
    DateFormat('yyyy-MM-dd HH:mm:ss').parse(dateString),
  );

  return Stack(
    alignment: Alignment.topLeft,
    children: [
      Container(
        padding: EdgeInsets.symmetric(
            horizontal: width * 0.04, vertical: height * 0.02),
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
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  outputDatetimeString,
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 28.sp,
                      color: Colors.grey),
                ),
              ],
            ),
            SizedBox(
              height: height * 0.04,
            ),
            Text(
              '${title}',
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 38.sp,
                  color: Colors.blue),
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(
              height: height * 0.025,
            ),
            Text(
              '${body}',
              style: TextStyle(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.black),
              textAlign: TextAlign.start,
            ),
            SizedBox(
              height: height * 0.03,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(Icons.arrow_forward,size: 35.sp,color: Colors.blue,),
                Text(
                  'From ${sender}',
                  style: TextStyle(
                      fontSize: 25.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.blue),
                  textAlign: TextAlign.start,
                ),
              ],
            )
          ],
        ),
      ),
      Container(
        width: width*0.1,
        height: height*0.05,
        decoration: BoxDecoration(
          color: Colors.purple,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Center(
          child: Icon(Icons.notification_add,size: 40.sp,color: Colors.white,),
        ),
      ),
    ],
  );
}