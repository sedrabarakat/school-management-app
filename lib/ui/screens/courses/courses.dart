
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../constants.dart';
import '../../../cubit/courses/courses_cubit.dart';
import '../../../models/courses/courses_model.dart';
import '../../../theme/colors.dart';
import '../../components/components.dart';
import '../../widgets/courses_widgets.dart';

class CoursesScreen extends StatelessWidget {
  const CoursesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return BlocProvider.value(
      value:  CoursesCubit()..get_session(student_id: isparent ? childId : user_id),
      child: BlocConsumer<CoursesCubit, CoursesState>(
        listener: (context, state) {
          if(state is Success_Book_Sessions)
            showToast(text: 'Successfully Booked', state: ToastState.success);
          if(state is Error_Book_Sessions)
            showToast(text: 'Cannot Book...please try again', state: ToastState.error);
        },
        builder: (context, state) {
          var cubit = CoursesCubit.get(context);
          GetSessionsModel? all_session=cubit.all_courses;

          return Scaffold(
            backgroundColor: backgroundColor,
            appBar: null,
            body: SafeArea(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: width * 0.05,
                    vertical: height * 0.04,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(onPressed: (){
                            Navigator.pop(context);
                          }, icon: Icon(Icons.arrow_back_outlined,color: Colors.blue,size: 50.sp,)),
                          Animated_Text_Blue(
                              width: width*0.8, text: 'All Courses'),
                          Tooltip(
                            waitDuration: Duration(milliseconds: 300),
                            message: 'My Courses',
                            child: IconButton(onPressed: (){
                              Navigator.of(context).pushNamed('/my_courses');
                            }, icon: Icon(Icons.home,color: Colors.blue,size: 70.sp,)),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: height/20,
                      ),
                      ConditionalBuilder(
                          condition: all_session!=null,
                          builder: (Context)=>(cubit.all_courses!.data!.length>0)?
                           ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context,index)=> Session_Card(
                                height,
                                width,
                                context,
                                cubit,
                                cubit.all_courses!.data![index].teacherName!,
                                cubit.all_courses!.data![index].subjectName!,
                                cubit.all_courses!.data![index].body!,
                                cubit.all_courses!.data![index].price!,
                                cubit.all_courses!.data![index].date!,
                                cubit.all_courses!.data![index].currentBooked!,
                                cubit.all_courses!.data![index].maximumStudents!,
                                cubit.all_courses!.data![index].sessionId!,
                                    is_All_Session: true
                            ),
                            separatorBuilder: (context,index)=>SizedBox(height: height/30,),
                            itemCount: cubit.all_courses!.data!.length,
                          ):Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(height: height/10,),
                              Container(
                                child: Image.asset('assets/image/Conference.gif',),
                              ),
                              Text(
                                'There is no Sessions :(',
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 50.sp),
                              ),
                            ],
                          ),
                            fallback: (Context)=>Padding(
                            padding: EdgeInsets.only(top: height/8),
                              child: Image.asset('assets/image/Conference.gif',))
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
