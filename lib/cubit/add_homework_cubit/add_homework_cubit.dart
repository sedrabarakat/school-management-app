import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import 'add_homework_states.dart';

class Add_homework_cubit extends Cubit<Add_Homework_states>{

  Add_homework_cubit():super(Add_init_Homework_states());

  static Add_homework_cubit get(context)=>BlocProvider.of(context);



  File ?imageFile;
  final ImagePicker picker = ImagePicker();


  Future pickImage(ImageSource source) async {
    final image = await picker.pickImage(
      source:  source,
      maxWidth: 800,
      maxHeight: 800,
    );
    if (image != null) {
      imageFile = File(image.path);
      emit(Homework_photo_state());
    }
  }

}