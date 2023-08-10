import 'package:flutter/animation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../network/remote/dio_helper.dart';
import 'library_states.dart';

class Library_cubit extends Cubit<Library_state>{

  Library_cubit():super(init_Library_state());

  static Library_cubit get(context)=>BlocProvider.of(context);


  List<dynamic>Books_list=[];
  Future Get_Books()async{
    emit(Loading_Book_List());
    return await DioHelper.getData(
        url: 'booksList').then((value){
      print(Books_list);
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
    required int student_id
})async{
    emit(Loading_Booked());
    return await DioHelper.postData(
        url: 'bookBook',
        data: {
          "return_date":"2024/1/13",
          "book_id": book_id,
          "student_id": student_id
        }).
    then((value){
      print(value);
      emit(Success_Booked());
    }).catchError((error){
      print(error.response.data);
      emit(Error_Booked(error));
    });
  }

}