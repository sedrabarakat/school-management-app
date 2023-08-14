abstract class Library_state{}

class init_Library_state extends Library_state{}

class Loading_Book_List extends Library_state{}

class Success_Book_List extends Library_state{}

class Error_Book_List extends Library_state{

 String error;
 Error_Book_List(this.error);


}

class Loading_Booked extends Library_state{}

class Success_Booked extends Library_state{}

class Error_Booked extends Library_state{
 String error;
 Error_Booked(this.error);
}