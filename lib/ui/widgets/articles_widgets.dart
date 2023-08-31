


import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:school_app/cubit/articles/articles_cubit.dart';
import 'package:school_app/theme/colors.dart';
import 'package:school_app/ui/components/components.dart';
import 'package:school_app/ui/widgets/videoController.dart';
import 'package:school_app/ui/widgets/video_helper.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:video_player/video_player.dart';


Widget buildArticleCard(
    context,
    width,
    height,
    cubit,
    bool isAdmin,
    int articleId,
    String imgProfile,
    String name,
    String date,
    String title,
    String body,
    String mediaSrc,
    int mediaType,
    int typeCall,
    ) {
  String dataArticle = timeago.format((DateTime.parse(date)));

  String schoolName = 'Admin';

  return SingleChildScrollView(
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 3),
            color: Colors.blueAccent.withOpacity(0.3),
            blurRadius: 5,
          )
        ],
      ),
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: height * 0.02),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(color: Colors.blue, width: 3),
                      color: Colors.white),
                  clipBehavior: Clip.hardEdge,
                  width: 80,
                  height: 80,
                  child: isAdmin
                      ? Image.asset(
                    'assets/home/logo.png',
                    fit: BoxFit.fill,
                  )
                      : CachedNetworkImage(
                    fadeInCurve: Curves.easeIn,
                    imageUrl: imgProfile,
                    imageBuilder: (context, imageProvider) => CircleAvatar(
                      backgroundImage: imageProvider,
                    ),
                    placeholder: (context, url) => SpinKitApp(width),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  )
              ),
              SizedBox(
                width: width * 0.012,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      isAdmin
                          ? Text(
                        schoolName,
                        maxLines: 1,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30.sp,
                          color: Colors.black,
                        ),
                      )
                          : Text(
                        name,
                        maxLines: 1,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30.sp,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        width: width * 0.005,
                      ),
                      isAdmin
                          ? Image.asset(
                        'assets/images/articles/img1.png',
                        width: 15,
                        height: 15,
                      )
                          : Container(),
                      SizedBox(
                        width: width * 0.01,
                      ),
                      //child: Text('$formattedTime, $formattedDate'),
                      Text(
                        dataArticle,
                        style: TextStyle(
                            fontSize: 27.sp,
                            color: Colors.grey,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.006,
                  ),
                  Text(
                    title,
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w600,
                        fontSize: 30.sp),
                    maxLines: 1,
                  )
                ],
              ),
              SizedBox(
                width: width * 0.15,
              ),
              typeCall == 1?IconButton(
                onPressed: () {
                  awsDialogDeleteArticle(context, width, cubit, 0, articleId);
                },
                icon: Icon(
                  Icons.delete_forever,
                  color: Colors.blue,
                  size: 42.sp,
                ),
              ):Container()
            ],
          ),
          SizedBox(
            height: height * 0.02,
          ),
          mediaType == 0
              ? Container()
              : Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, 1),
                  color: Colors.blue.withOpacity(0.1),
                  blurRadius: 5,
                )
              ],
              color: Colors.white,
            ),
            child: mediaType == 2
                ? CachedNetworkImage(
              imageUrl: mediaSrc,
              placeholder: (context, url) => SpinKitApp(width),
              height: height * 0.3,
              fit: BoxFit.fill,
              width: double.infinity,
            )
                : //VideoHelper(name: name, mediaUrl: mediaSrc)
            ChewieListItem(
              controlsPlace: 20,
              videoPlayerController:
              VideoPlayerController.network(mediaSrc),
            ),
          ),
          SizedBox(
            height: height * 0.02,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: width * 0.01, vertical: height * 0.01),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                isAdmin
                    ? Text(
                  schoolName,
                  maxLines: 1,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25.sp,
                    color: Colors.black,
                  ),
                )
                    : Text(
                  name,
                  maxLines: 1,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25.sp,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  width: width * 0.01,
                ),
                Expanded(
                  child: Text(
                    body,
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 25.sp,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}


Widget buildMyArticlesButton(width,height,context) {
  return Container(
    width: width * 0.25,
    height: height * 0.06,
    decoration: BoxDecoration(
      color: Colors.blue.shade800,
      borderRadius: BorderRadius.circular(12),
    ),
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue.shade800,
        textStyle: TextStyle(),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      onPressed: () {
        Navigator.of(context)
            .pushNamed('/my_articles');
      },
      child: Center(
        child: Text(
          'My Articles',
          style: TextStyle(
              fontSize: 25.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white),
        ),
      ),
    ),
  );
}


Widget sendArticelWidget(height,width,context) {
  return Container(
    height: height * 0.07,
    width: double.infinity,
    //padding: EdgeInsets.symmetric(horizontal: width*0.03),
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(50),
        border: Border.all(
          color: Colors.black,
          width: 2,
        )),
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        textStyle: TextStyle(),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        onPrimary: Colors.grey,
      ),
      onPressed: () {
        Navigator.of(context)
            .pushNamed('/send_article');
      },
      child: Row(
        mainAxisAlignment:
        MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Add an Article',
            style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w300,
                fontSize: 30.sp,
                letterSpacing: 2),
          ),
          Icon(
            Icons.image_outlined,
            color: Colors.black,
            size: 60.sp,
          )
        ],
      ),
    ),
  );
}


Widget articleImage(height,width) {
  return Image.asset('assets/images/articles/article.png',height: height*0.1,width: width*0.1,);
}


Widget clearButtonArticle (width,height,ArticlesCubit cubit) {
  return Container(
    width: width*0.2,
    height: height * 0.04,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Colors.blue,
    ),
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red,
        textStyle: const TextStyle(),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onPressed: () {
        cubit.clearControllers();
      },
      child: Text(
        'Clear',
        style:
        TextStyle(fontSize: 30.sp, color: Colors.white),
      ),
    ),
  );
}

Widget articleAnimationImage(height, width) {
  return Lottie.asset('assets/animations/article.json',height: height*0.1,width:width*0.4 , fit: BoxFit.fill,
  );
}


Widget publishArticleButton(width, height,formKeySendArticle,context,ArticlesCubit cubit) {
  return Container(
    width: width * 0.4,
    height: height * 0.05,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Colors.blue,
    ),
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: basicColor,
        textStyle: const TextStyle(),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onPressed: () {
        if (formKeySendArticle.currentState!.validate()) {
          awsDialogUploading(context, width, cubit, 0);
        }
      },

      child: Text(
        'Publish',
        style:
        TextStyle(fontSize: 30.sp, color: Colors.white),
      ),
    ),
  );
}

Future<Object?> awsDialogDeleteArticle(
    context, width, cubit, typeCall, int articleId) {
  return AwesomeDialog(
      context: context,
      dialogType: DialogType.warning,
      borderSide: const BorderSide(
        color: Colors.yellow,
        width: 2,
      ),
      buttonsBorderRadius: const BorderRadius.all(
        Radius.circular(2),
      ),
      dismissOnTouchOutside: false,
      dismissOnBackKeyPress: false,
      headerAnimationLoop: true,
      animType: AnimType.topSlide,
      title: 'Warning',
      desc: 'Do you want to Delete the article?',
      showCloseIcon: true,
      btnCancelOnPress: () {},
      btnOkOnPress: () {
        cubit.deleteOneArticlesTeacherData(id: articleId);
      }).show();
}

Future<Object?> awsDialogUploading(
    context, width, ArticlesCubit cubit, typeCall) {
  return AwesomeDialog(
      context: context,
      dialogType: DialogType.warning,
      borderSide: const BorderSide(
        color: Colors.yellow,
        width: 2,
      ),
      buttonsBorderRadius: const BorderRadius.all(
        Radius.circular(2),
      ),
      dismissOnTouchOutside: false,
      dismissOnBackKeyPress: false,
      headerAnimationLoop: true,
      animType: AnimType.topSlide,
      title: 'Warning',
      desc: 'Do you want to publish?',
      showCloseIcon: true,
      btnCancelOnPress: () {},
      btnOkOnPress: () {
        cubit.sendArticle(
            title: cubit.titleController.text, body: cubit.bodyController.text);
      }).show();
}