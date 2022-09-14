import 'package:assessment_app/database/form_database.dart';
import 'package:assessment_app/model/question.dart';
import 'package:assessment_app/model/response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/form.dart';
import '../../services/service.dart';

part 'assessment_event.dart';
part 'assessment_state.dart';

class AssessmentBloc extends Bloc<AssessmentEvent, AssessmentState> {
  final FormDatabase _formDatabase;

  AssessmentBloc(this._formDatabase) : super(LoadingQuestions()) {
    on<LoadQuestions>((event, emit) async {
      var questions = await _formDatabase.getQuestions();
      emit(QuestionsLoaded(questions));
    });

    on<RegisterAnswer>((event, emit) async {
      await _formDatabase.updateQuestionAnswer(event.number, event.answer);
    });

    on<RegisterAssessment>((event, emit) async {
      Form form = await _formDatabase.getForm();
      Response response = await Service().registerAssessment(form);

      if (response.response) {
        emit(Sucessfull());
      } else {
        emit(Error(response.message));
      }
    });

    on<VerifyAnswers>((event, emit) async {
      var completed = await _formDatabase.completed();
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
