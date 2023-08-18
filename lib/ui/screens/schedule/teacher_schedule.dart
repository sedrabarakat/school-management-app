import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:lottie/lottie.dart';
import 'package:school_app/cubit/schedule/schedule_cubit.dart';
import 'package:school_app/ui/widgets/schedule_widget.dart';

import '../../../constants.dart';
import '../../../cubit/schedule/schedule_states.dart';
import '../../../theme/styles.dart';
import '../../components/components.dart';


class Schedule_Screen_Teacher extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    return BlocProvider(
      create:(BuildContext context)=> Schedule_cubit()..get_teacher_schedule(),
      child: BlocConsumer<Schedule_cubit,Schedule_states>(
        listener: (context,state)=>SizedBox(),
        builder: (context,state){
          Schedule_cubit cubit=Schedule_cubit.get(context);
          List<dynamic>student_sch=cubit.student_sch;
          return Stack(
              children: [
                Scaffold(//Center(child: Text('Program of the week')),
                    appBar: AppBar(
                      elevation: 0,
                      flexibleSpace: Container(
                        decoration: blue_gardinaeet,
                      ),
                    ),
                    body: Column(
                      children: [
                        ClipPath(
                            clipper: WaveClipperTwo(),
                            child: Container(
                              height: height/8,width: width,
                              decoration:blue_gardinaeet,
                              child: Padding(
                                  padding: EdgeInsets.only(left: width/16),
                                  child: Animated_Text(width: width, text:'Schedule')),
                            )
                        ),
                        SingleChildScrollView(
                            physics: BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            child: Container(color: Colors.white10,
                                height: height/1.35,
                                child:
                                ConditionalBuilder(
                                  condition:cubit.teacher_sch.length>0,
                                  builder: (context)=>Row(
                                      children: [
                                        animation_column(height: height, width: width, children: [
                                          SizedBox(height: height/25,),
                                          days_container(width: width,day:'Sunday', height: height ),
                                          days_container(width: width,day:'Monday' ,height:height),
                                          days_container(width: width,day:'Tuesday',height:height ),
                                          days_container(width: width,day:'Wednsday' ,height:height),
                                          days_container(width: width,day:'Thursday' ,height:height),
                                        ]),
                                        Padding(
                                          padding:  EdgeInsets.only(bottom: height/30),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Teacher_sch(width: width, height: height, length: 7,hussas: cubit.sunday),
                                              Teacher_sch(width: width, height: height, length: 7,hussas: cubit.monday),
                                              Teacher_sch(width: width, height: height, length: 7,hussas: cubit.tuesday),
                                              Teacher_sch(width: width, height: height, length: 6,hussas: cubit.wednsday),
                                              Teacher_sch(width: width, height: height, length: 6,hussas: cubit.thursday),
                                            ],
                                          ),
                                        ),
                                        SizedBox(width: width/10,)

                                      ]),
                                  fallback: (BuildContext context)=>Image.asset('assets/image/floate_cel.gif',width: width/1.2),
                                )
                            )
                        )
                      ],
                    )
                ),
                Positioned(
                    left: width/2,top: height/15,
                    child: Image.asset('assets/image/Calendar.png',height: height/4,width: width/2,fit: BoxFit.fill,)),


              ]);
        },
      ),
    );
  }
}
