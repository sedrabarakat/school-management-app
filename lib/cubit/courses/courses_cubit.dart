import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:school_app/constants.dart';
import 'package:school_app/models/courses/courses_model.dart';
import 'package:school_app/models/error_model.dart';
import 'package:school_app/network/remote/dio_helper.dart';

part 'courses_state.dart';

class CoursesCubit extends Cubit<CoursesState> {
  CoursesCubit() : super(CoursesInitial());

  static CoursesCubit get(context) => BlocProvider.of(context);

  GetSessionsModel? mySessionsModel;

  ErrorModel? errorModel;

  Future get_My_Sessions ({
  required int student_id,
}) async {
    emit(LoadingGetMySessions());
    mySessionsModel = null;
    DioHelper.postData(url: 'getMySession',
      data: {
        'student_id': student_id
      }
      ,token: token,
    ).then((value) {
      print('value.data: ${value.data}');
      mySessionsModel = GetSessionsModel.fromJson(value.data);
      emit(SuccessGetMySessions());
    }).catchError((error){
      print('error.response.data: ${error.response.data}');
      errorModel = ErrorModel.fromJson(error.response.data);
      emit(ErrorGetMySessions(errorModel));
    });
  }


  GetSessionsModel ?all_courses;
  ErrorModel? error_all_courses_Model;
  Future get_session({
  required int student_id
})async{
    emit(Loading_Get_Sessions());
    return DioHelper.postData(url: 'getStudentSession',
    data: {
      'student_id':student_id
    },
    token: token)
        .then((value){
      all_courses=GetSessionsModel.fromJson(value.data);
          print(value.data);
          emit(Success_Get_Sessions());
    }).catchError((error){
      error_all_courses_Model=ErrorModel.fromJson(error.response.data);
      emit(Error_Get_Sessions(error_all_courses_Model));
    });
  }

  Future Book_Session({
    required int student_id,
    required int session_id
})async{
    emit(Loading_Book_Sessions());
    return DioHelper.postData(url: 'bookSession',
    token: token,
    data: {
      'student_id':student_id,
      'session_id':session_id
    }).
    then((value){
      print(value);
      emit(Success_Book_Sessions());
    }).catchError((error){
      emit(Error_Book_Sessions(error));
    });
  }

  Future UnBook_Session({
    required int student_id,
    required int session_id
  })async{
    emit(Loading_Book_Sessions());
    return DioHelper.postData(url: 'unBookSession',
        token: token,
        data: {
          'student_id':student_id,
          'session_id':session_id
        }).
    then((value){
      print(value);
      emit(Success_Book_Sessions());
    }).catchError((error){
      emit(Error_Book_Sessions(error));
    });
  }

}
