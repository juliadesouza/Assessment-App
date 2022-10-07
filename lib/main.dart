import 'package:assessment_app/constants/enums.dart';
import 'package:assessment_app/model/question.dart';
import 'package:assessment_app/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:assessment_app/constants/colors.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'model/form.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(FormAdapter());
  Hive.registerAdapter(QuestionAdapter());
  Hive.registerAdapter(QuestionTypeAdapter());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title:
            "Avaliação Institucional de Disciplinas da Faculdade de Tecnologia da Unicamp",
        theme: ThemeData(
          fontFamily: 'RobotoMono',
          brightness: Brightness.light,
          primaryColor: kBlue,
        ),
        home: const HomeScreen());
  }
}
