import 'package:assessment_app/database/timeout_database.dart';
import 'package:assessment_app/database/assessment_database.dart';
import 'package:assessment_app/model/question.dart';
import 'package:assessment_app/model/response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import '../../model/form.dart';
import '../../services/service.dart';

part 'assessment_event.dart';
part 'assessment_state.dart';

class AssessmentBloc extends Bloc<AssessmentEvent, AssessmentState> {
  final AssessmentDatabase _assessmentDatabase;
  late final Box<DateTime> box;

  AssessmentBloc(this._assessmentDatabase) : super(LoadingQuestions()) {
    on<LoadQuestions>((event, emit) async {
      var questions = await _assessmentDatabase.getQuestions();
      emit(QuestionsLoaded(questions));
    });

    on<RegisterAnswer>((event, emit) async {
      await _assessmentDatabase.updateQuestionAnswer(event.number, event.answer);
    });

    on<RegisterAssessment>((event, emit) async {
      Form form = await _assessmentDatabase.getForm();
      Response response = await Service().registerAssessment(form);
      if (response.successfull) {
        TimeoutDatabase().setLastAssessmentDatetime(form.end);
        emit(Sucessfull());
      } else {
        emit(Error("Não foi possível registrar sua avaliação."));
      }
    });

    on<VerifyAnswers>((event, emit) async {
      var completed = await _assessmentDatabase.completed();
      if (!completed) {
        emit(AssessmentIncompleted(
            "Certifique-se de que todas as perguntas foram respondidas antes de continuar."));
      } else {
        emit(AssessmentCompleted());
      }
      add(const LoadQuestions());
    });
  }
}
