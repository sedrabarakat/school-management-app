part of 'profile_cubit.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class LoadingGetTeacherProfile extends ProfileState {}

class SuccessGetTeacherProfile extends ProfileState {}

class ErrorGetTeacherProfile extends ProfileState {
  final ErrorModel errorModel;

  ErrorGetTeacherProfile(this.errorModel);
}



class LoadingGetStudentProfile extends ProfileState {}

class SuccessGetStudentProfile extends ProfileState {}

class ErrorGetStudentProfile extends ProfileState {
  final ErrorModel errorModel;

  ErrorGetStudentProfile(this.errorModel);
}

