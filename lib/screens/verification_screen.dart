import 'package:assessment_app/constants/colors.dart';
import 'package:assessment_app/model/classroom.dart';
import 'package:assessment_app/screens/home_screen.dart';
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
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const HomeScreen())),
          )),
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
                          subtitle: Text(
                            !avaliable
                                ? "A avaliação desta disciplina só está disponível de ${classroom.initialDate} até ${classroom.finalDate}."
                                : 'Verifique as informações referentes a disciplina e depois clique no botão “Iniciar”.',
                            style: TextStyle(
                                fontWeight: !avaliable
                                    ? FontWeight.w600
                                    : FontWeight.normal,
                                color: !avaliable ? kRed : Colors.black,
                                fontSize: !avaliable ? 16 : 20),
                          )),
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
