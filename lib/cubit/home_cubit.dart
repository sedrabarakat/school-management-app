import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_app/constants.dart';
import 'package:school_app/models/error_model.dart';
import 'package:school_app/models/home_model.dart';
import 'package:school_app/models/login_model.dart';
import 'package:school_app/network/remote/dio_helper.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  static HomeCubit get(context) => BlocProvider.of(context);
  bool isDrawerOpen = false;
  IconData drawericon = Icons.menu;
  Color drawericonColor = Colors.white;
  double xOffset = 0;
  double yOffset = 0;
  double scalfactor = 1;
  int Index=0;

  IconData iconAccounts = Icons.arrow_drop_down;
  bool isaccountsShow = false;

  Future ChangeDrawer(width, height)async {
    isDrawerOpen = !isDrawerOpen;
    drawericon = isDrawerOpen ? Icons.arrow_back : Icons.menu;
    drawericonColor = isDrawerOpen ? Colors.white : Colors.white;
    xOffset = isDrawerOpen ? xOffset = width * 0.65 : xOffset = 0;
    yOffset = isDrawerOpen ? yOffset = height * 0.08 : yOffset = 0;
    scalfactor = isDrawerOpen ? scalfactor = 1 : scalfactor = 1;
    isaccountsShow = false;
    iconAccounts = isaccountsShow ? Icons.arrow_drop_up : Icons.arrow_drop_down;

    emit(changeDrawerState());
  }

  void ChangeShowaccounts() {
    isaccountsShow = !isaccountsShow;
    iconAccounts = isaccountsShow ? Icons.arrow_drop_up : Icons.arrow_drop_down;
    print(isaccountsShow);

    emit(AccountsShowState());
  }


  AnimationController? animationController;

  void init() {
    animationController!
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed)
          animationController!.forward(from: 0);
      });

    animationController!.addListener(() {
      emit(anim());
    });

    animationController!.forward();
  }

  ErrorModel? errorModel;

  HomeModel? homeModel;

  Future getHomeData() async {
    emit(GetHomeLoadingState());

    DioHelper.getData(url: 'appHome', token: token).then((value) async {
      print('value.data: ${value.data}');

      homeModel = HomeModel.fromJson(value.data);

      if (isparent) {

        childId = homeModel!.data!.user!.childHomeData![0].id;

      }

      emit(GetHomeSuccessState());
    }).catchError((error) {
      print('error.response.data: ${error.response.data}');
      errorModel = ErrorModel.fromJson(error.response.data);
      emit(GetHomeErrorState(errorModel!));
      print(error.toString());
    });
  }

  int childIndex = 0;

  void changeChildIndex(index,id) {

    childIndex = index;

    childId = id;

    emit(ChangeChildIndex());

  }





  LogoutModel? logutModel;

  Future logout() async {

    emit(LogoutLoadingState());
    DioHelper.postData(
        url: 'logout',
        data: {
          'deviceToken': fcmToken,
        },
        token: token
    ).then((value) {
      print('value.data: ${value.data}');

      logutModel = LogoutModel.fromJson(value.data);

      emit(LogoutSuccessState(logutModel!));
    }).catchError((error) {
      errorModel = ErrorModel.fromJson(error.response.data);
      emit(LogoutErrorState(errorModel!));
      print(error.toString());
    });

  }

  Future send_complaint({
    required String message
  })async{
    emit(Loading_send_complaint());
    DioHelper.postData(url: 'sendComplaint',
        token: token,
        data: {
          'message':message
        }).then((value){
      emit(Success_send_complaint());
    }).catchError((error){
      emit(Error_Send_Complaint(error.toString()));
    });
  }



}
