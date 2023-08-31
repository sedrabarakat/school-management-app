import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_app/constants.dart';
import 'package:school_app/cubit/schedule/schedule_states.dart';
import 'package:school_app/network/remote/dio_helper.dart';
import 'package:simple_animations/developer_tools/animation_developer_tools.dart';

class Schedule_cubit extends Cubit<Schedule_states>{

  Schedule_cubit():super(init_schedule_state());


  static Schedule_cubit get(context)=>BlocProvider.of(context);




  List<dynamic> student_sch=[];
  Future get_student_schedule({
    required int id
  })async{
    emit(Loading_get_student_sch());
    DioHelper.getData(url: 'getStudentProgram/${id}',
        token: token).then((value){
      student_sch=value.data['data'];
      print(student_sch);
      emit(Success_get_student_sch());
    }).
    catchError((error){
      emit(Error_get_student_sch(error.toString()));
    });
  }


  Map<String,dynamic> teacher_sch={};
  List<dynamic>sunday=[];
  List<dynamic>monday=[];
  List<dynamic>tuesday=[];
  List<dynamic>wednsday=[];
  List<dynamic>thursday=[];
  Future get_teacher_schedule()async{
    emit(Loading_get_teacher_sch());
    DioHelper.getData(url: 'getTeacherProgram',token: token).then((value){
      teacher_sch=value.data;
      (teacher_sch["1"]!=null)?sunday=teacher_sch["1"]:[];
      (teacher_sch["2"]!=null)?monday=teacher_sch["2"]:[];
      (teacher_sch["3"]!=null)?tuesday=teacher_sch["3"]:[];
      (teacher_sch["4"]!=null)?wednsday=teacher_sch["4"]:[];
      (teacher_sch["5"]!=null)?thursday=teacher_sch["5"]:[];


      emit(Success_get_teacher_sch());
    }).catchError((error){
      print(error.response.data);
      emit(Error_get_teacher_sch(error.toString()));
    });
  }

  Map<String,dynamic>exam_image_data={};
  Future get_exam_pic({
   required int student_id
}){
    emit(Loading_get_Exam_pic());
    return DioHelper.postData(
        url: 'getExamPhoto',
    data: {
          'student_id':student_id
          }).then((value){
      exam_image_data=value.data;
    emit(Success_get_Exam_pic());
    }).catchError((error){
      emit(Error_get_Exam_pic(error.toString()));
    });
  }
  


}