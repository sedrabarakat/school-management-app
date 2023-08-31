part of 'homework_cubit.dart';

@immutable
abstract class HomeworkState {}

class HomeworkInitial extends HomeworkState {}


class GetHomeworkLoading extends HomeworkState {}

class GetHomeworkSuccess extends HomeworkState {}

class GetHomeworkError extends HomeworkState {
  ErrorModel? errorModel;

  GetHomeworkError(this.errorModel);
}


class DownloadFileLoading extends HomeworkState {}

class DownloadFileSuccess extends HomeworkState {}

class DownloadFileError extends HomeworkState {}
