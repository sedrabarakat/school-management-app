
import 'package:flutter/material.dart';
import 'package:school_app/ui/screens/marks/marks.dart';

/*void signOut(context)
{


  //PublicChatsCubit.get(context).close1();

  CacheHelper.signOut(key: 'token').then((value)
  {
    if(value)
    {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) =>   LoginScreen(),),
              (route) => false);
    }
  });


}*/


final Map<int, String> Mapclasses = {
  1: 'First Grade',
  2: 'Second Grade',
  3: 'Third Grade',
  4: 'Fourth Grade',
  5: 'Fifth Grade',
  6: 'Sixth Grade',
  7: 'Seventh Grade',
  8: 'Eighth Grade',
  9: 'Ninth Grade',
  10: 'Tenth Grade',
  11: 'Eleventh Grade',
  12: 'Bachelor Grade',
};


final List<MarksType> marksType = [
  MarksType(0,Icons.quiz_outlined,'Quiz'),
  MarksType(1,Icons.newspaper,'Exam 1'),
  MarksType(2,Icons.quiz_outlined,'Exam 2'),
  MarksType(3,Icons.quiz_outlined,'Mid'),
  MarksType(4,Icons.quiz_outlined,'Final'),
];


var token;
var user_id;
var isteacher;
var isparent;

var fcmToken;
var isonboarding;
