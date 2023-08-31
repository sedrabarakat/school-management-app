import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school_app/cubit/notifications&absences/notifications_cubit.dart';
import 'package:school_app/theme/colors.dart';
import 'package:school_app/ui/components/components.dart';
import 'package:school_app/ui/widgets/notific&absen_widgets.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) => NotificationsCubit()..getNotifications(),
      child: BlocConsumer<NotificationsCubit, NotificationsState>(
        listener: (context, state) {
          var cubit = NotificationsCubit.get(context);

          if (state is GetNotificationsSuccess) {}

          if (state is GetNotificationsError) {
            showToast(
                text: state.errorModel!.message!,
                state: ToastState.error);
            ;
          }
        },
        builder: (context, state) {
          var cubit = NotificationsCubit.get(context);
          return Scaffold(
            backgroundColor: backgroundColor,
            appBar: null,
            body: ConditionalBuilder(
              condition: cubit.notificationsModel != null,
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
                            Animated_Text_Blue(
                                width: width, text: 'Notifications'),
                            Icon(
                              Icons.notification_add_outlined,
                              size: 75.sp,
                              color: Colors.blue.shade700,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height * 0.04,
                        ),
                        cubit.notificationsModel!.notificationsList!.isNotEmpty
                            ? ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: cubit
                                    .notificationsModel!.notificationsList!.length,
                                separatorBuilder: (BuildContext context,
                                        int index) =>
                                    Divider(
                                      thickness: 0.5,
                                      height: height * 0.07,
                                      color: Colors.blue,
                                    ),
                                itemBuilder: (context, index) =>
                                    buildNotificationsCard(
                                        height,
                                        width,
                                        cubit.notificationsModel!
                                            .notificationsList![index].date!,
                                        cubit.notificationsModel!
                                            .notificationsList![index].title!,
                                        cubit.notificationsModel!
                                            .notificationsList![index].body!,
                                        cubit.notificationsModel!
                                            .notificationsList![index].sender!,
                                        context))
                            : Center(
                              child: Column(
                                children: [
                                  SizedBox(height: height/10,),
                                  Container(
                                    child: Image.asset('assets/image/Messages.gif'),
                                  ),
                                  Text(
                                      'There is No Notifications  :(',
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
              fallback: (context) => SpinKitApp(width),
            ),
          );
        },
      ),
    );
  }
}
