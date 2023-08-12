import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../network/local/cash_helper.dart';
import '../../../network/remote/dio_helper.dart';
import 'chat_states.dart';

class Chat_cubit extends Cubit<chat_states>{

  Chat_cubit():super(init_chat_state());


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
        token:CacheHelper.getData(key: 'token'),
        data: {
          'message':message,
          'reciever_id':reciever_id
        }
    ).then((value){
      //print(value.data);
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
        token: CacheHelper.getData(key: 'token'),
        query: {
          'id':id
        }
    ).then((value){
      chatMAP=value.data;
      messagesList=chatMAP?['data']['message'];
      CacheHelper.saveData(key: 'room_id', value: chatMAP?['data']['profile']['room_id']);
      emit(Success_getMessage_State());
    }).catchError((error){
      print( 'getMessages :${error.response.data}');
      emit(Error_getMessage_State(error));
    });
  }

}