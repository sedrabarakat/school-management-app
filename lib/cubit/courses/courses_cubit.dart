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

  Future get_Sessions ({
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

}
