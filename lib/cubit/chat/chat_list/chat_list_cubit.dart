

import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../../constants.dart';
import '../../../network/local/cash_helper.dart';
import '../../../network/remote/dio_helper.dart';
import 'chat_list_states.dart';

class Chat_List_Cubit extends Cubit<Chat_List_States> {
  Chat_List_Cubit() : super(init_chat_list_state()){
    init_websocket();
  }

  static Chat_List_Cubit get(context) => BlocProvider.of(context);



  Map<String,dynamic>?chatMap;
  List<dynamic> chat_list=[];
  Future get_Chat_List()async{
    emit(Loading_ChatList_State());
    return await DioHelper.getData(url: 'getChats',
      token:token,
    ).then((value) async {
      chat_list=value.data['data'];
      //print(chat_list);
      // print(chatmodel?.data?.profile?.name);
      emit(Success_ChatList_State());

    }).catchError((error){
      print('get_ChatList Error is ${error.response.data}');
      emit(Error_ChatList_State(error.toString()));
    });
  }
  
  Future Search_chat_List({
  required String name
})async{
    emit(Loading_Search_ChatList_State());
    return await DioHelper.postData(url: 'searchChat',
    token: token,
    data: {
      'name':name
    }
    ).then((value){
      chat_list=value.data['data'];
      print(value);
      emit(Success_Search_ChatList_State());
    }).catchError((error){
      emit(Error_Search_ChatList_State(error.toString()));
    });
  }

  Map<dynamic,dynamic>?map;
  Map<dynamic,dynamic>?map2;
  int myid=CacheHelper.getData(key: 'user_id');
  late final channel;
  void init_websocket()async{
    final wsUrl = Uri.parse('ws://10.0.2.2:6001/app/chatapp_key');
    channel = WebSocketChannel.connect(wsUrl);
    emit(socket_chat_connected());

    channel.sink.add(
        jsonEncode(
            { "event":"pusher:subscribe",
              'data':{"channel":"chats.$myid"}
            }));
    channel.stream.listen((message) {
      map=jsonDecode(message);
      map2=jsonDecode(map!['data']);
      chat_list=map2?['chats'];
      //print(' HERE is ${map2?['chats']}');

      emit(socket_change_list());
    },onError: (error){
      print(error);
      emit(SocketError(error.toString()));
    },onDone: (){
      print('channel closed');
      emit(socket_chat_disconnected());
    });
  }

  /*
  IO.Socket? _socket;
  void tes()async {
    _socket = await IO.io('ws://10.0.2.2:6001/app/chatapp_key', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });
    _socket!.onConnect((_) {
      _socket!.emit('pusher:subscribe');
      _socket!.on('chats.3', (data) => print(data));
      print('connected');
      emit(socket_chat_connected());
    });

    _socket!.onDisconnect((_) {
      print('disconnected');
      emit(socket_chat_disconnected());
    });
    _socket!.connect();
  }

  Map<dynamic,dynamic>?map;
  Map<dynamic,dynamic>?map2;
  inner_chat ?inner;
  int myid=CacheHelper.getData(key: 'Myid');
  late final channel;
  void init_websocket()async{
    final wsUrl = Uri.parse('ws://10.0.2.2:6001/app/chatapp_key');
    channel = WebSocketChannel.connect(wsUrl);
    emit(socket_chat_connected());

    channel.sink.add(
        jsonEncode(
            { "event":"pusher:subscribe",
              'data':{"channel":"chats.$myid"}
            }));
    channel.stream.listen((message) {
      map=jsonDecode(message);
      map2=jsonDecode(map!['data']);
      chatMap?['data']['chats']=map2?['chats'];

      emit(socket_change_list());
    },onError: (error){
      print(error);
      emit(SocketError(error.toString()));
    },onDone: (){
      print('channel closed');
      emit(socket_chat_disconnected());
    });
  }


*/



}