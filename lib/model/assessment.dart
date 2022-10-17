class Assessment {
  final String classCode;
  final String subjectCode;
  final String subjectName;
  final int enrollments;
  final int semester;
  final int year;
  final String initialDate;
  final String finalDate;

  Assessment(
      this.classCode,
      this.subjectCode,
      this.subjectName,
      this.enrollments,
      this.semester,
      this.year,
      this.initialDate,
      this.finalDate);

  factory Assessment.fromJson(
      Map<String, dynamic> jsonClass, Map<String, dynamic> jsonSubject) {
    return Assessment(
        jsonClass['codTurma'] as String,
        jsonSubject['codDisc'] as String,
        jsonSubject['nome'] as String,
        jsonClass['matriculas'] as int,
        jsonClass['semestre'] as int,
        jsonClass['ano'] as int,
        jsonClass['inicio'] as String,
        jsonClass['fim'] as String);
  }
}
