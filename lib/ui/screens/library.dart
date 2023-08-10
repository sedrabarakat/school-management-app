import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:school_app/ui/components/components.dart';

import '../../cubit/library/library_cubit.dart';
import '../../cubit/library/library_states.dart';

class Library extends StatelessWidget {
  const Library({super.key});
 //Color.fromARGB(255, 241, 246, 252)
  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (BuildContext context)=>Library_cubit()..Get_Books(),
      child: BlocConsumer<Library_cubit,Library_state>(
        listener: (context,state){},
        builder: (context,state){
          Library_cubit cubit=Library_cubit.get(context);
          List<dynamic>book_list=cubit.Books_list;
          return Scaffold(
            backgroundColor:Color.fromARGB(255, 233, 242, 253),
            body: Column(
              children: [
                Padding(
                  padding:  EdgeInsets.only(top: height/20),
                  child: ClipPath(
                    clipper: OvalBottomBorderClipper(),
                    child: Container(height: height/3,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Color.fromARGB(255, 241, 246, 252),
                            )
                        ),
                        child:Image.asset('assets/image/Education (3).jpeg',
                          width: width,height: height,
                          fit: BoxFit.fill,)),
                  ),
                ),
                Expanded(
                    child: ConditionalBuilder(
                      condition: book_list.isNotEmpty,
                      builder: (context)=>ListView.separated(
                          padding: EdgeInsets.only(top: height/30),
                          physics:BouncingScrollPhysics() ,
                          shrinkWrap: true,
                          itemBuilder: (context,index)=>Library_Cell(
                              height: height,width: width,context: context,
                              item:book_list[index]
                          ),
                          separatorBuilder: (context,index)=>SizedBox(),
                          itemCount: book_list.length),
                      fallback: (context)=>Container(),
                    ))
              ],)
          );
        },
      ),
    );
  }
}


Widget Library_Cell({
  required double height,
  required double width,
  required BuildContext context,
  required Map<dynamic,dynamic> item
}){
  return Padding(
    padding:  EdgeInsets.only(left: width/12,right: width/12,bottom:  height/30),
    child: Container(
      height: height/5.5,
      decoration: BoxDecoration(
          color:   Colors.white70,//Color.fromARGB(255, 128, 196, 231),
        borderRadius: BorderRadius.circular(25)
      ),
      child: Row(children: [
         small_book(width: width, height: height, ImagePath: item['img']),
         Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
          Padding(
            padding:  EdgeInsets.only(left: width/15,top: height/28,),
            child: SizedBox(
              width: width/2.3,
              child: Text('${item['name']}',
                maxLines: 1,
                style: TextStyle(
                overflow: TextOverflow.ellipsis,
                fontWeight: FontWeight.bold,
                  fontSize: width/20,
                  color: Colors.lightBlue
              ),),
            ),
          ),
             Padding(
               padding: EdgeInsets.only(left: width/15
                   ,top: height/70),
               child: Text((item['is_available']==1)?'is available':'is Unavailable',
                 maxLines: 1,
                 style: TextStyle(
                     overflow: TextOverflow.ellipsis,
                     fontWeight: FontWeight.bold,
                     fontSize: width/27,
                     color: (item['is_available']==1)?Colors.lightBlueAccent:
                     Colors.red.shade800
                 ),),
             ),
          Padding(
            padding:  EdgeInsets.only(left: width/3.5,top: height/100),
            child: elevatedbutton(Function: (){
              if(item['is_available']==1){
              Library_cubit.get(context).Booked(
                  book_id: item['id'],
                  student_id: 1);
              Library_cubit.get(context).Get_Books();}
            }, widthSize: width/3.9,
                borderRadius: 80,
                backgroundColor:(item['is_available']==1)?Color.fromARGB(255, 49, 163, 255):
                Color.fromARGB(255, 0, 79, 180),
                heightSize:  width/20,
              text:( item['is_available']==1)?'Reserve':'Can\'t reserve',
            ),
          )
        ],)
      ],),
    ),
  );
}


Widget small_book({
  required double width,
  required double height,
  required var ImagePath
}){
  return Transform.rotate(
    angle: -45.0,
    child: Container(
        clipBehavior: Clip.hardEdge,
        alignment: Alignment.topCenter,
        height: height/10,width: width/4,
        decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(
                color: Color.fromARGB(255, 0, 40, 72),
                width: 5.0,
              ),
              left: BorderSide(
                color: Colors.white24,
                width: 8.0,
              ),
            ),
            color: Color.fromARGB(255, 0, 80, 180),
           /* boxShadow: [
              BoxShadow(
                color: Colors.grey.shade100,
                blurRadius: 10.0,
                spreadRadius: 1,
                offset: Offset(8, 10,),
              ),
              BoxShadow(
                  color: Colors.lightBlue.shade100,
                  blurRadius: 10.0,
                  spreadRadius: 1,
                  offset: Offset(1, 7)
              )
            ]*/
        ),
        child: (ImagePath!=null)?
        Container(
            height: height/15,width: width/5,
            child: RotatedBox(
              quarterTurns: 1,
            child: CachedNetworkImage(
              imageUrl: ImagePath,
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  CircularProgressIndicator(value: downloadProgress.progress),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
            )
        ):
        Container(
            height: height/10,width: width/4,
            child: RotatedBox(
              quarterTurns: 1,
              child: Image.asset(
                "assets/image/book.jpg",
                fit: BoxFit.fill,
              ),
            )
        )
    ),
  );
}