import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:school_app/ui/screens/teacher_homework.dart';

import '../../constants.dart';

class HomeworkScreen extends StatelessWidget {
  const HomeworkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final padd = MediaQuery.of(context).padding;
    final textSize = MediaQuery.of(context).textScaleFactor;
    return ConditionalBuilder(
      condition: isteacher==true,
      builder: (context)=>Teacher_Homework(),
      fallback: (context)=>Text('here parent and student Homework Screen'),
    );
   
  }
}