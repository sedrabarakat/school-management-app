import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_app/cubit/chat/chat_list/chat_list_cubit.dart';
import 'package:school_app/cubit/chat/chat_list/chat_list_states.dart';
import 'package:school_app/ui/widgets/library%20widget.dart';

import '../../../theme/styles.dart';
import '../../widgets/chat_widgets.dart';

class Chat_List extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    var height=MediaQuery.of(context).size.height;
    var width=MediaQuery.of(context).size.width;
    var Search_Controller=TextEditingController();
   return BlocConsumer<Chat_List_Cubit,Chat_List_States>(
       listener: (context,state){},
       builder: (context,state){
         Chat_List_Cubit cubit=Chat_List_Cubit.get(context);
     return Scaffold(
       appBar: AppBar(
         backgroundColor:Colors.lightBlue,
         elevation: 0,
       ),
      body: Container(
        width: width,height: height,
        child: Column(children: [
          Stack(
            children: [
              wavey_Container_One(height,width, Colors.lightBlue.withOpacity(.5)),
              wavey_Container_Two(height, width, Colors.lightBlue),
            ],),
          SizedBox(height: height/100,),
          Padding(
            padding:  EdgeInsets.symmetric(
              horizontal: width/20,
              vertical: height/100,
            ),
            child: default_TextFromField(
                bordercolor:Colors.lightBlue,
              borderWidth: 2.5,
              is_there_prefix: true,
              prefixcolor: Colors.lightBlue,
              prefixicon: Icons.search,
                borderRadius: 25,
                width: width, height: height,
                controller: Search_Controller, keyboardtype: TextInputType.text, hintText: 'Search'),
          ),
          ConditionalBuilder(
            condition: false,
            builder: (context)=>SizedBox(),//seach
            fallback: (context)=>Expanded(
              child: ListView.separated(
                physics: BouncingScrollPhysics(),
                  itemBuilder: (context,index)=>chat_cell(height: height, width: width),
                  separatorBuilder: (context,index)=>SizedBox(),
                  itemCount: 5),
            ),//randomly_lst
            )
        ],),
      ),
     );
   },);
  }
}

Widget chat_cell({
  required double height,
  required double width,
}){
  return Padding(
    padding:  EdgeInsets.symmetric(vertical: height/70,horizontal: width/20),
    child: InkWell(
      onTap: (){},
      child: Container(
        padding: EdgeInsets.only(left: width/30),
        height: height/8,width: width/1.17,
        decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: [
                Color.fromARGB(255, 3, 168, 243).withOpacity(.6),
                Color.fromARGB(255, 3, 168, 243).withOpacity(.5),
                Color.fromARGB(255, 3, 168, 243).withOpacity(.4),
                Color.fromARGB(255, 3, 168, 243).withOpacity(.3),
               ]
            ),
          borderRadius: BorderRadius.circular(25)
        ),
        child: Row(children:[
          Container(clipBehavior: Clip.hardEdge,
            height: height/6,width: width/6,
            decoration:const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey),
            //here the image
            //  child: imagecached(imageUrl:'${chatMAP?['data']['profile']['img']}' ),
          ),
          SizedBox(width: height/60,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: height/40,),
              SizedBox(
                width: width/2,
                child: Text('nameeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee',style:label_name,
                overflow: TextOverflow.ellipsis,),
              ),
              SizedBox(height: height/60,),
              Row(children: [
                SizedBox(
                  width: width/2.7,
                  child: Text('hi_thereee',style:TextStyle(
                      color: Colors.black54,fontSize: width/25,
                      overflow: TextOverflow.ellipsis
                  )),
                ),
                SizedBox(width: width/20,),
                Text('2002/06/30',style:TextStyle(
                    color: Colors.black38,fontSize: width/28,
                    overflow: TextOverflow.ellipsis
                )),

              ],),
              //Text('Active now',style: side_text)
            ],)
        ],),

      ),
    ),
  );
}