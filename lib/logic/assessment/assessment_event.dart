part of 'assessment_bloc.dart';

abstract class AssessmentEvent {
  const AssessmentEvent();
}

class LoadQuestions extends AssessmentEvent {
  const LoadQuestions();
}

class RegisterAnswer extends AssessmentEvent {
  final int number;
  final String answer;
  const RegisterAnswer(this.number, this.answer);
}

class RegisterAssessment extends AssessmentEvent {}

class VerifyAnswers extends AssessmentEvent {}
