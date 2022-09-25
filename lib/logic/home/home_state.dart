part of 'home_bloc.dart';

abstract class HomeState {}

class Authenticating extends HomeState {}

class UnauthenticatedCode extends HomeState {}

class AuthenticatedCode extends HomeState {
  final Classroom? classroom;
  AuthenticatedCode(this.classroom);
}

class CodeError extends HomeState {
  final String message;
  CodeError(this.message);
}
