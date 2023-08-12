abstract class chat_states{}

class init_chat_state extends chat_states{}

class Open_Emoji_Keyboard extends chat_states{}

class Close_Emoji_Keyboard extends chat_states{}

class Loading_getMessage_State extends chat_states{}

class Success_getMessage_State extends chat_states{}

class Error_getMessage_State extends chat_states{
  String error;
  Error_getMessage_State(this.error);
}

class Loading_SendMessage_State extends chat_states{}

class Success_SendMessage_State extends chat_states{}

class Error_SendMessage_State extends chat_states{
  String error;
  Error_SendMessage_State(this.error);
}