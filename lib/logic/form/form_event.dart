part of 'form_bloc.dart';

abstract class FormEvent {
  const FormEvent();
}

class LoadQuestions extends FormEvent {
  const LoadQuestions();
}

class RegisterAnswer extends FormEvent {
  final int number;
  final String answer;
  const RegisterAnswer(this.number, this.answer);
}

class RegisterForm extends FormEvent {}

class VerifyAnswers extends FormEvent {}
