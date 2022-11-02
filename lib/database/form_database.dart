import 'package:assessment_app/constants/questions.dart';
import 'package:hive/hive.dart';
import 'package:assessment_app/model/form.dart';
import '../constants/enums.dart';
import '../model/question.dart';

class FormDatabase {
  late Box<Form> _box;
  final String code;

  FormDatabase(this.code);

  // Open a box and initialize box
  Future<void> open() async {
    _box = await Hive.openBox<Form>('form');
  }

  // Get all questions
  Future<List<Question>> getQuestions() async {
    await open();

    if (_box.get(code) == null) {
      _box.put(code, Form(code, DateTime.now(), DateTime.now(), questions));
    }

    List<Question> result = _box.get(code)!.questions;
    return result;
  }

  // Update question
  Future<void> updateQuestionAnswer(int number, String answer) async {
    final formToEdit = _box.get(code);

    final List<Question> questionsList = formToEdit!.questions;
    int indexQuestion =
        questions.indexWhere((question) => question.number == number);
    questionsList[indexQuestion].answer = answer;

    _box.put(code, Form(code, formToEdit.start, formToEdit.end, questionsList));
  }

  Future<bool> completed() async {
    final formToEdit = _box.get(code);

    var emptyQuestion = false;
    for (var i = 0; i < formToEdit!.questions.length; i++) {
      if (formToEdit.questions[i].type == QuestionType.multipleChoice &&
          formToEdit.questions[i].answer == "") {
        emptyQuestion = true;
      }
    }

    if (!emptyQuestion) {
      _box.put(code,
          Form(code, formToEdit.start, DateTime.now(), formToEdit.questions));
      return true;
    }
    return false;
  }

  Future<Form> getForm() async {
    final form = _box.get(code)!;
    return form;
  }
}
