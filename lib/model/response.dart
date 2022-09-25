import 'package:assessment_app/model/classroom.dart';

class Response {
  final bool successfull;
  final Classroom? classroom;

  Response(this.successfull, [this.classroom]);
}
