import 'package:assessment_app/constants/enums.dart';
import 'package:hive/hive.dart';

 part 'question.g.dart';
 
@HiveType(typeId: 2)
class Question {
  @HiveField(0)
  int number;

  @HiveField(1)
  String statement;

  @HiveField(2)
  String answer;

  @HiveField(3)
  QuestionType type;

  Question(this.number, this.statement, this.answer, this.type);
}