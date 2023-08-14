import 'package:flutter/material.dart';
import 'package:school_app/network/local/cash_helper.dart';

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
String ?token = '2|JFjfB8ARHdl8ZREXoqVQq6n3HgEZDGcLc1Pnu6gY';
var user_id;
bool isteacher = false;
bool isparent = true;
