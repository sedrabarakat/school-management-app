import 'package:chewie/chewie.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school_app/constants.dart';
import 'package:school_app/cubit/articles/articles_cubit.dart';
import 'package:school_app/theme/colors.dart';
import 'package:school_app/ui/components/components.dart';
import 'package:school_app/ui/widgets/articles_widgets.dart';
import 'package:video_player/video_player.dart';

class ArticlesScreen extends StatelessWidget {
  ArticlesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (context) => ArticlesCubit(ScrollController())
        ..getArticlesData(paginationNumber: 0),
      child: BlocConsumer<ArticlesCubit, ArticlesState>(
        listener: (context, state) {
          var cubit = ArticlesCubit.get(context);

          if (state is GetArticleSuccess) {}

          if (state is GetArticleError) {
            showToast(text: state.errorModel.message!, state: ToastState.error);
          }

        },
        builder: (context, state) {
          var cubit = ArticlesCubit.get(context);
          return Scaffold(
            backgroundColor: backgroundColor,
            appBar: null,
            body: ConditionalBuilder(
              condition: (cubit.getAllArticles == true),
              builder: (context) => SafeArea(
                child: RefreshIndicator(
                  onRefresh: () async {
                    cubit.articlesPaginated = [];
                    cubit.getAllArticles = false;
                    await cubit.getArticlesData(paginationNumber: 0);
                    await Future.delayed(Duration(seconds: 2));
                    //return await cubit.onRefresh();
                  },
                  child: SingleChildScrollView(
                    controller: cubit.scrollController,
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
                              Animated_Text_Blue(
                                  width: width, text: 'Articles'),
                              isteacher ? buildMyArticlesButton(width, height, context) : Container(),
                            ],
                          ),
                          SizedBox(
                            height: height * 0.05,
                          ),
                          isteacher ? sendArticelWidget(height, width, context) : Container(),
                          SizedBox(
                            height: height * 0.04,
                          ),
                          cubit.articlesPaginated.isEmpty
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
                                  itemCount: cubit.articlesModel != null
                                      ? cubit.articlesPaginated!.length
                                      : cubit.articlesPaginated!.length + 1,
                                  itemBuilder: (context, index) {
                                    if (index <
                                        cubit.articlesPaginated!.length) {
                                      String role =
                                          cubit.articlesPaginated![index].role!;
                                      bool isAdmin = false;
                                      if (role == 'Admin') {
                                        isAdmin = true;
                                      } else {
                                        isAdmin = false;
                                      }

                                      int articleId = cubit
                                          .articlesPaginated![index]
                                          .article_id!;

                                      String imgPerson = cubit
                                          .articlesPaginated![index].imgPerson!;

                                      String name =
                                          cubit.articlesPaginated![index].name!;

                                      String date =
                                          cubit.articlesPaginated![index].date!;

                                      String title = cubit
                                          .articlesPaginated![index].title!;

                                      String body =
                                          cubit.articlesPaginated![index].body!;

                                      String media = cubit
                                          .articlesPaginated![index].media!;

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
                                           0
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
