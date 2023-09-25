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