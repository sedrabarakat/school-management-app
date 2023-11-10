import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:school_app/constants.dart';
import 'package:school_app/cubit/marks/marks_cubit.dart';
import 'package:school_app/theme/colors.dart';
import 'package:school_app/ui/components/components.dart';
import 'package:school_app/ui/widgets/marks_widgets.dart';

class MarksScreen extends StatelessWidget {
  const MarksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) => MarksCubit()..getMarksWithType(user_id: isparent ? childId : user_id, type_id: 0),
      child: BlocConsumer<MarksCubit, MarksState>(
        listener: (context, state) {
          var cubit = MarksCubit.get(context);
        },
        builder: (context, state) {
          var cubit = MarksCubit.get(context);
          return Scaffold(
            backgroundColor: backgroundColor,
            appBar: null,
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: width * 0.05,
                    vertical: height * 0.04,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Animated_Text_Blue(width: width, text: 'Marks'),
                          markImage(height, width),
                        ],
                      ),
                      SizedBox(
                        height: height * 0.03,
                      ),
                      SizedBox(
                        height: height * 0.14,
                        child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            physics: BouncingScrollPhysics(),
                            padding: EdgeInsets.zero,
                            itemBuilder: (context, index) => buildMarkTypeCard(
                                height,
                                width,
                                marksType[index].id!,
                                marksType[index].marksTypeName!,
                                marksType[index].iconData!,
                                cubit,
                                context),
                            separatorBuilder: (context, index) => SizedBox(
                                  width: width * 0.04,
                                ),
                            itemCount: marksType.length),
                      ),
                      SizedBox(
                        height: height * 0.04,
                      ),
                      ConditionalBuilder(
                        condition: cubit.marksModel != null,
                        builder:(context)=> Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Total Score:',
                                  style: TextStyle(fontSize: 55.sp, color: Colors.blue,fontWeight: FontWeight.bold,),
                                ),
                                SizedBox(
                                  width: width * 0.1,
                                ),
                                CircularPercentIndicator(
                                  animation: true,
                                  animationDuration: 1500,
                                  radius: 120.r,
                                  lineWidth: width*0.04,
                                  percent: cubit.marksModel!.data!.percentage!/100,
                                  progressColor: Colors.blue,
                                  backgroundColor: Color(0xFFECECEC),
                                  circularStrokeCap: CircularStrokeCap.round,
                                  center: Text(
                                    '${cubit.marksModel!.data!.percentage!.toStringAsFixed(1)}%',
                                    style: TextStyle(fontSize: 34.sp, color: Colors.blue,fontWeight: FontWeight.w800),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: height * 0.04,
                                ),
                                ListView.separated(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: cubit.marksModel!.data!.marksStudentData!.length,
                                  separatorBuilder:
                                      (BuildContext context, int index) => SizedBox(
                                    height: height * 0.02,
                                  ),
                                  //itemBuilder: (context, index) => buildExpertCardDummy(expertsList[index].id,expertsList[index].rate.toString() ,expertsList[index].name, expertsList[index].type, expertsList[index].price.toString(), expertsList[index].image, expertsList[index].inFavorites,context)
                                  itemBuilder: (context, index) => buildMarkCard(
                                      height,
                                      width,
                                      cubit.marksModel!.data!
                                          .marksStudentData![index].sub_name!,
                                      cubit.marksModel!.data!
                                          .marksStudentData![index].mark!
                                          .toString(),
                                      '100',
                                      cubit.marksModel!.data!
                                          .marksStudentData![index].date!,
                                      context),
                                ),
                              ],
                            )
                          ],
                        ),
                        fallback: (context)=>Column(
                          children: [
                            SizedBox(height: height*0.06,),
                            SpinKitApp(width),
                          ],
                        ),
                      )
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

class MarksType {
  int? id;
  IconData? iconData;
  String? marksTypeName;

  MarksType(this.id, this.iconData, this.marksTypeName);
}
