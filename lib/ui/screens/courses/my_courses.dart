
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school_app/constants.dart';
import 'package:school_app/cubit/courses/courses_cubit.dart';
import 'package:school_app/theme/colors.dart';
import 'package:school_app/ui/components/components.dart';
import 'package:school_app/ui/widgets/courses_widgets.dart';

class MyCoursesScreen extends StatelessWidget {
  const MyCoursesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return BlocProvider.value(
      value:  CoursesCubit()
        ..get_My_Sessions(student_id: isparent ? childId : user_id),
      child: BlocConsumer<CoursesCubit, CoursesState>(
        listener: (context, state) {
          var cubit = CoursesCubit.get(context);

          if (state is ErrorGetMySessions) {
            showToast(text: state.errorModel!.message!, state: ToastState.error);
          }

        },
        builder: (context, state) {
          var cubit = CoursesCubit.get(context);
          return Scaffold(
            backgroundColor: backgroundColor,
            appBar: null,
            body: ConditionalBuilder(
              condition: (cubit.mySessionsModel != null),
              builder: (context) => SafeArea(
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
                                width: width*0.8, text: 'My Courses'),
                            sessionImage(height, width),
                          ],
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        cubit.mySessionsModel!.data!.isEmpty
                            ? Column(
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
                        )
                            : ListView.separated(
                          shrinkWrap: true,
                          separatorBuilder:
                              (BuildContext context, int index) =>
                              SizedBox(
                                height: height * 0.04,
                              ),
                          physics: const NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemCount: cubit.mySessionsModel!.data!.length,
                          itemBuilder: (context, index) {
                              return Session_Card(
                                  height,
                                  width,
                                  context,
                                  cubit,
                                  cubit.mySessionsModel!.data![index].teacherName!,
                                  cubit.mySessionsModel!.data![index].subjectName!,
                                  cubit.mySessionsModel!.data![index].body!,
                                  cubit.mySessionsModel!.data![index].price!,
                                  cubit.mySessionsModel!.data![index].date!,
                                  cubit.mySessionsModel!.data![index].currentBooked!,
                                  cubit.mySessionsModel!.data![index].maximumStudents!,
                                  cubit.mySessionsModel!.data![index].sessionId!,
                                  is_All_Session: false
                              );
                          },
                        ),
                        SizedBox(
                          height: height * 0.06,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              fallback: (context) => Center(child: Image.asset('assets/image/Conference.gif',)),
            ),
          );
        },
      ),
    );
  }
}