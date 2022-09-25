import 'package:assessment_app/model/classroom.dart';

class Response {
  final bool successfull;
  final String message;
  final Classroom? classroom;

  Response(this.successfull, this.message, [this.classroom]);
}
