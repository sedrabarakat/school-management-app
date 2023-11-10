import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:school_app/constants.dart';
import 'package:school_app/models/error_model.dart';
import 'package:school_app/models/notific/notifications_model.dart';
import 'package:school_app/network/remote/dio_helper.dart';

part 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  NotificationsCubit() : super(NotificationsInitial());

  static NotificationsCubit get(context) => BlocProvider.of(context);



  /////////////////////////////////////////////////////////////////////////////

  // Absences

  ErrorModel? errorModel;

  AbsencesModel? absencesModel;

  Future getAbsences({required int student_id}) async {

    emit(GetAbsencesLoading());
    DioHelper.postData(
        url: 'getAbsences',
        data: {
          'student_id': student_id,
        },
        token: token)
        .then((value) async {
      print('value.data: ${value.data}');
      absencesModel = AbsencesModel.fromJson(value.data);

      emit(GetAbsencesSuccess());
    }).catchError((error) {
      print('error.response.data: ${error.response.data}');
      errorModel = ErrorModel.fromJson(error.response.data);
      emit(GetAbsencesError(errorModel!));
      print(error.toString());
    });

  }


////////////////////////////////////////////////////////////////////////////////
  //Notifications

  NotificationsModel? notificationsModel;

  Future getNotifications() async {

    emit(GetAbsencesLoading());
    DioHelper.getData(
        url: 'getNotifications',
        token: token)
        .then((value) async {
      print('value.data: ${value.data}');
      notificationsModel = NotificationsModel.fromJson(value.data);

      emit(GetNotificationsSuccess());
    }).catchError((error) {
      print('error.response.data: ${error.response.data}');
      errorModel = ErrorModel.fromJson(error.response.data);
      emit(GetNotificationsError(errorModel!));
      print(error.toString());
    });

  }


}
