part of 'assessment_bloc.dart';

abstract class AssessmentState {}

class LoadingQuestions extends AssessmentState {}

class QuestionsLoaded extends AssessmentState {
  final List<Question> questions;
  QuestionsLoaded(this.questions);
}

class AssessmentIncompleted extends AssessmentState {
  final String message;
  AssessmentIncompleted(this.message);
}

class AssessmentCompleted extends AssessmentState {}

class Sucessfull extends AssessmentState {}

class Error extends AssessmentState {
  final String message;
  Error(this.message);
}
