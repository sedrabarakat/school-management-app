import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_app/constants.dart';
import 'package:school_app/models/articles_model.dart';
import 'package:school_app/models/error_model.dart';
import 'package:school_app/network/remote/dio_helper.dart';

part 'my_articles_state.dart';

class MyArticlesCubit extends Cubit<MyArticlesState> {
  ScrollController myScrollController;

  MyArticlesCubit(this.myScrollController) : super(MyArticlesInitial()) {
    myScrollController = ScrollController();

    myScrollController.addListener(_scrollListener);
  }

  Future<void> _scrollListener() async {
    if (articlesModelTeacher == null) return;

    if (myScrollController.position.pixels ==
            myScrollController.position.maxScrollExtent &&
        currentIndexTeacher + 1 != paginationNumberSaveTeacher) {
      currentIndexTeacher++;

      await getArticlesDataTeacher(paginationNumber: currentIndexTeacher);
    }
  }

  @override
  Future<void> close() {
    myScrollController.dispose();

    return super.close();
  }

// Refresh

  Future<void> onRefresh() async {
    articlesPaginatedTeacher = [];
    await getArticlesDataTeacher(paginationNumber: 0);
    emit(OnRefreshState());
  }

  //////////////////////////////////////////////////////////////////////////////

  static MyArticlesCubit get(context) => BlocProvider.of(context);

  // Get My Articles (Teacher)

  ErrorModel? errorModel;

  bool getAllArticlesTeacher = false;

  ArticlesModel? articlesModelTeacher;

  List<ArticleData> articlesPaginatedTeacher = [];

  int? paginationNumberSaveTeacher;

  int currentIndexTeacher = 0;

  Future getArticlesDataTeacher({
    required int paginationNumber,
  }) async {
    articlesModelTeacher = null;
    currentIndexTeacher = paginationNumber;

    emit(GetMyArticleLoading());
    DioHelper.postData(
            url: 'getMyArticles',
            data: {
              'page': paginationNumber + 1,
            },
            token: token)
        .then((value) async {
      print('value.data: ${value.data}');
      articlesModelTeacher = ArticlesModel.fromJson(value.data);
      paginationNumberSaveTeacher = articlesModelTeacher!.data!.lastPageNumber!;

      articlesPaginatedTeacher
          .addAll(articlesModelTeacher!.data!.articlesList!);

      getAllArticlesTeacher = true;

      emit(GetMyArticleSuccess());
    }).catchError((error) {
      print('error.response.data: ${error.response.data}');
      errorModel = ErrorModel.fromJson(error.response.data);
      emit(GetMyArticleError(errorModel!));
      print(error.toString());
    });
  }

  //////////////////////////////////////////////////////////////////////////
  // Delete Articles

  void deleteOneArticlesTeacherData({required int id}) async {
    emit(DeleteArticleLoading());
    DioHelper.postData(
            url: 'deleteArticleTeacher', data: {"id": id}, token: token)
        .then((value) async {
      print('value.data: ${value.data}');

      emit(DeleteArticleSuccess());
    }).catchError((error) {
      print('error.response.data: ${error.response.data}');
      errorModel = ErrorModel.fromJson(error.response.data);
      emit(DeleteArticleError(errorModel!));
      print(error.toString());
    });
  }
}
