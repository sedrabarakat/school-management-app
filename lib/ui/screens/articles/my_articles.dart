

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school_app/cubit/articles/my_articles_cubit.dart';
import 'package:school_app/theme/colors.dart';
import 'package:school_app/ui/components/components.dart';
import 'package:school_app/ui/widgets/articles_widgets.dart';

class MyArticles extends StatelessWidget {
  const MyArticles({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) => MyArticlesCubit(ScrollController())
        ..getArticlesDataTeacher(paginationNumber: 0),
      child: BlocConsumer<MyArticlesCubit, MyArticlesState>(
        listener: (context, state) {
          var cubit = MyArticlesCubit.get(context);

          if (state is GetMyArticleSuccess) {}

          if (state is GetMyArticleError) {
            showToast(text: state.errorModel.message!, state: ToastState.error);
          }

          if (state is DeleteArticleSuccess) {
            showToast(text: 'Deleted Successfully', state: ToastState.success);

            cubit.articlesPaginatedTeacher = [];
            cubit.getAllArticlesTeacher = false;
            cubit.getArticlesDataTeacher(paginationNumber: 0);

          }

          if (state is DeleteArticleError) {
            showToast(text: state.errorModel.message!, state: ToastState.error);
          }
        },
        builder: (context, state) {
          var cubit = MyArticlesCubit.get(context);
          return Scaffold(
            backgroundColor: backgroundColor,
            appBar: null,
            body: ConditionalBuilder(
              condition: (cubit.getAllArticlesTeacher == true),
              builder: (context) => SafeArea(
                child: RefreshIndicator(
                  onRefresh: () async {
                    cubit.articlesPaginatedTeacher = [];
                    cubit.getAllArticlesTeacher = false;
                    await cubit.getArticlesDataTeacher(paginationNumber: 0);
                    await Future.delayed(Duration(seconds: 2));
                    //return await cubit.onRefresh();
                  },
                  child: SingleChildScrollView(
                    controller: cubit.myScrollController,
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: width * 0.05,
                        vertical: height * 0.04,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(onPressed: (){
                                Navigator.pop(context);
                              }, icon: Icon(Icons.arrow_back_outlined,color: Colors.blue,size: 50.sp,)),
                              Animated_Text(
                                  width: width*0.8, text: 'My Articles'),
                              articleImage(height, width),
                            ],
                          ),
                          SizedBox(
                            height: height * 0.05,
                          ),
                          cubit.articlesPaginatedTeacher.isEmpty
                              ? Padding(
                            padding: EdgeInsets.only(top: height * 0.1),
                            child: Center(
                              child: Text(
                                'No Articles found  :(',
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 65.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          )
                              : ListView.separated(
                            shrinkWrap: true,
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                SizedBox(
                                  height: height * 0.04,
                                ),
                            physics: const NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemCount: cubit.articlesModelTeacher != null
                                ? cubit.articlesPaginatedTeacher!.length
                                : cubit.articlesPaginatedTeacher!.length + 1,
                            itemBuilder: (context, index) {
                              if (index <
                                  cubit.articlesPaginatedTeacher!.length) {
                                String role =
                                cubit.articlesPaginatedTeacher![index].role!;
                                bool isAdmin = false;
                                if (role == 'Admin') {
                                  isAdmin = true;
                                } else {
                                  isAdmin = false;
                                }

                                int articleId = cubit
                                    .articlesPaginatedTeacher![index]
                                    .article_id!;

                                String imgPerson = cubit
                                    .articlesPaginatedTeacher![index].imgPerson!;

                                String name =
                                cubit.articlesPaginatedTeacher![index].name!;

                                String date =
                                cubit.articlesPaginatedTeacher![index].date!;

                                String title = cubit
                                    .articlesPaginatedTeacher![index].title!;

                                String body =
                                cubit.articlesPaginatedTeacher![index].body!;

                                String media = cubit
                                    .articlesPaginatedTeacher![index].media!;

                                String extension = '';

                                if (media != '') {
                                  extension = media.split('.').last;
                                  print(extension);
                                }
                                int mediaType = 0;

                                if (extension == 'mkv' ||
                                    extension == 'mp4' ||
                                    extension == 'avi' ||
                                    extension == 'mov') {
                                  // Display video upload form
                                  mediaType = 1;
                                } else if (extension == 'jpg' ||
                                    extension == 'jpeg' ||
                                    extension == 'png' ||
                                    extension == 'gif') {
                                  // Display image upload form
                                  mediaType = 2;
                                }

                                print(media);

                                return buildArticleCard(
                                  context,
                                  width,
                                  height,
                                  cubit,
                                  isAdmin,
                                  articleId,
                                  imgPerson,
                                  name,
                                  date,
                                  title,
                                  body,
                                  media,
                                  mediaType,
                                  1
                                );
                              } else {
                                return SpinKitApp(width);
                              }
                            },
                          ),
                          SizedBox(
                            height: height * 0.06,
                          ),
                        ],
                      ),
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
