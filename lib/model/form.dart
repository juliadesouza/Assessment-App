import 'package:assessment_app/model/question.dart';
import 'package:hive/hive.dart';

part 'form.g.dart';

@HiveType(typeId: 1)
class Form {
  @HiveField(0)
  final String code;

  @HiveField(1)
  final DateTime start;

  @HiveField(2)
  final DateTime end;

  @HiveField(3)
  final List<Question> questions;

  const Form(
    this.code,
    this.start,
    this.end,
    this.questions
  );

  List<Object> questionsToJson() {
    List<Object> questoes = [];
    for(var i=0; i<questions.length; i++){
      Question current = questions[i];
      var obj = {
        'numero_pergunta': current.number.toString(),
        'resposta': current.answer
      };
      questoes.add(obj);
    }
    return questoes;
  }
}