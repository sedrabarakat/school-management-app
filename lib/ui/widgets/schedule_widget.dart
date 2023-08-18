import 'package:flash/flash.dart';
import 'package:flash/flash_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:school_app/ui/widgets/chat_widgets.dart';

import '../../theme/styles.dart';

Widget animation_column({
  required double height,
  required double width,
  required List<Widget> children,
  int speed=500,
  double horizontalOffset=200.0
}){
  return AnimationLimiter(
    child: Column(
      children: AnimationConfiguration.toStaggeredList(
        duration: Duration(milliseconds: speed),
        childAnimationBuilder: (widget) => SlideAnimation(
          horizontalOffset:horizontalOffset,
          child: FadeInAnimation(
            child: widget,
          ),
        ),
        children:children,
      ),
    ),
  );
}


Widget days_container({
  required double height,
  required double width,
  required String day,
}){
  return Padding(
    padding: EdgeInsets.only(bottom: height/25,left: width/30),
    child: Container(
      height: height/10,
      width: width/3,
      decoration: three_color_container(borderradius: 15),
      child: Center(child: Text('$day',style:normal_TextStyle(width: width),)),
    ),
  );
}

Widget sch_container({
  required double height,
  required double width,
  required item
}){
  return Padding(
    padding: EdgeInsets.only(
        top: height/25, left: width/15
    ),
    child: Container(
      padding: EdgeInsets.all(height/100),
      height: height/10,
      width: width/20,
      decoration: BoxDecoration(
          color: Colors.white,
          border:Border.all(
            color: Colors.lightBlue,width: 4,
          ),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [BoxShadow(
            color: Colors.grey.shade400,
            blurRadius: 13.0,
            spreadRadius: 3,
            offset: Offset(8, 10,),
          )]
      ),
      child: Column(
       mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('${item['subject']}',style:normal_TextStyle(width: width,
              color: Colors.lightBlue),),
          SizedBox(height: height/70,),

          Text('${item['teacher']}',style:email_TextStyle(width: width,),),
        ],
      ),
    ),
  );
}

Widget Teacher_sch({
  required double width,
  required double height,
  required int length,
  required List<dynamic>hussas
}){
  return Expanded(
      child: ListView.separated(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context,index)=>teacher_cell(height: height,width: width,item: hussas[index]),
          separatorBuilder:  (context,index)=>SizedBox(),
          itemCount: length)
  );
}

teacher_cell({
  required double width,
  required double height,
  required Map<String,dynamic>item
}){
  return  Padding(
    padding: EdgeInsets.only(
        top: height/25, left: width/15
    ),
    child: Container(
      padding: EdgeInsets.all(height/100),
      height: height/5,
      width: width/3,
      decoration: BoxDecoration(
          color: Colors.white,
          border:Border.all(
            color: Colors.lightBlue,width: 4,
          ),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [BoxShadow(
            color: Colors.grey.shade400,
            blurRadius: 13.0,
            spreadRadius: 3,
            offset: Offset(8, 10,),
          )]
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          (item['subject']!=null)?Text('${item['subject']}',style:normal_TextStyle(width: width,
              color: Colors.lightBlue),):Text('Space'),
          (item['subject']!=null)?Text('class ${item['saf']}',style:email_TextStyle(width: width,),):SizedBox(),
          (item['subject']!=null)?Text('section ${item['section']}',style:email_TextStyle(width: width,),):SizedBox()
        ],
      ),
    ),
  );
}


/*
Widget sch_Teacher_container({
  required double height,
  required double width,
  required List<dynamic>item,
  required int index
}){
  return Padding(
    padding: EdgeInsets.only(
        top: height/25, left: width/15
    ),
    child: Container(
      padding: EdgeInsets.all(height/100),
      height: height/10,
      width: width/20,
      decoration: BoxDecoration(
          color: Colors.white,
          border:Border.all(
            color: Colors.lightBlue,width: 4,
          ),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [BoxShadow(
            color: Colors.grey.shade400,
            blurRadius: 13.0,
            spreadRadius: 3,
            offset: Offset(8, 10,),
          )]
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('${item['subject']}',style:normal_TextStyle(width: width,
              color: Colors.lightBlue),),
          SizedBox(height: height/70,),

          Text('${item['teacher']}',style:email_TextStyle(width: width,),),
        ],
      ),
    ),
  );
}
*/
Future show_Exam_image({
  required BuildContext context,
  required double width,
  required double height,
  required String url
}){
  return  context.showModalFlash(
      builder: (context, controller) => Flash(
        controller: controller,
        dismissDirections: FlashDismissDirection.values,
        slideAnimationCreator: (context, position, parent, curve, reverseCurve) {
          return controller.controller.drive(Tween(begin: Offset(0.1, 0.1), end: Offset.zero));
        },
        child:AlertDialog(
          scrollable: true,
          actionsPadding: EdgeInsets.zero,
          shadowColor: Colors.blue,
          title: Text("Exam photo",style: TextStyle(
              fontSize:width/15,color: Colors.blue
          ),),
          content: Container(
            height: height/4.3,width: width/1.2,
            child: Cashed_image(imageUrl: url)
          ),
          actions: [
            TextButton(
              onPressed: (){
                controller.dismiss();
              },
              child: Text('Cancel'),
            ),
          ],
        ),
      )
  );
}