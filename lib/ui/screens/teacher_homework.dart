

import 'dart:io';
import 'dart:typed_data';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:school_app/cubit/add_homework_cubit/add_homework_cubit.dart';
import 'package:school_app/cubit/add_homework_cubit/add_homework_states.dart';
import 'package:school_app/ui/components/components.dart';
import 'package:school_app/ui/widgets/library%20widget.dart';

import '../../theme/styles.dart';
import '../widgets/add_homework_widgets.dart';
var homework_controller=TextEditingController();

class Teacher_Homework extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (BuildContext context) => Add_homework_cubit()..get_teacher_classes()..get_teacher_subject(),
      child: BlocConsumer<Add_homework_cubit,Add_Homework_states>(
        listener: (context,states){
          if(states is Success_Add_Homework) showToast(text: 'Success Add Homework', state: ToastState.success);

          if(states is Error_Add_Homework) showToast(text: 'Faild to Add...try again', state: ToastState.success);
        },
        builder: (context,states){
          Add_homework_cubit cubit=Add_homework_cubit.get(context);
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Color.fromARGB(255, 6, 10, 113),
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipPath(
                    clipper: OvalBottomBorderClipper(),
                    child: Container(
                        height: height/3,width: width,
                        color: Color.fromARGB(255, 233, 242, 253),
                        child:Lottie.asset('assets/image/teacher_app.json')),
                  ),
                  SizedBox(height: height/20,),
                  Padding(
                    padding:  EdgeInsets.only(left: width/9,bottom: height/50),
                    child: Text(
                      'Choose Class then Grade & subject',
                      style: TextStyle(fontSize: width/22,fontWeight: FontWeight.bold,
                          color:Color.fromARGB(255, 12, 139, 255)),
                    ),
                  ),
                  drop_choose(context: context, chosen_list: cubit.classes, height: height, width: width, hintText: 'choose class',need: 'grade',kind: ''),
                  drop_choose(context: context, chosen_list: cubit.subject, height: height, width: width, hintText: 'choose Subject',need: 'name',cubit: cubit,kind: 'subject'),
                  ConditionalBuilder(
                      condition: states is Success_get_teacher_sections,
                      builder: (context)=>drop_choose(context: context, chosen_list: cubit.sections, height: height, width: width,hintText: 'choose Section',need: 'number',kind: 'grade'),
                      fallback: (context)=>SizedBox()),
                  Padding(
                    padding:  EdgeInsets.only(left: width/9,bottom: height/40,top: height/50),
                    child: Text(
                      'Write the homework',
                      style: TextStyle(fontSize: width/22,fontWeight: FontWeight.bold,
                          color:Color.fromARGB(255, 12, 139, 255)),
                    ),),
                  ConditionalBuilder(
                      condition: cubit.homefile!=null,
                      builder: (context)=>Center(
                        child: Container(
                          height: height/5,width: width/2,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.blue,width: 2)
                          ),
                          child: Image.file(File(cubit.homweork_file!.files.first.path!))//Image.file(File(cubit.homefile!)
                        ),
                      ),
                      fallback: (context)=>SizedBox()),
                  SizedBox(height: height/60,),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: width/10,),
                    child: default_TextFromField(

                        is_there_prefix: true,
                        is_there_suffix: true,
                        suffix: IconButton(onPressed: ()async{
                          await cubit.pick_file();
                        },
                            icon: Icon(Icons.file_copy)),
                        suffixcolor: Color.fromARGB(255, 12, 139, 255),
                        prefixicon: Icons.my_library_books,
                        prefixcolor: Color.fromARGB(255, 12, 139, 255),
                        submit: (value){
                          homework_controller.text=value.toString();
                        },
                        maxlines: 15,
                        width: width,
                        height: height,
                        controller: homework_controller,
                        keyboardtype: TextInputType.text, hintText: 'Homework'),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: width/1.5,top: height/40,bottom:height/40),
                    child: elevatedbutton(Function: (){
                      cubit.Send_homework(subject_id: subject_id!, section_id: section_id!, body: homework_controller.text);
                      homework_controller.clear();
                    },
                        widthSize: width/4,
                        borderRadius: 50,
                        backgroundColor: Color.fromARGB(255, 12, 139, 255),
                        heightSize: height/20, text: 'Submit'),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
