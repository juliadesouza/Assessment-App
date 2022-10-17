import 'package:assessment_app/model/assessment.dart';

class Response {
  final bool successfull;
  final Assessment? assessment;

  Response(this.successfull, [this.assessment]);
}
