part of 'my_articles_cubit.dart';

@immutable
abstract class MyArticlesState {}

class MyArticlesInitial extends MyArticlesState {}

class OnRefreshState extends MyArticlesState {}


class GetMyArticleLoading extends MyArticlesState {}

class GetMyArticleSuccess extends MyArticlesState {}

class GetMyArticleError extends MyArticlesState {
  final ErrorModel errorModel;

  GetMyArticleError(this.errorModel);
}


class DeleteArticleLoading extends MyArticlesState {}

class DeleteArticleSuccess extends MyArticlesState {}

class DeleteArticleError extends MyArticlesState {
  final ErrorModel errorModel;

  DeleteArticleError(this.errorModel);
}