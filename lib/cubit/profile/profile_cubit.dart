import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:school_app/models/error_model.dart';
import 'package:school_app/models/profiles/profile_model.dart';
import 'package:school_app/network/remote/dio_helper.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  static ProfileCubit get(context) => BlocProvider.of(context);

  ErrorModel? errorModel;


  TeacherProfileModel? teacherModel;
  Future getTeacherProfile({
    required int teacher_id
  })async{
    emit(LoadingGetTeacherProfile());
    await DioHelper.postData(url: 'getTeacher',
        data: {
          'teacher_id':teacher_id
        }
    ).then((value){
      print(value.data);
      teacherModel = TeacherProfileModel.fromJson(value.data);

      emit(SuccessGetTeacherProfile());
    }).catchError((error){
      errorModel = error.response.data;
      emit(ErrorGetTeacherProfile(errorModel!));
    });
  }

  StudentProfileModel? studentModel;
  Future getStudentProfile({
    required int student_id
  })async{
    emit(LoadingGetStudentProfile());
    await DioHelper.postData(url:'getStudent',
        data: {
          'student_id':student_id
        }).then((value){
      print(value.data);
      studentModel = StudentProfileModel.fromJson(value.data);
      emit(SuccessGetStudentProfile());
    }).catchError((error){
      print(error.response.data);
      errorModel = error.response.data;
      emit(ErrorGetStudentProfile(errorModel!));
    });
  }

}
