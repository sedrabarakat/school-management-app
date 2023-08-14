import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_app/constants.dart';
import 'package:school_app/models/articles_model.dart';
import 'package:school_app/models/error_model.dart';
import 'package:school_app/network/remote/dio_helper.dart';

part 'articles_state.dart';

class ArticlesCubit extends Cubit<ArticlesState> {
  // Scroll
  ScrollController scrollController;


  ArticlesCubit(this.scrollController) : super(ArticlesInitial()) {
    scrollController = ScrollController();

    scrollController.addListener(_scrollListener);

  }

  Future<void> _scrollListener() async {
    if (articlesModel == null) return;


    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent && currentIndex+1 != paginationNumberSave) {

      currentIndex++;

      await getArticlesData(paginationNumber: currentIndex);
    }
  }


  @override
  Future<void> close() {
    scrollController.dispose();

    return super.close();
  }

  // Refresh

  Future<void> onRefresh() async {

    articlesPaginated = [];
    await getArticlesData(paginationNumber: 0);
    emit(OnRefreshState());

  }



///////////////////////////////////////////////////////////////////////////////
  static ArticlesCubit get(context) => BlocProvider.of(context);

  // Pick Media

  File? mediaFile;

  String? mediaFileName;

  int? mediaStatus;

  Future pickMedia() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowMultiple: false,
        allowedExtensions: ['png', 'jpg', 'jpeg', 'mp4', 'mvk', 'avl', 'gif'],
      );

      if (result != null) {
        PlatformFile platformMediaFile = result.files.first;
        String path = result.files.first.path!;
        mediaFile = File(path);
        mediaFileName = result.files.first.name;

        print(result.files.first.extension);

        //Size in Bytes
        print(result.files.first.size);

        String extension = result.files.first.extension!;

        if (extension == 'mkv' ||
            extension == 'mp4' ||
            extension == 'avi' ||
            extension == 'mov') {
          // Display video upload form
          mediaStatus = 1;
        } else if (extension == 'jpg' ||
            extension == 'jpeg' ||
            extension == 'png' ||
            extension == 'gif') {
          // Display image upload form
          mediaStatus = 2;
        } else {
          // File type not supported
          print('Unsupported file type');
        }

      }
    } on PlatformException {
      print('Failed to pick image');
    }
    emit(PickMediaFile());
  }

  /////////////////////////////////////////////////////////////////////////////

  int? counterText = 0;

  void counterTextformField(value) {
    counterText = value;
    emit(ChangeCounter());
  }

  var titleController = TextEditingController();

  var bodyController = TextEditingController();

  void clearControllers() {
    titleController.clear();

    bodyController.clear();

    counterText = 0;

    ///////////
    // Image & Video

    mediaStatus = null;

    mediaFile = null;

    /////////////////////////////////////////////////

    // Uploading error or success

    doubleProgress = 0.0;

    emit(ClearDataState());
  }

  //Emoji

  bool emoji_open = false;

  //j
  void open() {
    emoji_open = !emoji_open;
    emit(OpenEmojiKeyboard());
  }

  Future close_emoji() async {
    emoji_open = false;
    emit(CloseEmojiKeyboard());
  }

  ////////////////////////////////////////////////////////////////////////////

  ErrorModel? errorModel;

  String stringProgress = '0.0%';

  double doubleProgress = 0.0;

  //Send Article
  Future<void> sendArticle({
    required String title,
    required String body,
  }) async {
    emit(SendArticleLoading());

    if (mediaFile == null) {
      DioHelper.postDataImage(
          url: 'createArticle',
          data: FormData.fromMap(
            {
              'title': title,
              'body': body,
            },
          ),
          token: token,
          onSendProgress: (int sent, int total) {
            String percentage = (sent / total * 100).toStringAsFixed(2);
            stringProgress = '$percentage%';
            doubleProgress = (sent / total);

            print(stringProgress);
            print(doubleProgress);

            emit(ChangeProgress());
          }).then((value) async {
        print('value.data: ${value.data}');

        emit(SendArticleSuccess());
      }).catchError((error) {
        print('error.response.data: ${error.response.data}');
        errorModel = ErrorModel.fromJson(error.response.data);
        emit(SendArticleError(errorModel!));
        print(error.toString());
      });
    } else {
      DioHelper.postDataImage(
          url: 'createArticle',
          data: FormData.fromMap(
            {
              'title': title,
              'body': body,
              'media': await MultipartFile.fromFile(
                mediaFile!.path,
                filename: mediaFileName,
              ),
            },
          ),
          token: token,
          onSendProgress: (int sent, int total) {
            String percentage = (sent / total * 100).toStringAsFixed(2);
            stringProgress = '$percentage%';
            doubleProgress = (sent / total);

            print(stringProgress);
            print(doubleProgress);

            emit(ChangeProgress());
          }).then((value) async {
        print('value.data: ${value.data}');

        emit(SendArticleSuccess());
      }).catchError((error) {
        print('error.response.data: ${error.response.data}');
        errorModel = ErrorModel.fromJson(error.response.data);
        emit(SendArticleError(errorModel!));
        print(error.toString());
      });
    }
  }

  ////////////////////////////////////////////////////////////////////////////////

  // Get Articles

  bool getAllArticles = false;

  int? paginationNumberSave;

  int currentIndex = 0;

  ArticlesModel? articlesModel;

  List<ArticleData> articlesPaginated = [];

  Future<void> getArticlesData({
    required int paginationNumber,
  }) async {
    articlesModel = null;
    currentIndex = paginationNumber;

    emit(GetArticleLoading());
    DioHelper.postData(
            url: 'getArticles',
            data: {
              'page': paginationNumber + 1,
            },
            token: token)
        .then((value) async {
      print('value.data: ${value.data}');
      articlesModel = ArticlesModel.fromJson(value.data);
      paginationNumberSave = articlesModel!.data!.lastPageNumber!;

      articlesPaginated.addAll(articlesModel!.data!.articlesList!);

      getAllArticles = true;

      emit(GetArticleSuccess());
    }).catchError((error) {
      print('error.response.data: ${error.response.data}');
      errorModel = ErrorModel.fromJson(error.response.data);
      emit(GetArticleError(errorModel!));
      print(error.toString());
    });
  }


}
