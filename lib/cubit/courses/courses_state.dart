part of 'courses_cubit.dart';

@immutable
abstract class CoursesState {}

class CoursesInitial extends CoursesState {}

class LoadingGetMySessions extends CoursesState {}

class SuccessGetMySessions extends CoursesState {}

class ErrorGetMySessions extends CoursesState {
  final ErrorModel? errorModel;

  ErrorGetMySessions(this.errorModel);
}


class Loading_Get_Sessions extends CoursesState {}

class Success_Get_Sessions extends CoursesState {}

class Error_Get_Sessions extends CoursesState {
  final ErrorModel? errorModel;

  Error_Get_Sessions(this.errorModel);
}

class Loading_Book_Sessions extends CoursesState {}

class Success_Book_Sessions extends CoursesState {}

class Error_Book_Sessions extends CoursesState {
  final String ? error;

  Error_Book_Sessions(this.error);
}