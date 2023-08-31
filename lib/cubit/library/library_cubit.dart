import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_app/constants.dart';
import '../../network/remote/dio_helper.dart';
import 'library_states.dart';

class Library_cubit extends Cubit<Library_state>{

  Library_cubit():super(init_Library_state());

  static Library_cubit get(context)=>BlocProvider.of(context);


  List<dynamic>Books_list=[];
  Future Get_Books()async{
    emit(Loading_Book_List());
    return await DioHelper.getData(
        url: 'booksList',token: token,).then((value){
      Books_list=value.data;
      print(Books_list);
      emit(Success_Book_List());
    }).catchError((error){
      print(error.response.data);
      emit(Error_Book_List(error));
    });
  }

  Future Booked({
  required int book_id,
    required int student_id,
    required String return_date
})async{
    emit(Loading_Booked());
    return await DioHelper.postData(
        url: 'bookBook',token: token,
        data: {
          "return_date":"$return_date",
          "book_id": book_id,
          "student_id": student_id
        }).
    then((value){
      print(return_date);
      emit(Success_Booked());
      print(value);
    }).catchError((error){
      print(error.response.data);
      emit(Error_Booked(error));
    });
  }

}