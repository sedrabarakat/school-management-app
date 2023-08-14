part of 'onboarding_cubit.dart';

@immutable
abstract class OnboardingState {}

class OnboardingInitial extends OnboardingState {}

class OnboardingChangeDots extends OnboardingState {}

class SkipState extends OnboardingState {}

