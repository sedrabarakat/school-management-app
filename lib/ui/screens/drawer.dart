import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_app/constants.dart';
import 'package:school_app/cubit/home_cubit.dart';
import 'package:school_app/theme/colors.dart';
import 'package:school_app/ui/components/components.dart';
import 'package:school_app/ui/screens/home.dart';
import 'package:school_app/ui/widgets/home_widgets.dart';

class DrawerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

List<dynamic> drawerlist = [
  if(isteacher ==false)
RowIcon(text: 'tuition fees',icon: Icons.person_outline, width: width, context: context,rout: 'tuitionfees',),                 
if(isparent==true)
RowIcon(text: 'Contact US',icon: Icons.chat_bubble_outline, width: width, context: context,rout: 'contactus',height: height),
RowIcon(text: 'Info',icon: Icons.lightbulb_outline, width: width, context: context,rout: 'info',),
RowIcon(text: 'Settings',icon: Icons.error_outline, width: width, context: context,rout: 'settings',),
RowIcon(text: 'Log Out',icon: Icons.logout, width: width, context: context,rout: 'login',),
];
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Container(
          height: height,
          //width: width,
          color: shadow,
          child: Padding(
            padding: EdgeInsets.only(
                top: height * 0.04, left: width * 0.055, bottom: height * 0.05,),
            child: SingleChildScrollView(
              child: Container(
                width: width*0.6,
                color: shadow,
                child: Column(
                  
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    SizedBox(
                     
                      height: height * 0.03,
                    ),
                    logo(height, width),
                    SizedBox(
                      height: height * 0.04,
                    ),
                    if (isteacher == false) student_data(height, width),
                    if (isparent)
                      RowIcon(
                        text: 'Switch Accounts',
                        icon: Icons.account_box,
                        width: width,
                        sufix: HomeCubit.get(context).iconAccounts,
                        context: context,
                      ),
                    if (HomeCubit.get(context).isaccountsShow)
                      Padding(
                        padding: EdgeInsets.only(
                            left: width * 0.1, top: height * 0.02, bottom: 0),
                        child: ListView.separated(
                            itemBuilder: (context, Builder) => ItemAccouns(width),
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            physics: const NeverScrollableScrollPhysics(),
                            separatorBuilder: (context, index) => Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Container(
                                    height: height * 0.001,
                                    width: width,
                                    // color: Color.fromARGB(255, 209, 193, 193),
                                  ),
                                ),
                            itemCount: 3),
                      ),
                      SizedBox(
                        height: height * 0.04,
                      ),
                      ListView.separated(
                            itemBuilder: (context, index) => drawerlist[index],
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            physics: const NeverScrollableScrollPhysics(),
                            separatorBuilder: (context, index) => SizedBox(
                        height: height * 0.04,
                      ),
                            itemCount:drawerlist.length ),
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
