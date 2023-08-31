import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:school_app/constants.dart';
import 'package:school_app/network/remote/dio_helper.dart';

import 'add_homework_states.dart';

class Add_homework_cubit extends Cubit<Add_Homework_states>{

  Add_homework_cubit():super(Add_init_Homework_states());

  static Add_homework_cubit get(context)=>BlocProvider.of(context);



  File ?imageFile;
  final ImagePicker picker = ImagePicker();
  Future pickImage(ImageSource source) async {
    final image = await picker.pickImage(
        source:  ImageSource.camera,

        );
    if (image != null) {
       imageFile = File(image.path);

      emit(Homework_photo_state());
    }
  }
  //'image': (imageFile==null)?null:await MultipartFile.fromFile(imageFile!.path, filename:imageFile!.path.split('/').last)
  FilePickerResult? homweork_file;
  List<int> ?homefile;
  String ?homefile_path;
  String ?homefile_name;
  File ?homefile_File;
  Future pick_file()async {
    homweork_file= await FilePicker.platform.pickFiles(
      allowMultiple: false,


    );
    if(homweork_file!=null){
      imageFile=null;
      homefile=homweork_file!.files.single.bytes;
      /*
      homefile_path=homweork_file!.files.first.path!;
      homefile_File=File(homefile_path!);
      homefile_name=homweork_file!.files.first.name;
       */
    }
    emit(Add_Cover_state());
  }
  List<dynamic>classes=[];
  Future get_teacher_classes()async{
    emit(Loading_get_teacher_classes());
    DioHelper.getData(url: 'getSafs',
      token: token
    ).then((value){
      classes=value.data;
      print('dddddddddddddddddddddddddddddddd');
      print(classes);
      emit(Success_get_teacher_classes());
    }).
    catchError((error){
      emit(Error_get_teacher_classes());
    });
  }
  Map<String,dynamic>?sections_map;
  List<dynamic>sections=[];
  Future get_teacher_sections({
  required int subject_id
})async{
    emit(Loading_get_teacher_sections());
    DioHelper.postData(url: 'getTeacherSections',
        token: token,
    data: {
      'subject_id':subject_id
          }
    ).then((value){
      sections_map=value.data;
      sections=sections_map?['data'];
      print(value.data);
      emit(Success_get_teacher_sections());
    }).
    catchError((error){
      print(error);
      emit(Error_get_teacher_sections());
    });
  }

  List<dynamic>subject=[];
  Future get_teacher_subject()async{
    emit(Loading_get_teacher_subject());
    DioHelper.getData(url: 'getSubjects',
        token: token
    ).then((value){
      subject=value.data;
      print(value.data);
      emit(Success_get_teacher_subject());
    }).
    catchError((error){
      emit(Error_get_teacher_subject());
    });
  }
  
  Future Send_homework({
    required int subject_id,
    required int section_id,
    required String body,
    File ?file,

})async{
    emit(Loading_Add_Homework());
    DioHelper.postDataImage(url: 'addHomework',
    token: token,
    data: FormData.fromMap({
      'subject_id':subject_id,
      'section_id':section_id,
      "body":body,
      if(homefile!=null)'file':MultipartFile.fromBytes(homefile!, filename:homweork_file!.files.single.name)

    })
    ).
    then((value){
      emit(Success_Add_Homework());
    }).
    catchError((error){
      print(error.response.data);
      emit(Error_Add_Homework());
    });
    
  }

}