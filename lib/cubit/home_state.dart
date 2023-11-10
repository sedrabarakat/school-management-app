part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}
class changeDrawerState extends HomeState {}
class AccountsShowState extends HomeState {}

class anim extends HomeState {}



class GetHomeLoadingState extends HomeState {}

class GetHomeSuccessState extends HomeState {}

class GetHomeErrorState extends HomeState {
  final ErrorModel errorModel;

  GetHomeErrorState(this.errorModel);
}


class ChangeChildIndex extends HomeState {}



class LogoutLoadingState extends HomeState{}
class LogoutSuccessState extends HomeState{
  final LogoutModel logoutModel;

  LogoutSuccessState(this.logoutModel);
}
class LogoutErrorState extends HomeState {
  final ErrorModel errorModel;

  LogoutErrorState(this.errorModel);
}

class Loading_send_complaint extends HomeState {}
class Success_send_complaint extends HomeState {}
class Error_Send_Complaint extends HomeState {
  String error;
  Error_Send_Complaint(this.error);
}

class change_child extends HomeState {}