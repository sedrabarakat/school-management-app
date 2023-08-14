part of 'articles_cubit.dart';

@immutable
abstract class ArticlesState {}

class ArticlesInitial extends ArticlesState {}

class ChangeCounter extends ArticlesState {}

class ClearDataState extends ArticlesState {}

class PickMediaFile extends ArticlesState {}

class ChangeProgress extends ArticlesState {}

class OpenEmojiKeyboard extends ArticlesState {}

class CloseEmojiKeyboard extends ArticlesState {}

class OnRefreshState extends ArticlesState {}


class SendArticleLoading extends ArticlesState {}

class SendArticleSuccess extends ArticlesState {}

class SendArticleError extends ArticlesState {
  final ErrorModel errorModel;

  SendArticleError(this.errorModel);
}



class GetArticleLoading extends ArticlesState {}

class GetArticleSuccess extends ArticlesState {}

class GetArticleError extends ArticlesState {
  final ErrorModel errorModel;

  GetArticleError(this.errorModel);
}


