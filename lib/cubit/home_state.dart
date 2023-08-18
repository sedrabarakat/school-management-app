part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}
class changeDrawerState extends HomeState {}
class AccountsShowState extends HomeState {}

class Loading_send_complaint extends HomeState {}
class Success_send_complaint extends HomeState {}
class Error_Send_Complaint extends HomeState {
  String error;
  Error_Send_Complaint(this.error);
}