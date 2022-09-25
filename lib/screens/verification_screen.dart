import 'package:assessment_app/constants/colors.dart';
import 'package:assessment_app/model/classroom.dart';
import 'package:assessment_app/widgets/card_widget.dart';
import 'package:flutter/material.dart';
import 'assessment_screen.dart';
import 'dart:core';
import 'package:intl/intl.dart';

class VerificationScreen extends StatelessWidget {
  const VerificationScreen({Key? key, required this.classroom})
      : super(key: key);
  final Classroom classroom;

  @override
  Widget build(BuildContext context) {
    var avaliable = false;
    DateTime now = DateTime.now();
    DateTime startDate = DateFormat("dd/MM/yyyy").parse(classroom.initialDate);
    DateTime endDate = DateFormat("dd/MM/yyyy").parse(classroom.finalDate);

    if (startDate.isBefore(now) && endDate.isAfter(now)) {
      avaliable = true;
    }

    return (Scaffold(
      appBar: AppBar(
        title: const Text("VERIFICAÇÃO",
            style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Stack(
                children: [
                  Card(
                    color: kCardBackground,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 10, bottom: 10, left: 5, right: 5),
                      child: ListTile(
                        title: const Padding(
                          padding: EdgeInsets.only(bottom: 8.0),
                          child: Text('Caro estudante,',
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                        ),
                        subtitle: avaliable
                            ? Text(
                                textAlign: TextAlign.justify,
                                'Verifique as informações referentes a disciplina e depois clique no botão “Iniciar”.',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black),
                              )
                            : Column(
                                children: [
                                  Text(
                                    textAlign: TextAlign.justify,
                                    "A avaliação desta disciplina não está disponível.",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: kRed,
                                        fontSize: 18),
                                  ),
                                  Text(
                                    textAlign: TextAlign.justify,
                                    "Disponibilidade: ${classroom.initialDate} até ${classroom.finalDate}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  )
                                ],
                              ),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.topRight,
                    child: Image.asset(
                      "assets/images/owl.png",
                      width: 50,
                      height: 50,
                    ),
                  )
                ],
              ),
              CardWidget(
                  title: "CÓDIGO",
                  icon: Icons.lock,
                  value: classroom.subjectCode.toUpperCase()),
              CardWidget(
                  title: "DISCIPLINA",
                  icon: Icons.school,
                  value: classroom.subjectName),
              CardWidget(
                  title: "TURMA",
                  icon: Icons.people_alt,
                  value: classroom.classCode
                      .substring(classroom.classCode.length - 1)
                      .toUpperCase()),
              CardWidget(
                  title: "SEMESTRE",
                  icon: Icons.calendar_month,
                  value:
                      "${classroom.semester}º semestre de ${classroom.year}"),
              Container(
                  margin: const EdgeInsets.only(
                      left: 30, right: 30, top: 30, bottom: 20),
                  child: ElevatedButton(
                    onPressed: avaliable
                        ? () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => AssessmentScreen(
                                    code: classroom.classCode)));
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text("INICIAR",
                          style: TextStyle(
                              color: kBackground,
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                    ),
                  )),
            ],
          ),
        ),
      ),
    ));
  }
}
