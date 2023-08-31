import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school_app/cubit/notifications&absences/notifications_cubit.dart';
import 'package:school_app/cubit/settings_cubit.dart';
import 'package:school_app/theme/colors.dart';
import 'package:school_app/ui/components/components.dart';
import 'package:school_app/ui/widgets/notific&absen_widgets.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return BlocConsumer<NotificationsCubit, NotificationsState>(
      listener: (context, state) {

      },
      builder: (context, state) {
        var cubit = SettingsCubit.get(context);
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Animated_Text_Blue(
                            width: width, text: 'Settings'),
                        Icon(
                          Icons.settings,
                          size: 75.sp,
                          color: Colors.purple,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.04,
                    ),
                    Container(
                      width: width*0.3,
                      height: height*0.5,
                      padding: EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Inbox',style: TextStyle(fontSize: 40.sp,fontWeight: FontWeight.w600,),),
                          SizedBox(height: height*0.05,),
                          Text("This app was made by SBBRO, We're waiting for the new customer that will come to us and but this app",style: TextStyle(fontSize: 40.sp,fontWeight: FontWeight.w600,color: Colors.purple),),

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
    );
  }
}
