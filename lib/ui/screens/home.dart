import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:school_app/cubit/home_cubit.dart';
import 'package:school_app/theme/colors.dart';
import 'package:school_app/theme/styles.dart';
import 'package:school_app/ui/components/components.dart';

import '../../constants.dart';
import '../widgets/home_widgets.dart';



class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    double height = MediaQuery.of(context).size.height;
   double width = MediaQuery.of(context).size.width;
    final padd = MediaQuery.of(context).padding;
    final textSize = MediaQuery.of(context).textScaleFactor;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 5.7;
    final double itemWidth = size.width / 2;

    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
      
      },
      builder: (context, state) {
        var mycubit = HomeCubit.get(context);
        return SafeArea(
          child: AnimatedContainer(
            transform:Mytransform(context),
            duration: Duration(milliseconds: 300),
            decoration: Drawerdecoration(context),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: InkWell(
              splashColor: Colors.transparent,
              onTap: () => {
              if(mycubit.isDrawerOpen)
              mycubit.ChangeDrawer(width,height),
            },
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      Homeimage(height,width),
                      Padding(
                        padding: EdgeInsets.only(
                            right: width * 0.07, top: height * 0.085),
                        child: profilephoto(width),
                      ),
                      if(isteacher==false)
                      Padding(
                        padding:
                            EdgeInsets.only(
                              left: width * 0.7, bottom: height * 0.08),
                        child:circleiconbutton(width,Colors.white, Colors.red, Icons.notifications_active, (){})
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            right: width * 0.85,
                            bottom: height * 0.08),
                        child: circleiconbutton(width,mycubit.drawericonColor,Color.fromARGB(255, 149, 147, 155) , mycubit.drawericon, () {
                            mycubit.ChangeDrawer(width,height);
                          },)                 
                      ),
                    ],
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(left: width * 0.5, right: width * 0.03),
                    child: Text(
                      'batoul khadam aljame',
                      style: mytextstyle(width),
                    ),
                  ),
                  Expanded(
                    child: HomeItemList(height,width, itemWidth, itemHeight, context, isteacher)
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
