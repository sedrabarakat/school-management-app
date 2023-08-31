import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:school_app/cubit/articles/articles_cubit.dart';
import 'package:school_app/theme/colors.dart';
import 'package:school_app/ui/components/components.dart';
import 'package:school_app/ui/widgets/articles_widgets.dart';
import 'package:school_app/ui/widgets/videoController.dart';
import 'package:video_player/video_player.dart';

var formKeySendArticle = GlobalKey<FormState>();

class SendArticle extends StatefulWidget {
  SendArticle({Key? key}) : super(key: key);

  @override
  State<SendArticle> createState() => _SendArticleState();
}

class _SendArticleState extends State<SendArticle> {
  var titleFocusNode = FocusNode();

  var bodyFocusNode = FocusNode();

  var emojiFocusNode = FocusNode();

  ScrollController? scrollController;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return BlocConsumer<ArticlesCubit, ArticlesState>(
      listener: (context, state) {
        var cubit = ArticlesCubit.get(context);

        if (state is SendArticleLoading) {}

        if (state is SendArticleSuccess) {
          cubit.clearControllers();
          cubit.stringProgress = '0.0%';
          cubit.doubleProgress = 0.0;
          cubit.getArticlesData(paginationNumber: 0);
          showToast(text: 'Published Successfully', state: ToastState.success);
        }

        if (state is SendArticleError) {
          cubit.stringProgress = '0.0%';
          cubit.doubleProgress = 0.0;
          showToast(text: state.errorModel.message!, state: ToastState.error);
        }
      },
      builder: (context, state) {
        var cubit = ArticlesCubit.get(context);
        return WillPopScope(
          onWillPop: () async {
            cubit.clearControllers();

            return true;
          },
          child: GestureDetector(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: Scaffold(
              backgroundColor: backgroundColor,
              appBar: null,
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: width * 0.02, vertical: height * 0.02),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: height * 0.03,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                                onPressed: () {
                                  cubit.clearControllers();
                                  Navigator.pop(context);
                                },
                                icon: Icon(
                                  Icons.arrow_back_outlined,
                                  color: Colors.blue,
                                  size: 50.sp,
                                )),
                            SizedBox(
                              width: width * 0.05,
                            ),
                            Animated_Text_Blue(width: width, text: 'Add Article'),
                            SizedBox(
                              width: width * 0.05,
                            ),
                            clearButtonArticle(width, height, cubit),
                          ],
                        ),
                        SizedBox(
                          height: height * 0.05,
                        ),
                        Form(
                          key: formKeySendArticle,
                          child: Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: width * 0.05),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Title',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 55.sp),
                                        ),
                                        SizedBox(
                                          height: height * 0.02,
                                        ),
                                        Container(
                                          width: width * 0.4,
                                          child: def_TextFromField(
                                            onTap: () {
                                              if (cubit.emoji_open) {
                                                ArticlesCubit.get(context)
                                                    .close_emoji();
                                                FocusScope.of(context)
                                                    .requestFocus(
                                                        emojiFocusNode);
                                                SystemChannels.textInput
                                                    .invokeMethod(
                                                        'TextInput.show');
                                              }
                                            },
                                            fillColor: Colors.white,
                                            onFieldSubmitted: (value) {
                                              FocusScope.of(context)
                                                  .requestFocus(bodyFocusNode);
                                            },
                                            keyboardType: TextInputType.text,
                                            controller: cubit.titleController,
                                            focusNode: titleFocusNode,
                                            br: 12.0,
                                            maxLines: 1,
                                            label: 'A journey event',
                                            borderNormalColor: Colors.black,
                                            borderFocusedColor: Colors.blue,
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'Please enter the title of the article';
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: width * 0.06,
                                    ),
                                    articleAnimationImage(height, width)
                                  ],
                                ),
                                SizedBox(
                                  height: height * 0.05,
                                ),
                                cubit.mediaStatus == null
                                    ? Container(
                                        width: double.infinity,
                                        height: height * 0.35,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: Material(
                                          color: Colors.transparent,
                                          child: InkWell(
                                            hoverColor: Color(0xFFE2E2E2),
                                            focusColor: Colors.grey,
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            splashColor: Colors.grey,
                                            onTap: () {
                                              cubit.pickMedia();
                                            },
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.image_outlined,
                                                  size: 100.sp,
                                                  color: Colors.blue.shade800,
                                                ),
                                                SizedBox(
                                                  height: height * 0.06,
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.all(15),
                                                  child: Text(
                                                    '(Optional): Add an image or video that complements your article.',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 40.sp,
                                                        fontWeight:
                                                            FontWeight.w100),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                    : cubit.mediaStatus == 1
                                        ? Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              ChewieListItem(
                                                controlsPlace: 20,
                                                videoPlayerController:
                                                    VideoPlayerController.file(
                                                        cubit.mediaFile!),
                                              ),
                                              SizedBox(
                                                height: height * 0.01,
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  cubit.pickMedia();
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      color: Colors.blue),
                                                  width: width * 0.35,
                                                  height: height * 0.04,
                                                  child: Center(
                                                    child: Text(
                                                      'Edit',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 30.sp,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        : Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                width: double.infinity,
                                                height: height * 0.35,
                                                child: Image.file(
                                                  cubit.mediaFile!,
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                              SizedBox(
                                                height: height * 0.01,
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  cubit.pickMedia();
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      color: Colors.blue),
                                                  width: width * 0.4,
                                                  height: height * 0.05,
                                                  child: Center(
                                                    child: Text(
                                                      'Edit',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 25.sp,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                SizedBox(
                                  height: height * 0.03,
                                ),
                                Text(
                                  'Description',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 32.sp),
                                ),
                                SizedBox(
                                  height: height * 0.01,
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  child: def_TextFromField(
                                    onTap: () {
                                      if (cubit.emoji_open) {
                                        ArticlesCubit.get(context)
                                            .close_emoji();
                                        FocusScope.of(context)
                                            .requestFocus(bodyFocusNode);
                                        SystemChannels.textInput
                                            .invokeMethod('TextInput.show');
                                      }
                                    },
                                    onFieldSubmitted: (value) {
                                      FocusManager.instance.primaryFocus
                                          ?.unfocus();
                                    },
                                    onChanged: (value) {
                                      cubit.counterTextformField(value.length);
                                    },
                                    counterText: '${cubit.counterText}/3000',
                                    fillColor: Colors.white,
                                    maxLength: 3000,
                                    maxLengthEnforcement:
                                        MaxLengthEnforcement.enforced,
                                    keyboardType: (cubit.emoji_open)
                                        ? TextInputType.none
                                        : TextInputType.text,
                                    controller: cubit.bodyController,
                                    focusNode: bodyFocusNode,
                                    br: 12.0,
                                    minLines: 13,
                                    maxLines: 13,
                                    label: '',
                                    borderNormalColor: Colors.black,
                                    borderFocusedColor: Colors.blue,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter the description of the article';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: height * 0.03,
                        ),
                        ConditionalBuilder(
                          condition: cubit.doubleProgress == 0.0,
                          builder: (context) => publishArticleButton(width,
                              height, formKeySendArticle, context, cubit),
                          fallback: (context) => CircularPercentIndicator(
                            animation: false,
                            animationDuration: 1000,
                            radius: 80.r,
                            lineWidth: 7,
                            percent: cubit.doubleProgress,
                            progressColor: Colors.blue,
                            backgroundColor: Colors.blue.shade200,
                            circularStrokeCap: CircularStrokeCap.round,
                            center: Text(
                              cubit.stringProgress,
                              style: TextStyle(
                                  fontSize: 18.sp, color: Colors.blue),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
