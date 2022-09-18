import 'dart:math';

import 'package:assessment_app/constants/colors.dart';
import 'package:assessment_app/database/form_database.dart';
import 'package:assessment_app/logic/assessment/assessment_bloc.dart';
import 'package:assessment_app/model/question.dart';
import 'package:assessment_app/screens/answers_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../constants/enums.dart';
import '../widgets/custom_stepper.dart';
import '../widgets/question_widget.dart';

class AssessmentScreen extends StatefulWidget {
  const AssessmentScreen({Key? key, required this.code}) : super(key: key);

  final String code;

  @override
  State<AssessmentScreen> createState() => _AssessmentScreenState();
}

class _AssessmentScreenState extends State<AssessmentScreen> {
  int _currentStep = 0;
  int _index = 0;

  _stepState(int step, Question question) {
    if ((_currentStep > step && question.answer != "") ||
        question.answer != "" ||
        (question.answer == "" &&
            question.type == QuestionType.essay &&
            _currentStep >= step)) {
      return CustomStepState.complete;
    } else {
      return CustomStepState.editing;
    }
  }

  List<List<CustomStep>> _steps(questions) {
    List<List<CustomStep>> result = [];
    List<CustomStep> arr = [];
    int chunkSize = 5;
    int state = 0;

    for (int i = 0; i < questions.length; i++) {
      if (state == chunkSize) state = 0;
      arr.add(CustomStep(
          title: Text(questions[i].number.toString().padLeft(2, '0')),
          content: QuestionWidget(question: questions[i]),
          state: _stepState(state, questions[i]),
          isActive: _currentStep == state));
      state += 1;
    }

    for (var i = 0; i < arr.length; i += chunkSize) {
      result.add(arr.sublist(
          i, i + chunkSize > arr.length ? arr.length : i + chunkSize));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("AVALIAÇÃO",
              style: TextStyle(fontWeight: FontWeight.bold)),
          automaticallyImplyLeading: false,
        ),
        body: BlocProvider(
            create: (context) => AssessmentBloc(FormDatabase(widget.code))
              ..add(const LoadQuestions()),
            child: BlocConsumer<AssessmentBloc, AssessmentState>(
                builder: (context, state) {
              if (state is QuestionsLoaded) {
                return CustomStepper(
                    key: Key(Random.secure().nextDouble().toString()),
                    type: CustomStepperType.horizontal,
                    steps: _steps(state.questions)[_index],
                    currentStep: _currentStep,
                    onStepTapped: (step) => setState(() => _currentStep = step),
                    onStepContinue: () {
                      setState(() {
                        if (_currentStep <
                            _steps(state.questions)[_index].length - 1) {
                          _currentStep += 1;
                        } else {
                          if (_index < _steps(state.questions).length - 1) {
                            _index += 1;
                          } else {
                            _index = 0;
                          }
                          _currentStep = 0;
                        }
                      });
                    },
                    onStepCancel: () {
                      setState(() {
                        if (_currentStep > 0) {
                          _currentStep -= 1;
                        } else {
                          if (_index > 0 && _currentStep == 0) {
                            _index -= 1;
                            _currentStep =
                                _steps(state.questions)[_index].length - 1;
                          } else {
                            _currentStep = 0;
                          }
                        }
                      });
                    },
                    controlsBuilder:
                        (BuildContext context, CustomControlsDetails controls) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              SizedBox(
                                height: 40,
                                width: 120,
                                child: (!(_currentStep == 0 && _index == 0))
                                    ? ElevatedButton(
                                        onPressed: controls.onStepCancel,
                                        style: ElevatedButton.styleFrom(
                                            primary: kLightGrey),
                                        child: const Text(
                                          'Voltar',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18),
                                        ),
                                      )
                                    : null,
                              ),
                              SizedBox(
                                height: 40,
                                width: 120,
                                child: (_currentStep ==
                                            _steps(state.questions)[_index]
                                                    .length -
                                                1 &&
                                        _index ==
                                            _steps(state.questions).length - 1)
                                    ? ElevatedButton(
                                        onPressed: () {
                                          BlocProvider.of<AssessmentBloc>(
                                                  context)
                                              .add(VerifyAnswers());
                                        },
                                        child: const Text(
                                          'Finalizar',
                                          style: TextStyle(fontSize: 18),
                                        ))
                                    : ElevatedButton(
                                        onPressed: controls.onStepContinue,
                                        child: const Text(
                                          'Próximo',
                                          style: TextStyle(fontSize: 18),
                                        )),
                              ),
                            ]),
                      );
                    });
              }
              return Container();
            }, listener: (context, state) {
              if (state is AssessmentCompleted) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AnswersList(
                              code: widget.code,
                            )));
              }

              if (state is AssessmentIncompleted) {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text(
                          "ERRO",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: kBlue),
                        ),
                        content: Text(
                          state.message,
                          style: const TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 18),
                        ),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text("OK",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: kBlue,
                                      fontSize: 18))),
                        ],
                      );
                    });
              }
            })));
  }
}
