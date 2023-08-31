


import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school_app/constants.dart';
import 'package:school_app/cubit/notifications&absences/notifications_cubit.dart';
import 'package:school_app/theme/colors.dart';
import 'package:school_app/ui/components/components.dart';
import 'package:school_app/ui/widgets/notific&absen_widgets.dart';

class AbsencesScreen extends StatelessWidget {

  const AbsencesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) => NotificationsCubit()..getAbsences(student_id: isparent ? childId : user_id),
      child: BlocConsumer<NotificationsCubit, NotificationsState>(
        listener: (context, state) {
          var cubit = NotificationsCubit.get(context);

          if (state is GetAbsencesSuccess) {}

          if (state is GetAbsencesError) {
            showToast(text: state.errorModel!.message!, state:ToastState.error);

          }

        },
        builder: (context, state) {
          var cubit = NotificationsCubit.get(context);
          return Scaffold(
            backgroundColor: backgroundColor,
            appBar: null,
            body: ConditionalBuilder(
              condition: cubit.absencesModel != null,
              builder:(context)=> SafeArea(
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
                            Animated_Text_Blue(width: width, text: 'Absences'),
                            absencesImage(height, width),
                          ],
                        ),
                        SizedBox(
                          height: height * 0.04,
                        ),
                        cubit.absencesModel!.absencesList!.isNotEmpty ? ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: cubit.absencesModel!.absencesList!.length,
                          separatorBuilder:
                              (BuildContext context, int index) =>
                              Divider(
                                thickness: 0.5,
                                height: height * 0.07,
                                color: Colors.blue,
                              ),
                          //itemBuilder: (context, index) => buildExpertCardDummy(expertsList[index].id,expertsList[index].rate.toString() ,expertsList[index].name, expertsList[index].type, expertsList[index].price.toString(), expertsList[index].image, expertsList[index].inFavorites,context)
                          itemBuilder: (context, index) => buildAbsencesCard(
                              height,
                              width,
                              cubit.absencesModel!.absencesList![index].name!,
                              cubit.absencesModel!.absencesList![index].date!,
                              cubit.absencesModel!.absencesList![index].dateGood!,
                              context),
                        ) : Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(height: height/10,),
                              Container(
                                child: Image.asset('assets/image/Raising hand.gif'),
                              ),
                              Text(
                                'There is No Absences :)',
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 50.sp),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              fallback: (context)=>SpinKitApp(width),
            ),
          );
        },
      ),
    );
  }
}
