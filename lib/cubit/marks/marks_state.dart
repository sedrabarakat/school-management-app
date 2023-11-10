part of 'marks_cubit.dart';

@immutable
abstract class MarksState {}

class ChangeMarkTypeIndexState extends MarksState {}

class MarksInitial extends MarksState {}

class GetMarksLoading extends MarksState {}

class GetMarksSuccess extends MarksState {}

class GetMarksError extends MarksState {
  ErrorModel? errorModel;

  GetMarksError(this.errorModel);
}

