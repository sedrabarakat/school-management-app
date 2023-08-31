import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super(OnboardingInitial());

  static OnboardingCubit get(context)=>BlocProvider.of(context);

  int current = 0;

  void changeOnboaringIndictor(index){

    current = index;
    emit(OnboardingChangeDots());

  }

  void skipButton(){
    current = 2;
    emit(SkipState());

  }

}
