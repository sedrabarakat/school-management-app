import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_app/constants.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../../../network/local/cash_helper.dart';
import '../../../network/remote/dio_helper.dart';
import 'chat_states.dart';

class Chat_cubit extends Cubit<chat_states>{

  Chat_cubit():super(init_chat_state()){
    int myid=CacheHelper.getData(key: 'user_id');
    int id=CacheHelper.getData(key: 'reciever_id');
    String ?room_id;//message.2.3
    if(myid>id){
      room_id='message.$id.$myid';
    }
    else if(id>myid){
      room_id='message.$myid.$id';
    }
    else{room_id='message.$myid.$id';}
    init_websocket_chat(room_id);
  }


  static Chat_cubit get(context)=>BlocProvider.of(context);


  bool emoji_open=false;
  //IO.Socket? _socket;
  void open(){
    emoji_open=!emoji_open;
    emit(Open_Emoji_Keyboard());
  }
  Future close_emoji()async{
    emoji_open=false;
    emit(Close_Emoji_Keyboard());
  }


  Future sendmessage({
    required String message ,
    required int reciever_id,
  })async{
    return await DioHelper.postData(url: 'sendMessage',
        token:token,
        data: {
          'message':message,
          'reciever_id':reciever_id
        }
    ).then((value){
      print(value.data);
      emit(Success_SendMessage_State());
    }).catchError((error){
      print(error.response.data);
      emit(Error_SendMessage_State(error.toString()));
    });
  }

  Map<String,dynamic>?chatMAP;
  List<dynamic>messagesList=[];

  Future getMessages({
    required int id,
  })async{
    emit(Loading_getMessage_State());
    await DioHelper.getData(url: 'getMessage',
        token: token,
        query: {
          'id':id
        }
    ).then((value){
      chatMAP=value.data;
      messagesList=chatMAP?['data']['message'];
      CacheHelper.saveData(key: 'room_id', value: value.data['data']['profile']['room_id']);
      //print(messagesList);
      //CacheHelper.saveData(key: 'room_id', value: chatMAP?['data']['profile']['room_id']);
      emit(Success_getMessage_State());
    }).catchError((error){
      print( 'getMessages :${error.response.data}');
      emit(Error_getMessage_State(error));
    });
  }

  late final channel;
  Map<dynamic,dynamic>?map1;
  Map<dynamic,dynamic>?map2;
  void init_websocket_chat(room_id)async{
    final wsUr = Uri.parse('ws://192.168.43.127:6001/app/chatapp_key');
    channel = WebSocketChannel.connect(wsUr);
    emit(socket_message_connected());
    channel.sink.add(jsonEncode({
      "event":"pusher:subscribe",
      'data':{"channel":room_id}
    }));
    channel.stream.listen((message) {
       map1=jsonDecode(message);
       if(map1?['data']?.isEmpty==false){
       map2=jsonDecode(map1?['data']);
       if(map2?['message']?.isEmpty==false){
         (chatMAP?['data']['message']).insert(0,map2?['message']);
       }
       print(map2);
     }
      emit(Socket_Add_Message());
    },onError: (error){
      print(error);
      emit(SocketError(error.toString()));
    },onDone: (){
      print('channel closed');
      emit(socket_message_disconnected());
    });
  }

}