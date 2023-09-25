
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school_app/cubit/homeworks/homework_cubit.dart';
import 'package:school_app/theme/colors.dart';
import 'package:school_app/ui/components/components.dart';
import 'package:school_app/ui/widgets/homework_widgets.dart';

import '../../constants.dart';

class Homework_student extends StatelessWidget {
  const Homework_student({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) => HomeworkCubit()..getHomeworks(student_id: isparent ? childId : user_id),
      child: BlocConsumer<HomeworkCubit, HomeworkState>(
        listener: (context, state) {
          var cubit = HomeworkCubit.get(context);

          if (state is GetHomeworkSuccess) {}

          if (state is GetHomeworkError) {
            showToast(
                text: state.errorModel!.message!,
                state: ToastState.error);
          }
        },
        builder: (context, state) {
          var cubit = HomeworkCubit.get(context);
          return Scaffold(
            backgroundColor: backgroundColor,
            appBar: null,
            body: ConditionalBuilder(
              condition: cubit.homeworkModel != null,
              builder: (context) => SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: width * 0.05,
                      vertical: height * 0.04,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Animated_Text_Blue(width: width, text: 'Homework'),
                            Icon(
                              Icons.home_work_outlined,
                              size: 75.sp,
                              color: Colors.blueAccent,
                            ),
                          ],
                        ),
                        Divider(
                          thickness: 1.5,
                          color: Colors.blueAccent,
                        ),
                        SizedBox(
                          height: height * 0.03,
                        ),
                        cubit.homeworkModel!.homeworksList!.isNotEmpty
                            ? ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount:
                          cubit.homeworkModel!.homeworksList!.length,
                          separatorBuilder:
                              (BuildContext context, int index) =>
                              Divider(
                                thickness: 0.5,
                                height: height * 0.07,
                                color: Colors.blue,
                              ),
                          itemBuilder: (context, index) =>
                              buildHomeworkCard(
                                  height,
                                  width,
                                  cubit
                                      .homeworkModel!
                                      .homeworksList![index]
                                      .teacher_name!,
                                  cubit.homeworkModel!
                                      .homeworksList![index].subject!,
                                  cubit.homeworkModel!
                                      .homeworksList![index].body!,
                                  cubit.homeworkModel!
                                      .homeworksList![index].date!,
                                  cubit.homeworkModel!
                                      .homeworksList![index].file!,
                                  context,
                                  cubit),
                        )
                            : Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: height/10,),
                            Container(
                              child: Image.asset('assets/image/homweork.gif'),
                            ),
                            Text(
                              'There is No Homework :)',
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 50.sp),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              fallback: (context) => SpinKitApp(width),
            ),
          );
        },
      ),
    );
  }
}
