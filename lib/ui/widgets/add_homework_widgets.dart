import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:school_app/cubit/add_homework_cubit/add_homework_cubit.dart';

import '../../theme/styles.dart';

List<DropdownMenuItem<String>> add_item({
  required List available_list,
  required String need
}) {
  final List<DropdownMenuItem<String>> menuItems = [];
  for(int i=0;i<available_list.length;i++)
  {
    menuItems.addAll( [
      DropdownMenuItem<String>(
        value: '${available_list[i]['id']}',
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            '${available_list[i]['$need']}',
            style: const TextStyle(
              fontSize: 14,
            ),),
        ),
      ),
    ]);
  }
  return menuItems;
}

int ?subject_id;
int ?section_id;

Widget drop_choose({
  required context,
  required List<dynamic> chosen_list,
  required double height,
  required double width,
  required String hintText,
  required String need,
  Add_homework_cubit? cubit,
  required String kind,
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
        items:add_item(available_list: chosen_list, need: need),
        validator: (value) {
          if (value == null) {
            return 'Please select Grade';
          }
          return null;
        },
        onChanged: (value){
          if(cubit!=null) {
            cubit.get_teacher_sections(subject_id:  int. parse(value!));
          }
          if(kind=='subject') {
            subject_id=int.parse(value!);
          }
          else if(kind=='grade'){
            section_id=int.parse(value!);
          }
          else{}
          print("$kind $value");
        },
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
