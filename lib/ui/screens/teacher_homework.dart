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

class Teacher_Homework extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    var homework_controller=TextEditingController();
    return BlocConsumer<Add_homework_cubit,Add_Homework_states>(
      listener: (context,states){},
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
                    'Choose Class then Grade',
                    style: TextStyle(fontSize: width/22,fontWeight: FontWeight.bold,
                        color:Color.fromARGB(255, 12, 139, 255)),
                  ),
                ),
                drop_choose(context: context, chosen_list: classes, height: height, width: width,hintText: 'choose class'),
                drop_choose(context: context, chosen_list: classes, height: height, width: width,hintText: 'choose Grade'),
                Padding(
                  padding:  EdgeInsets.only(left: width/9,bottom: height/40,top: height/50),
                  child: Text(
                    'Write the homework',
                    style: TextStyle(fontSize: width/22,fontWeight: FontWeight.bold,
                        color:Color.fromARGB(255, 12, 139, 255)),
                  ),),
                ConditionalBuilder(
                    condition: cubit.imageFile!=null,
                    builder: (context)=>Center(
                      child: Container(
                        height: height/5,width: width/2,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.blue,width: 2)
                        ),
                        child: Image.file(cubit.imageFile!,fit: BoxFit.fill,),
                      ),
                    ),
                    fallback: (context)=>SizedBox()),
                SizedBox(height: height/60,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width/10,),
                  child: default_TextFromField(
                      is_there_prefix: true,
                      is_there_suffix: true,
                      suffix: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(onPressed: ()async{
                            await cubit.pickImage(ImageSource.camera);
                          },
                              icon: Icon(Icons.photo_camera)),
                          IconButton(onPressed: ()async{
                            await cubit.pickImage(ImageSource.gallery);
                          },
                              icon: Icon(Icons.photo)),
                        ],),
                      suffixcolor: Color.fromARGB(255, 12, 139, 255),
                      prefixicon: Icons.my_library_books,
                      prefixcolor: Color.fromARGB(255, 12, 139, 255),
                      submit: (value){
                        print(value);
                      },
                      maxlines: 15,
                      width: width,
                      height: height,
                      controller: homework_controller,
                      keyboardtype: TextInputType.text, hintText: 'Homework'),
                ),
                Padding(
                  padding: EdgeInsets.only(left: width/1.5,top: height/40,bottom:height/40),
                  child: elevatedbutton(Function: (){},
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
    );
  }
}



Widget drop_choose({
  required context,
  required List<dynamic> chosen_list,
  required double height,
  required double width,
  required String hintText
}){
  return Padding(
    padding:  EdgeInsets.only(left: width/9,bottom: height/50),
    child: Container(
      width: width/1.4,
      child: DropdownButtonFormField2(
        decoration: drop_decoration(),
        isExpanded: true,
        hint:Text(
          '$hintText',
        ),
        items:classes
            .map((item) => DropdownMenuItem<String>(
          value: item,
          child: Text(
            item,
            style: TextStyle(
                fontSize: width/25,fontWeight: FontWeight.w400,color: Colors.grey.shade800
            ),),
        )).toList(),
        validator: (value) {
          if (value == null) {
            return 'Please select Grade';
          }
          return null;
        },
        onChanged: (value){},
        onSaved: (value) {},
        buttonStyleData: drop_button_style(width: width,height: height),
        iconStyleData:  drop_icon_style(size: 0),
        dropdownStyleData: DropdownStyleData(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),),
      ),
    ),
  );
}

final List<String> classes = [
  'First Grade',
  'Second Grade',
  'Third Grade',
  'Fourth Grade',
  'Fifth Grade',
  'Sixth Grade',
  'Seventh Grade',
  'Eighth Grade',
  'Ninth Grade',
  'Tenth Grade',
  'Eleventh Grade',
  'Bachelor Grade',
];
