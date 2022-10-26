import 'package:assessment_app/constants/questions.dart';
import 'package:hive/hive.dart';
import 'package:assessment_app/model/form.dart';
import '../constants/enums.dart';
import '../model/question.dart';

class AssessmentDatabase {
  late Box<Form> _box;
  final String code;

  AssessmentDatabase(this.code);

  // Open a box and initialize box
  Future<void> open() async {
    _box = await Hive.openBox<Form>('assessment');
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
    final assessmentToEdit = _box.get(code);

    final List<Question> questionsList = assessmentToEdit!.questions;
    int indexQuestion =
        questions.indexWhere((question) => question.number == number);
    questionsList[indexQuestion].answer = answer;

    _box.put(
        code,
        Form(
            code, assessmentToEdit.start, assessmentToEdit.end, questionsList));
  }

  Future<bool> completed() async {
    final assessmentToEdit = _box.get(code);

    var emptyQuestion = false;
    for (var i = 0; i < assessmentToEdit!.questions.length; i++) {
      if (assessmentToEdit.questions[i].type == QuestionType.multipleChoice &&
          assessmentToEdit.questions[i].answer == "") {
        emptyQuestion = true;
      }
    }

    if (!emptyQuestion) {
      _box.put(
          code,
          Form(code, assessmentToEdit.start, DateTime.now(),
              assessmentToEdit.questions));
      return true;
    }
    return false;
  }

  Future<Form> getForm() async {
    final form = _box.get(code)!;
    return form;
  }
}
