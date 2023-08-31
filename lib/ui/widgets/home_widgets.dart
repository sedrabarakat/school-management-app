// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:school_app/constants.dart';
import 'package:school_app/cubit/home_cubit.dart';
import 'package:school_app/theme/colors.dart';
import 'package:school_app/theme/styles.dart';
import 'package:school_app/ui/components/components.dart';

class MyCustomCliper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    // path.lineTo(0, size.height / 1);
    // path.lineTo(size.width, size.height / 1.5);
    // path.lineTo(size.width, 0);

    // path.lineTo(0, size.height/3);
    // path.quadraticBezierTo(
    //    size.width / 2, size.height*1.5, size.width, size.height / 3);
    // path.lineTo(size.width, 0);

    path.lineTo(0, size.height);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height / 2);
    path.lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
    //throw UnimplementedError();
  }
}

Widget homeitem(width, height, context, Route, title, icon, color) {
  return InkWell(
    onTap: () {
      if (HomeCubit.get(context).isDrawerOpen == true)
        HomeCubit.get(context).ChangeDrawer(width, height);
      else
        Navigator.of(context).pushNamed('/$Route');
    },
    child: Center(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        height: height * 0.4,
        width: width * 0.35,
        decoration: boxdecorationitem(Colors.white, -7.0, 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: height * 0.01,
            ),
            Container(
                height: height * 0.07,
                width: width * 0.18,
                decoration: boxdecorationitem(color, 0, 0),
                child: Icon(
                  icon,
                  size: width * 0.09,
                  color: Colors.white,
                )),
            SizedBox(
              height: height * 0.01,
            ),
            Text(
              '$title',
              style: TextStyle(
                color: Color.fromARGB(255, 53, 53, 51),
                fontSize: width * 0.04,
                fontWeight: FontWeight.w700,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    ),
  );
}

Widget ItemAccouns(width,HomeCubit cubit,index, String name, int childId) {
  return InkWell(
      onTap: () {
        cubit.changeChildIndex(index,childId);
      },
      child: Text(
        name,
        style: TextStyle(
            fontSize: width * 0.045,
            fontWeight: FontWeight.w400,
            color: Colors.white),
      ));
}

Matrix4 Mytransform(context) {
  return Matrix4.translationValues(
      HomeCubit.get(context).xOffset, HomeCubit.get(context).yOffset, 0)
    ..scale(HomeCubit.get(context).isDrawerOpen ? 0.85 : 1.00)
  //..rotateZ(mycubit.isDrawerOpen ? -50 : 0)
    ..scale(HomeCubit.get(context).scalfactor);
}

BoxDecoration Drawerdecoration(context) {
  return HomeCubit.get(context).isDrawerOpen
      ? boxdecorationitem(
    Color.fromARGB(255, 234, 241, 246),
    0,
    0,
    circler: 60,
    blurRadius: 20,
    spreadRadius: 15,
    colorshado: Color.fromARGB(66, 174, 196, 245),
  )
      : boxdecorationitem(
    Color.fromARGB(255, 234, 241, 246),
    0,
    0,
    circler: 0,
    blurRadius: 20,
    spreadRadius: 15,
    colorshado: Color.fromARGB(66, 245, 174, 174),
  );
}

ClipPath Homeimage(height, width) {
  return ClipPath(
    clipper: OvalBottomBorderClipper(),
    child: Container(
      width: width,
      height: height * 0.22,
      decoration: BoxDecoration(
        color: shadow,
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Image.asset('assets/image/blue2.jpeg',fit: BoxFit.fill,),
    ),

  );
}

CircleAvatar profileParentPhoto(width) {
  return CircleAvatar(
    radius: width! * 0.11,
    backgroundColor: Colors.white,
    backgroundImage: AssetImage('assets/home/par.png'),
  );
}

Widget profileUserPhoto(width, img) {
  return CachedNetworkImage(
    fadeInCurve: Curves.easeIn,
    imageUrl: img,
    imageBuilder: (context, imageProvider) => CircleAvatar(
      radius: width! * 0.11,
      backgroundImage: imageProvider,
    ),
    placeholder: (context, url) => SpinKitApp(width),
    errorWidget: (context, url, error) => Icon(Icons.error),
  );
}

Widget HomeItemList(height, width, itemWidth, itemHeight, context, isteacher) {
  List<dynamic> homelist = [
    homeitem(width, height, context, 'articles', 'School_News', Icons.article,
        Colors.lightBlueAccent),
    homeitem(width, height, context, 'chat_list', 'Chat', Icons.chat,
        Colors.lightBlueAccent),
    if (isteacher)
    homeitem(width, height, context, 'homework_teacher', 'Homework', Icons.home_work,
        Colors.blue),
    if (!isteacher)
      homeitem(width, height, context, 'homework_Student', 'Homework', Icons.home_work,
          Colors.blue),
    homeitem(width, height, context, 'schedule', 'Schedule', Icons.schedule,
        Colors.blue),
    if ((isteacher == false))
      homeitem(width, height, context, 'library', 'Library',
          Icons.menu_book_outlined, Color.fromARGB(255, 18, 170, 225)),
    if ((isteacher == false))
      homeitem(width, height, context, 'course', 'Courses', Icons.class_sharp,
          Color.fromARGB(255, 18, 170, 225)),
    if (isteacher == false)
      homeitem(width, height, context, 'absences', 'Absences',
          Icons.person_remove, Color.fromARGB(255, 24, 130, 216)),
    if (isteacher == false)
      homeitem(width, height, context, 'marks', 'Marks', Icons.school,
          Color.fromARGB(255, 24, 130, 216)),
  ];

  return AnimationLimiter(
    child: GridView.count(
      padding: EdgeInsets.only(
        left: width * 0.07,
        right: width * 0.07,
        top: height * 0.03,
      ),
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      //controller: new ScrollController(keepScrollOffset: true),
      scrollDirection: Axis.vertical,
      crossAxisCount: 2,
      childAspectRatio: (itemWidth / itemHeight),
      mainAxisSpacing: height * 0.045,
      crossAxisSpacing: width /20,
      children: List.generate(homelist.length, (index) {
        return AnimationConfiguration.staggeredGrid(
            position: index,
            columnCount: 20,
            child: ScaleAnimation(
              duration: Duration(milliseconds: 750),
              child: FadeInAnimation(child: homelist[index]),
            ));
      }),
    ),
  );
}

Column student_data(height, width, HomeCubit cubit) {
  return Column(children: <Widget>[
    RowText(
        text1: 'Name:',
        text2: cubit.homeModel!.data!.user!.childHomeData!.isEmpty
            ? cubit.homeModel!.data!.user!.name!
            : cubit
            .homeModel!.data!.user!.childHomeData![cubit.childIndex].name!,
        width: width),
    SizedBox(
      height: height * 0.017,
    ),
    RowText(
        text1: 'Class:',
        text2: cubit.homeModel!.data!.user!.childHomeData!.isEmpty
            ? Mapclasses[cubit.homeModel!.data!.user!.grade!]
            : Mapclasses[cubit
            .homeModel!.data!.user!.childHomeData![cubit.childIndex].grade!],
        width: width),
    SizedBox(
      height: height * 0.017,
    ),
    RowText(text1: 'Section:', text2: cubit.homeModel!.data!.user!.childHomeData!.isEmpty
        ? cubit.homeModel!.data!.user!.section_number!.toString()
        : cubit
        .homeModel!.data!.user!.childHomeData![cubit.childIndex].section_number!.toString()!, width: width),
    SizedBox(
      height: height * 0.04,
    ),
  ]);
}
