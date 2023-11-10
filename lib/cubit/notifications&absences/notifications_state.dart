part of 'notifications_cubit.dart';

@immutable
abstract class NotificationsState {}

class NotificationsInitial extends NotificationsState {}


class GetNotificationsLoading extends NotificationsState {}

class GetNotificationsSuccess extends NotificationsState {}

class GetNotificationsError extends NotificationsState {
  ErrorModel? errorModel;

  GetNotificationsError(this.errorModel);
}



class GetAbsencesLoading extends NotificationsState {}

class GetAbsencesSuccess extends NotificationsState {}

class GetAbsencesError extends NotificationsState {
  ErrorModel? errorModel;

  GetAbsencesError(this.errorModel);
}



