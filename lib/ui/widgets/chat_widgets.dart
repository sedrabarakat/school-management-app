import 'package:cached_network_image/cached_network_image.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_8.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:intl/intl.dart';
import 'package:school_app/theme/styles.dart';
import 'package:shimmer/shimmer.dart';

import '../../network/local/cash_helper.dart';

Widget wavey_Container_One(height,width,color){
  return ClipPath(
    clipper: WaveClipperOne(flip: true),
    child: Container(
      height: height/10,width: width,
      decoration: BoxDecoration(
          color: color,//Color.fromARGB(134, 238, 108, 173).withOpacity(.5)
          borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20))
      ),),
  );
}

Widget wavey_Container_Two(height,width,color,{
  required bool there
}){
  return ClipPath(
    clipper: WaveClipperTwo(),
    child: Container(
      padding: EdgeInsets.only(left: width/8),
      height: height/10,width: width,
      decoration: BoxDecoration(
          color: color,//Color.fromARGB(194, 192, 24, 91)
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20))
      ),
    child: (there==true)?Text('Chats',style: TextStyle(
      color: Colors.white70,
      fontWeight: FontWeight.bold,
      fontSize: width/14
    ),):SizedBox(),
    ),
  );
}


///////////////////////////

Widget def_message(context,height,width,reciever_color,sender_color,messagecell){
  DateTime time=DateTime.parse('${messagecell['created_at']}');
  String messagetime=DateFormat('HH:mm:ss').format(time);

  var myid=CacheHelper.getData(key: 'user_id');
  bool me=(messagecell['sender_id']==myid)?true:false;
  return Column(
    crossAxisAlignment: (me)?CrossAxisAlignment.end:CrossAxisAlignment.start,
    children: [
      ChatBubble(
        clipper: ChatBubbleClipper8(type:(me)?BubbleType.sendBubble:BubbleType.receiverBubble),
        alignment: (me)?Alignment.bottomRight:Alignment.topLeft,
        margin: EdgeInsets.only(top: height/40),
        backGroundColor: (me)?sender_color:reciever_color,
        child: Container(
          constraints: BoxConstraints(
            maxWidth: width * 0.7,
          ),
          child: Text(
            '${messagecell['message']}', // "hhaahahaha  Lol 🤣",
            style: TextStyle(color: Colors.white,fontWeight:FontWeight.w500),
          ),
        ),
      ),
      Padding(
        padding:  EdgeInsets.only(top: height/150,left: width/30,right: width/30),
        child: Text("$messagetime"),
      )
    ],
  );
}

TextFormField def_chat_TextFromField({
  required TextInputType keyboardType,
  required TextEditingController controller,
  required GestureTapCallback ?Tap,
  ValueChanged<String>? Changed,
  ValueChanged<String>? Submited,
  Widget ?prefixIcon,
  int maxLines=6,minLines=1,
  String label='Tap here to write ',
  Color cursorcolor=  Colors.blue,
  Color borderSide=Colors.blue,
  Color focusborder=Colors.blue,
  Color fillColor=const Color.fromARGB(255, 236, 236, 237),
}){
  return TextFormField(
      onTap: Tap,
      keyboardType: keyboardType,
      controller: controller,
      readOnly: false,
      onFieldSubmitted: Submited,
      onChanged: Changed,
      minLines: minLines,
      maxLines: maxLines,
      cursorColor: cursorcolor,
      decoration: InputDecoration(
        // //Container(height: height/2,width: width,
        //         Icon(Icons.messenger,color: Color.fromARGB(194, 192, 24, 91)),            //                         child: show());
          prefixIcon: prefixIcon,
          hintText: label,
          fillColor:fillColor,
          filled: true,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
          enabledBorder:OutlineInputBorder(
              borderSide: BorderSide(color: borderSide),borderRadius:BorderRadius.circular(50)
          ),
          focusedBorder: OutlineInputBorder(borderSide: BorderSide(
            color:focusborder,),borderRadius: BorderRadius.circular(50)
          )
      )
  );}


////////////Emoji picker
Widget def_Emoji_picker(message,Color indicatorColor,iconColorSelected){
  return EmojiPicker(
    onEmojiSelected: (category,emoji){
      message.text=message.text+emoji.emoji;
      print(emoji);
    },
    config: Config(columns: 7,
      gridPadding: EdgeInsets.zero,
      initCategory: Category.RECENT,
      bgColor: const Color(0xFFF2F2F2),
      indicatorColor: indicatorColor,//Color(0xFFD3567C)
      iconColor: Colors.grey,
      iconColorSelected:iconColorSelected,//Color(0xFFD3567C)
      skinToneDialogBgColor: Colors.white,
      skinToneIndicatorColor: Colors.grey,
      recentsLimit: 30,
      replaceEmojiOnLimitExceed: false,
      noRecents: const Text(
        'No Recents',
        style: TextStyle(fontSize: 20, color: Colors.black26),
        textAlign: TextAlign.center,
      ),
      loadingIndicator: const SizedBox.shrink(),
      tabIndicatorAnimDuration: kTabScrollDuration,
      categoryIcons: const CategoryIcons(),
      buttonMode: ButtonMode.MATERIAL,
      checkPlatformCompatibility: true,),
  );
}


/////////////////////////////message_Loading
Widget message_Loading(height,width,me){
  return ChatBubble(
    clipper: ChatBubbleClipper8(type:(me)?BubbleType.sendBubble:BubbleType.receiverBubble),
    alignment:(me)?Alignment.bottomRight:Alignment.topLeft,
    margin: EdgeInsets.only(top: height/40),
    backGroundColor: Colors.lightBlue.shade100,
    child: Container(
      constraints: BoxConstraints(
          maxWidth: width/2.2,maxHeight: height/25
      ),),
  );
}

Widget message_Loading_Screen({
  required double height,
  required double width
}){
  return ListView.separated(
      reverse: true,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context,index)=>Shimmer.fromColors(
        baseColor:  Colors.lightBlue.shade200,
        highlightColor: Colors.blue.shade400,
        child: Column(
          children: [
            message_Loading(height,width,true),
            message_Loading(height,width,false),
          ],
        ),
      ),
      separatorBuilder: (context,index)=>SizedBox(),
      itemCount: 4);
}

////////////////


Widget Cashed_image({
  required String imageUrl,
  Color progresscolor=Colors.blue
}){
  return CachedNetworkImage(//http://10.0.2.2:8000/images/
    imageUrl: '${imageUrl}',
    fit: BoxFit.contain,
    progressIndicatorBuilder: (context, url, downloadProgress) =>
        CircularProgressIndicator(value: downloadProgress.progress
          ,color: progresscolor,),
    errorWidget: (context, url, error) => Icon(Icons.error),
  );
}