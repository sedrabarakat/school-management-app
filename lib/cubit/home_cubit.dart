import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

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

  IconData iconAccounts = Icons.arrow_drop_down;
  bool isaccountsShow = false;

  void ChangeDrawer() {
    isDrawerOpen = !isDrawerOpen;
    drawericon = isDrawerOpen ? Icons.arrow_back : Icons.menu;
    drawericonColor = isDrawerOpen ? Colors.red : Colors.white;
    xOffset = isDrawerOpen ? xOffset = 250 : xOffset = 0;
    yOffset = isDrawerOpen ? yOffset = 80 : yOffset = 0;
    scalfactor = isDrawerOpen ? scalfactor = 1 : scalfactor = 1;
    isaccountsShow = false;
    iconAccounts = isaccountsShow? Icons.arrow_drop_up:Icons.arrow_drop_down ;

    emit(changeDrawerState());
  }
  

  void ChangeShowaccounts() {
    isaccountsShow = !isaccountsShow;
    iconAccounts = isaccountsShow? Icons.arrow_drop_up:Icons.arrow_drop_down ;
    print(isaccountsShow);

    emit(AccountsShowState());
  }
}
