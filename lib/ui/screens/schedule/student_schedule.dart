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


class Schedule_Screen_Student extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    return BlocProvider(
      create:(BuildContext context)=> Schedule_cubit()..get_student_schedule(),
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
                                  condition:cubit.student_sch.length>0,
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
                                       SizedBox(
                                          width: width/0.33,
                                          child: AlignedGridView.count(
                                            crossAxisCount: 7,itemCount: 34,
                                            itemBuilder: (context, index) {
                                              return
                                                (index==27)?SizedBox():
                                                (index==28)?sch_container(height: height,width: width,item: student_sch[27]):
                                                (index==29)?sch_container(height: height,width: width,item: student_sch[28]):
                                                (index==30)?sch_container(height: height,width: width,item: student_sch[29]):
                                                (index==31)?sch_container(height: height,width: width,item: student_sch[30]):
                                                (index==32)?sch_container(height: height,width: width,item: student_sch[31]):
                                                (index==33)?sch_container(height: height,width: width,item: student_sch[32]):
                                                sch_container(height: height,width: width,item: student_sch[index]);
                                            },
                                          ),
                                        ),
                                        SizedBox(width: width/10,)

                                      ]),
                                  fallback: (BuildContext context)=>Image.asset('assets/image/floate_cel.gif',width: width/1.2,),
                                )
                            )
                        )
                      ],
                    )
                ),
                Positioned(
                    left: width/2,top: height/15,
                    child: Image.asset('assets/image/Calendar.png',height: height/4,width: width/2,fit: BoxFit.fill,)),
                (isteacher!=true)?Padding(
                  padding:  EdgeInsets.only(top: height/15,left: width/1.16),
                  child: Material(
                    borderRadius: BorderRadius.circular(40),
                    color: Colors.white70,
                    child: Tooltip(
                      message: 'Exam Schedule',
                      child: IconButton(onPressed: (){
                        cubit.get_exam_pic(student_id: 12).then((value){
                          show_Exam_image(context: context, width: width, height: height,url: cubit.exam_image_data['data']['exam_image']);
                        });
                      }, icon: Icon(Icons.calendar_month)),),
                  ),
                ):SizedBox()

              ]);
        },
      ),
    );
  }
}

