import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:school_app/constants.dart';
import 'package:school_app/models/login_model.dart';
import 'package:school_app/network/remote/dio_helper.dart';
import 'package:school_app/network/remote/end_points.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  static AuthCubit get(context) => BlocProvider.of(context);

  bool isPassword = true;
  IconData suffix = Icons.visibility_off;

  void changePasswordVisibility()
  {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_off : Icons.visibility;
    emit(ChangePasswordVisibility());
  }


  var ratioButtonWidth = 0.4;

  bool isAnimated = false;

  void animateTheButton() {
    ratioButtonWidth=0.15;
    emit(AnimateTheButton());
  }

  LoginModel? loginModel;

  void login({
    required String email,
    required String password,
  }) {
    isAnimated = true;
    emit(LoginLoadingState());
    DioHelper.postData(
      url: LOGIN,
      data: {
        'email': email,
        'password': password,
      },
    ).then((value) {
      loginModel = LoginModel.fromJson(value.data);
      print(loginModel!.status);
      print(loginModel!.message);

      String role = loginModel!.data!.user!.role!;

      if (role == 'Teacher') {
        isteacher = true;
        isparent = false;
        print(isteacher);
      }
      else if (role == 'Parent') {
        isparent = true;
        isteacher = false;
        print(isparent);
      }
      else {
        isparent = false;
        isteacher = false;
      }


      emit(LoginSuccessState(loginModel!));
    }).catchError((error) {
      loginModel = LoginModel.fromJson(error.response.data);
      emit(LoginErrorState(loginModel!));
      print(error.toString());
    });
  }



}
