import 'package:assessment_app/database/timeout_database.dart';
import 'package:assessment_app/database/form_database.dart';
import 'package:assessment_app/model/question.dart';
import 'package:assessment_app/model/response.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import '../../model/form.dart';
import '../../services/service.dart';

part 'form_event.dart';
part 'form_state.dart';

class FormBloc extends Bloc<FormEvent, FormState> {
  final FormDatabase _formDatabase;
  late final Box<DateTime> box;

  FormBloc(this._formDatabase) : super(LoadingQuestions()) {
    on<LoadQuestions>((event, emit) async {
      var questions = await _formDatabase.getQuestions();
      emit(QuestionsLoaded(questions));
    });

    on<RegisterAnswer>((event, emit) async {
      await _formDatabase.updateQuestionAnswer(event.number, event.answer);
    });

    on<RegisterForm>((event, emit) async {
      Form form = await _formDatabase.getForm();
      Response response = await Service().registerAssessment(form);
      if (response.successfull) {
        TimeoutDatabase().setLastAssessmentDatetime(form.end);
        emit(Sucessfull());
      } else {
        emit(Error("Não foi possível registrar sua avaliação."));
      }
    });

    on<VerifyAnswers>((event, emit) async {
      var completed = await _formDatabase.completed();
      if (!completed) {
        emit(FormIncompleted(
            "Certifique-se de que todas as perguntas foram respondidas antes de continuar."));
      } else {
        emit(FormCompleted());
      }
      add(const LoadQuestions());
    });
  }
}
