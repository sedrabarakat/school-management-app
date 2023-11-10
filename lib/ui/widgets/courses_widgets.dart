import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school_app/cubit/courses/courses_cubit.dart';
import 'package:school_app/ui/components/components.dart';

import '../../constants.dart';

Widget sessionImage(height,width) {
  return Image.asset('assets/images/courses/seminar.png',height: height*0.1,width: width*0.1,color: Colors.blueAccent,);
}

Widget Session_Card(double height, double width, BuildContext context, CoursesCubit cubit, String teacher_name,
    String subject, String body,int price, String date, int current_booked, int maximum_students,int Session_id,
{required bool is_All_Session}) {

  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Container(
        padding: EdgeInsets.symmetric(
            horizontal: width * 0.04, vertical: height * 0.015),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
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
                    'Teacher: ${teacher_name}',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 35.sp,
                        color: Colors.blue,letterSpacing: 0.5),
                    overflow: TextOverflow.ellipsis,
                  ),),
                Text(
                  date,
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 25.sp,
                      color: Colors.grey),
                ),
              ],
            ),
            SizedBox(
              height: height * 0.03,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'Subject: ${subject}',
                    style: TextStyle(
                        fontSize: 35.sp,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF91CAF7),),
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  '${price}\$',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 45.sp,
                      color: Colors.blue),
                ),
              ],
            ),
            SizedBox(
              height: height * 0.03,
            ),
            Text(
              '${body}',
              style: TextStyle(
                  fontSize: 30.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.black),
              maxLines: 10,
            ),
            Padding(
              padding:  EdgeInsets.only(left: is_All_Session?width/1.6: width/1.7),
              child: elevatedbutton(
                  Function: (){
                    if(is_All_Session){
                      cubit.Book_Session(
                          student_id: isparent ? childId : user_id,
                          session_id: Session_id);
                      cubit.get_session(student_id: isparent ? childId : user_id);
                    }
                    else{
                      cubit.UnBook_Session(student_id: isparent ? childId : user_id,
                          session_id: Session_id);
                      cubit.get_My_Sessions(student_id: isparent ? childId : user_id);
                    }

                  },
                  widthSize: is_All_Session?width/6:width/5,
                  borderRadius: 20,
                  heightSize: height/20, text: is_All_Session?'Book':'Unbook'),
            )
          ],
        ),
      ),
      Container(
        padding: EdgeInsets.symmetric(horizontal: width*0.04,vertical: height*0.005),
        width: width*0.3,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(12.0),
              bottomLeft: Radius.circular(12.0)),        ),
        child: Center(
          child: Text(
            '${current_booked}/${maximum_students}',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 35.sp),
          ),
        ),
      )
    ],
  );
}



