part of 'home_bloc.dart';

abstract class HomeEvent {}

class VerifyCode extends HomeEvent {
  final String code;

  VerifyCode(this.code);
}
