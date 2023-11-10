import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:school_app/constants.dart';
import 'package:school_app/cubit/marks/marks_cubit.dart';

Widget buildMarkTypeCard(double height, double width, int type_id,
    String markTypeName, IconData iconDataMark, MarksCubit cubit, context) {
  return InkWell(
    onTap: () {
      cubit.changeCatIndexGuest(type_id);
      cubit.getMarksWithType(user_id: 3, type_id: type_id);
    },
    child: Container(
      width: width * 0.3,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: type_id == cubit.markTypeIndex
            ? RadialGradient(radius: 1, colors: [
                Color(0xFF43A5F4),
                Color(0XFF0287D0),
              ])
            : RadialGradient(radius: 10, colors: [
                Color(0xFF1C76D1),
                Color(0XFF0287D0),
              ]),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            iconDataMark,
            size: 50.sp,
            color: Colors.white,
          ),
          SizedBox(
            height: height * 0.01,
          ),
          Text(
            markTypeName,
            style: TextStyle(
                color: Colors.white,
                fontSize: 45.sp,
                fontWeight: FontWeight.bold),
          )
        ],
      ),
    ),
  );
}

Widget buildMarkCard(double height, double width, String markName,
    String studentMark, String maxMark, String dateString, context) {
  DateTime date = DateTime.parse(dateString);

  String formattedDay = DateFormat.E().format(date).substring(0, 3);
  int dayNumber = date.day;

  return Container(
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
          width: width * 0.2,
          height: height * 0.1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                formattedDay,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 40.sp,
                    color: Color(0xFF99CEF9)),
              ),
              SizedBox(
                height: height * 0.01,
              ),
              Text(
                dayNumber.toString(),
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 40.sp,
                    color: Color(0xFF99CEF9)),
              ),
            ],
          ),
        ),
        SizedBox(
          width: width * 0.01,
        ),
        Text(
          markName,
          style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 40.sp,
              color: Colors.blueAccent),
        ),
        SizedBox(
          width: width * 0.05,
        ),
        Text(
          '${studentMark}/${maxMark}',
          style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 40.sp,
              color: Colors.blueAccent),
        ),
      ],
    ),
  );
}


Widget markImage (height,width) {

  return Image.asset(
    'assets/images/marks/marks.png',
    fit: BoxFit.fill,
    height: height * 0.1,
    width: width * 0.25,
    color: Colors.blueAccent,
  );

}

