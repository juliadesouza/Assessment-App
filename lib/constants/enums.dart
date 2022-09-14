import 'package:hive/hive.dart';

part 'enums.g.dart';

@HiveType(typeId: 3)
enum QuestionType {
  @HiveField(0)
  essay, 
  @HiveField(1)
  multipleChoice
}

enum LikertScale {stronglyAgree, agree, neutral, disagree, stronglyDisagree, notApplicable}

enum Result {success, error}
