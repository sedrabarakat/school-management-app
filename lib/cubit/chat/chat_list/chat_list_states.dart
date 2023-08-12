abstract class Chat_List_States{}

class init_chat_list_state extends Chat_List_States{}


class Loading_ChatList_State extends Chat_List_States{}

class Success_ChatList_State extends Chat_List_States{}

class Error_ChatList_State extends Chat_List_States{
  String error;
  Error_ChatList_State(this.error);
}


class Loading_Search_ChatList_State extends Chat_List_States{}

class Success_Search_ChatList_State extends Chat_List_States{}

class Error_Search_ChatList_State extends Chat_List_States{
  String error;
  Error_Search_ChatList_State(this.error);
}
