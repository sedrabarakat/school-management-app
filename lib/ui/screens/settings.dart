import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school_app/cubit/notifications&absences/notifications_cubit.dart';
import 'package:school_app/cubit/settings_cubit.dart';
import 'package:school_app/theme/colors.dart';
import 'package:school_app/ui/components/components.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return BlocConsumer<NotificationsCubit, NotificationsState>(
      listener: (context, state) {},
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.settings,
                          size: 75.sp,
                          color: Colors.blue,
                        ),
                        SizedBox(
                          width: width * 0.03,
                        ),
                        Animated_Text_Blue(width: width, text: 'Settings'),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.025,
                    ),
                    ListView.separated(
                        itemBuilder: (context, index) => ElevatedButton(
                          onPressed: (){},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: backgroundColor,
                            padding: EdgeInsets.symmetric(horizontal: width*0.022,vertical: height*0.04),
                          ),
                          child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(settingsList[index].iconData,color: Colors.blueGrey,size: 50.sp,),
                                      SizedBox(width: width*0.05,),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${settingsList[index].title}',
                                            style: TextStyle(fontWeight: FontWeight.w600,fontSize: 45.sp,color: Colors.blue),
                                          ),
                                          SizedBox(height: height*0.012,),
                                          Text(
                                            '${settingsList[index].desc}',
                                            style: TextStyle(fontWeight: FontWeight.w300,fontSize: 35.sp,color: Colors.grey),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Icon(Icons.arrow_right_alt,color: Colors.black,size: 60.sp,),
                                ],
                              ),
                        ),
                        separatorBuilder: (BuildContext context, int index) =>
                            SizedBox(
                              height: height*0.02,
                            ),
                        shrinkWrap: true,
                        itemCount: settingsList.length),
                    /*Container(
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
                    )*/
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

class Settings {
  final IconData iconData;
  final String title;
  final String desc;

  Settings(this.iconData, this.title, this.desc);
}

List<Settings> settingsList = [
  Settings(Icons.language, 'Language', 'Change language here.',),
  Settings(Icons.light_mode, 'App Mode', 'Modify the mode of the app.',),
  Settings(
      Icons.question_answer,
      'Common Questions',
      'Read people questions here.',
  ),
  Settings(
    Icons.contact_support,
    'Contact us',
    'Feel free to reach out to us.',
  ),
  Settings(
    Icons.info,
    'About us',
    'Know more about us',
  ),
];
