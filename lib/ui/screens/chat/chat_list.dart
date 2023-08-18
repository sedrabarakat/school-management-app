import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:school_app/cubit/chat/chat_list/chat_list_cubit.dart';
import 'package:school_app/cubit/chat/chat_list/chat_list_states.dart';
import 'package:school_app/ui/widgets/library%20widget.dart';

import '../../../cubit/chat/chat/chat_cubit.dart';
import '../../../network/local/cash_helper.dart';
import '../../../theme/styles.dart';
import '../../components/components.dart';
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
         Map<String,dynamic>?chat_map=cubit.chatMap;
         List<dynamic>? chat_list=cubit.chat_list;
     return Scaffold(

       appBar: AppBar(
         leading: IconButton(onPressed: (){
           Navigator.pop(context);
         },
         icon: Icon(Icons.arrow_back_ios_sharp),),
         backgroundColor:Colors.lightBlue,
         elevation: 0,
       ),
      body: ConditionalBuilder(
        condition: chat_list?.isEmpty==false,
        builder: (context)=>Container(
          width: width,height: height,
          child: Column(children: [
            Stack(
              children: [
                wavey_Container_One(height,width, Colors.lightBlue.withOpacity(.5)),
                wavey_Container_Two(height, width, Colors.lightBlue,there: true),
              ],),
            SizedBox(height: height/100,),
            Padding(
              padding:  EdgeInsets.symmetric(
                horizontal: width/20,
                vertical: height/100,
              ),
              child: default_TextFromField(
                  is_there_suffix: true,
                  suffix: (chat_list?[0]['time']==null)?IconButton(onPressed: (){
                    cubit.get_Chat_List();
                  }, icon: Icon(Icons.backspace_rounded)):SizedBox(),
                  bordercolor:Colors.lightBlue,
                  borderWidth: 2.5,
                  is_there_prefix: true,
                  prefixcolor: Colors.lightBlue,
                  prefixicon: Icons.search,
                  borderRadius: 25,
                  width: width, height: height,
                  submit: (value){
                    cubit.Search_chat_List(name: Search_Controller.text);
                  },
                  controller: Search_Controller, keyboardtype: TextInputType.text, hintText: 'Search'),
            ),
            Expanded(
              child: ListView.separated(
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context,index)=>chat_cell(
                    context: context,
                      height: height,
                      width: width,
                      chat: chat_list![index]),
                  separatorBuilder: (context,index)=>SizedBox(),
                  itemCount: chat_list!.length),
            )
          ],),
        ),
        fallback: (context)=>SizedBox(),
      ),
     );
   },);
  }
}

Widget chat_cell({
  required BuildContext context,
  required double height,
  required double width,
   Map<dynamic,dynamic>?chat
}){
  String ?messagetime;
  if(chat?['time']!=null){
    DateTime time=DateTime.parse('${chat?['time']}');
     messagetime=DateFormat('yyyy/mm/dd').format(time);
  }

  return Padding(
    padding:  EdgeInsets.symmetric(vertical: height/70,horizontal: width/20),
    child: InkWell(
      onTap: (){
        CacheHelper.saveData(key: 'reciever_id', value: chat?['id']);
         Navigator.pushNamed(context, '/chat');
      },
      child: Container(
        padding: EdgeInsets.only(left: width/30),
        height: height/8,width: width/1.17,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 126, 208, 246).withOpacity(.4),
          borderRadius: BorderRadius.circular(25)
        ),
        child: Row(children:[
          Container(clipBehavior: Clip.hardEdge,
            height: height/6,width: width/6,
            decoration:const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey),
            //here the image
              child: (chat?['img']!=null)?Cashed_image(imageUrl:'${chat?['img']}' ):
            Image.asset('assets/image/user.png'),
          ),
          SizedBox(width: height/60,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: height/40,),
              SizedBox(
                width: width/2,
                child: Text('${chat?['name']}',style:label_name,
                overflow: TextOverflow.ellipsis,),
              ),
              SizedBox(height: height/60,),
              Row(children: [
                (chat?['message']!=null)?SizedBox(
                  width: width/2.7,
                  child: Text('${chat?['message']}',style:TextStyle(
                      color: Colors.black54,fontSize: width/25,
                      overflow: TextOverflow.ellipsis
                  )),
                ):SizedBox(),
                SizedBox(width: width/20,),
                (chat?['time']!=null)?Text('$messagetime',style:TextStyle(
                    color: Colors.black38,fontSize: width/28,
                    overflow: TextOverflow.ellipsis
                )):SizedBox(),

              ],),
              //Text('Active now',style: side_text)
            ],)
        ],),

      ),
    ),
  );
}