
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import '../../../cubit/chat/chat/chat_cubit.dart';
import '../../../cubit/chat/chat/chat_states.dart';
import '../../../theme/styles.dart';
import '../../widgets/chat_widgets.dart';

class Chat extends StatelessWidget{

  var message=TextEditingController();

  Chat({super.key});
  @override
  Widget build(BuildContext context) {
    FocusNode focus=FocusNode();
    var height=MediaQuery.of(context).size.height;
    var width=MediaQuery.of(context).size.width;
    var scroll_list=ScrollController();
    return BlocConsumer<Chat_cubit,chat_states>(
      listener: (context,PrivateChatState){},
      builder: (context,PrivateChatState){
        Chat_cubit cubit=Chat_cubit.get(context);
        Map <String,dynamic>?chatMAP=cubit.chatMAP;
        List <dynamic>?messagesList=cubit.messagesList;
        //Object? id=ModalRoute.of(context)?.settings.arguments;
        bool emoji_open=cubit.emoji_open;
        return  Scaffold(
            backgroundColor: const Color.fromARGB(255, 197, 189, 195),
            appBar: AppBar(
              backgroundColor:const Color.fromARGB(255, 203, 56, 113),
              elevation: 0,
              leading: IconButton(onPressed: () {
                Navigator.pushNamed(context, '/public_chats');
                cubit.close();
              },
                icon:const Icon(Icons.arrow_back_ios_sharp),
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(clipBehavior: Clip.hardEdge,
                    height: height/9,width: width/9,
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
                      Text('name',style:label_name),
                      SizedBox(height: height/200,),
                      //Text('Active now',style: side_text)
                    ],)
                ],),
              actions: [
                IconButton(onPressed: (){
                  //privatcubit.chat();
                 // privatcubit.connect();
                }, icon: const Icon(Icons.menu,color: Colors.white,))
              ],),
            body: Container(
              width: width,height: height,
              decoration:chat_background,
              child: Column(children: [
                Stack(
                  children: [
                    wavey_Container_One(height,width,const Color.fromARGB(134, 238, 108, 173).withOpacity(.5)),
                    wavey_Container_Two(height, width, const Color.fromARGB(255, 203, 56, 113)),
                  ],),
                SizedBox(height: height/100,),
                ConditionalBuilder(
                  condition: true,//chatMAP?.isEmpty==false,//message_Loading_Screen(height: height,width: width)
                  builder: (context)=>Expanded(
                      child: CupertinoScrollbar(
                        thumbVisibility:true,
                        thickness:10,radius: const Radius.circular(5),radiusWhileDragging:const Radius.circular(10) ,
                        thicknessWhileDragging:15,
                        controller: scroll_list,
                        child: ListView.separated(
                            dragStartBehavior: DragStartBehavior.down,
                            reverse: true,
                            controller: scroll_list,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context,index)=>def_message(context,height,width,const Color(0xFFD3567C),
                                const Color(
                                0x8EA8013C),messagesList[index]),
                            separatorBuilder:(context,index)=>SizedBox(),
                            itemCount: 10),
                      )),
                  fallback: (context)=>Expanded(
                      child: message_Loading_Screen(height: height,width: width)),
                ),
                Row(
                  children: [
                    Container(width: width/1.15,
                      child: Padding(
                          padding:  EdgeInsets.all(height/70),
                          child:def_chat_TextFromField(
                            keyboardType: (emoji_open)?TextInputType.none:TextInputType.text,
                            controller: message,
                            Submited: (value){},
                            Tap: (){
                              if(emoji_open) {
                                cubit.close_emoji();
                                FocusScope.of(context).requestFocus(focus);
                                SystemChannels.textInput.invokeMethod('TextInput.show');
                              }},
                            prefixIcon:IconButton(onPressed:(){
                              FocusScope.of(context).requestFocus(focus);
                              SystemChannels.textInput.invokeMethod('TextInput.hide');
                              cubit.open();
                            },icon:const Icon(Icons.emoji_emotions,color: Color(0xFFD3567C),),),
                          )),),
                    IconButton(splashColor: Colors.pinkAccent.withOpacity(.4),
                        onPressed: (){
                      /*{
                          if(message.text.length>0){
                            privatcubit.sendmessage(message: message.text, reciever_id: CacheHelper.getData(key: 'id'));
                            message.clear();}
                        }*/
                        },
                        icon:const Icon(
                          Icons.send,
                          color:Color.fromARGB(194, 192, 24, 91),)),
                  ],),
                (emoji_open)?Container(height: height/3,width: width, child: def_Emoji_picker(message,Color(0xFFD3567C),Color(0xFFD3567C))):Container()
              ],),
            )
        );
      },
    );
  }}
