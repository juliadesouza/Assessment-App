part of 'form_bloc.dart';

abstract class FormState {}

class LoadingQuestions extends FormState {}

class QuestionsLoaded extends FormState {
  final List<Question> questions;
  QuestionsLoaded(this.questions);
}

class FormIncompleted extends FormState {
  final String message;
  FormIncompleted(this.message);
}

class FormCompleted extends FormState {}

class Sucessfull extends FormState {}

class Error extends FormState {
  final String message;
  Error(this.message);
}
