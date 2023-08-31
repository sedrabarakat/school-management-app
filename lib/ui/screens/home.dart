import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_app/cubit/auth_cubit.dart';
import 'package:school_app/cubit/home_cubit.dart';
import 'package:school_app/theme/colors.dart';
import 'package:school_app/theme/styles.dart';
import 'package:school_app/ui/components/components.dart';
import 'package:school_app/ui/screens/drawer.dart';

import '../../constants.dart';
import '../widgets/home_widgets.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}
//Color(0xFFD3E9FB)
class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    //HomeCubit.get(context).animationController = AnimationController(vsync: this,duration: Duration(seconds: 5));

    //HomeCubit.get(context).init();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final padd = MediaQuery.of(context).padding;
    final textSize = MediaQuery.of(context).textScaleFactor;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 5.7;
    final double itemWidth = size.width / 2;
    return BlocProvider(
      create: (context) => HomeCubit()..getHomeData(),
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          var cubit = HomeCubit.get(context);
          if (state is LogoutSuccessState) {
            showToast(text: state.logoutModel.message!, state: ToastState.success);
            signOut(context);
          }

          if (state is LogoutErrorState) {
            showToast(text: state.errorModel.message!, state: ToastState.error);
            signOut(context);
          }

        },
        builder: (context, state) {
          var cubit = HomeCubit.get(context);
          return Scaffold(
            backgroundColor: shadow,
            appBar: null,
            body: ConditionalBuilder(
              condition: cubit.homeModel != null,
              builder: (context) => SafeArea(
                child: Stack(
                  children: [
                    DrawerWidget(height, width, context, cubit),
                    AnimatedContainer(
                      transform: Mytransform(context),
                      duration: Duration(milliseconds: 300),
                      decoration: Drawerdecoration(context),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: InkWell(
                        splashColor: Colors.transparent,
                        onTap: () => {
                          if (cubit.isDrawerOpen)
                            cubit.ChangeDrawer(width, height),
                        },
                        child: Stack(
                          children: [
                            Padding(
                              padding:  EdgeInsets.only(top: height/4.5,
                                  bottom: (isteacher == false)? height/27:height/2.6),
                              child: HomeItemList(
                                  height,
                                  width,
                                  itemWidth,
                                  itemHeight,
                                  context,
                                  isteacher),
                            ),
                            Homeimage(height, width),
                            if (isteacher == false)
                              Padding(
                                padding: EdgeInsets.only(
                                    left: width/1.15,
                                    bottom: height * 0.08),
                                child: circleiconbutton(
                                  width,
                                  Colors.white,
                                  Colors.black54,
                                  Icons.notifications_active,
                                      () {
                                    Navigator.of(context)
                                        .pushNamed('/notifications');
                                  },
                                ),
                              ),
                            Padding(
                                padding: EdgeInsets.only(
                                    right: width * 0.85,
                                    bottom: height * 0.08),
                                child: circleiconbutton(
                                  width,
                                  cubit.drawericonColor,
                                  Colors.black54,
                                  cubit.drawericon,
                                      () {
                                    cubit.ChangeDrawer(width, height);
                                  },
                                )),
                            Padding(
                              padding:  EdgeInsets.only(
                                left: height/30,
                                right: height/30,
                                top: height/9
                              ),
                              child: Container(
                                width: width,height: height/8,
                                decoration: BoxDecoration(
                                    color: Colors.white70,
                                    borderRadius: BorderRadius.circular(30)
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                    padding: EdgeInsets.only(left: width/30,top: height/60,bottom: height/60),
                                    child: Container(
                                      height: height/4,width: width/4,
                                      decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                      child: (cubit.homeModel!.data!.user!.img !=null)?CachedNetworkImage(
                                        imageUrl: cubit.homeModel!.data!.user!.img!,
                                        progressIndicatorBuilder: (context, url, downloadProgress) =>
                                            CircularProgressIndicator(value: downloadProgress.progress),
                                        errorWidget: (context, url, error) => Image.asset('assets/image/user.png'),
                                      ):
                                      Image.asset('assets/image/user.png'),
                                    ),
                                  ),
                                    Padding(
                                      padding: EdgeInsets.only(top: height/30),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('${cubit.homeModel!.data!.user!.name!}',
                                          style: TextStyle(
                                            fontSize: width/20,
                                            color: Colors.black,
                                          ),
                                          ),
                                          SizedBox(height: height/70,),
                                          if (isteacher == false)
                                          Row(children: [
                                            SizedBox(
                                              width:width/5,
                                              child: Text('Class : ${cubit.homeModel!.data!.user!.grade}',
                                                style: TextStyle(
                                                    fontSize: width/30,
                                                    color: Colors.black45,
                                                    overflow: TextOverflow.ellipsis
                                                ),),
                                            ),
                                            SizedBox(
                                              width:width/5,
                                              child: Text('Grade: ${cubit.homeModel!.data!.user!.section_number}',
                                                style: TextStyle(
                                                    fontSize: width/30,
                                                    color: Colors.black45,
                                                    overflow: TextOverflow.ellipsis
                                                ),),
                                            )
                                          ],)
                                        ],
                                      ),
                                    )
                                ],),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
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
/*Container(
                height: height,width: width,
                color: Colors.white,
                child: Center(child: Image.asset('assets/image/Education.gif')),
              ),*/
/*AppBar(
              elevation: 0,
              backgroundColor: Color.fromARGB(255, 1, 60, 105),
              actions: [
                if (isteacher == false)
                  IconButton(onPressed:   () {
                    Navigator.of(context)
                        .pushNamed('/notifications');
                  },
                      icon:  Icon(Icons.notifications_active))

              ],
            ),*/

/*Padding(
                              padding: EdgeInsets.only(
                                  left: width * 0.5, top: height * 0.01),
                              child: Text(
                                cubit.homeModel!.data!.user!.childHomeData!
                                    .isEmpty
                                    ? cubit.homeModel!.data!.user!.name!
                                    : cubit.homeModel!.data!.user!
                                    .childHomeData![cubit.childIndex].name!,
                                style: mytextstyle(width),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),*/

//the img
/*cubit.homeModel!.data!.user!.childHomeData!
                                    .isEmpty
                                    ? Padding(
                                  padding: EdgeInsets.only(
                                      right: width * 0.13,
                                      top: height * 0.11),
                                  child: profileUserPhoto(width,
                                      cubit.homeModel!.data!.user!.img!),
                                )
                                    : Padding(
                                  padding: EdgeInsets.only(
                                      right: width * 0.13,
                                      top: height * 0.11),
                                  child: profileUserPhoto(
                                      width,
                                      cubit
                                          .homeModel!
                                          .data!
                                          .user!
                                          .childHomeData![
                                      cubit.childIndex]
                                          .img!),
                                ),*/