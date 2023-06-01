import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class HomeworkScreen extends StatelessWidget {
  const HomeworkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final padd = MediaQuery.of(context).padding;
    final textSize = MediaQuery.of(context).textScaleFactor;
    return Scaffold(
      appBar: AppBar(),
    body:
       Center(
      child: Container(child: Text('HomeworkScreen'),
      ),
    ),
    ); 
   
  }
}