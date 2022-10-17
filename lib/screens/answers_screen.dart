import 'package:assessment_app/constants/colors.dart';
import 'package:assessment_app/database/form_database.dart';
import 'package:assessment_app/logic/assessment/assessment_bloc.dart';
import 'package:assessment_app/model/question.dart';
import 'package:assessment_app/screens/result_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../constants/enums.dart';

class Item {
  Item({
    required this.question,
    this.isExpanded = false,
  });

  Question question;
  bool isExpanded;
}

const answerToLikert = {
  "0": "Não consigo avaliar / Não se aplica",
  "1": "Discordo Totalmente",
  "2": "Discordo Parcialmente",
  "3": "Indiferente / Neutro",
  "4": "Concordo Parcialmente",
  "5": "Concordo Totalmente",
};

List<Item> generateItems(int numberOfItems, List<Question> questions) {
  return List<Item>.generate(numberOfItems, (int index) {
    return Item(
      question: questions[index],
    );
  });
}

class AnswersScreen extends StatefulWidget {
  const AnswersScreen({Key? key, required this.code}) : super(key: key);

  final String code;
  @override
  State<AnswersScreen> createState() => _AssessmentScreenState();
}

class _AssessmentScreenState extends State<AnswersScreen> {
  List<Item> _data = [];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => AssessmentBloc(FormDatabase(widget.code))
          ..add(const LoadQuestions()),
        child: BlocConsumer<AssessmentBloc, AssessmentState>(
            builder: (context, state) {
          return Scaffold(
              appBar: AppBar(
                title: const Text("RESPOSTAS",
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  BlocProvider.of<AssessmentBloc>(context)
                      .add(RegisterAssessment());
                },
                backgroundColor: kBlue,
                child: const Icon(Icons.send),
              ),
              body: (state is QuestionsLoaded
                  ? ListView(children: [
                      _buildPanel(),
                    ])
                  : Container()));
        }, listener: (context, state) {
          if (state is QuestionsLoaded) {
            _data = generateItems(state.questions.length, state.questions);
          }

          if (state is Error) {
            Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) => ResultScreen(
                        primaryMessage: "Desculpa!",
                        secondaryMessage:
                            "Não foi possível registrar suas respostas",
                        errorMessage: state.message,
                        result: Result.error,
                      )),
            );
          }

          if (state is Sucessfull) {
            Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) => const ResultScreen(
                        primaryMessage: "Obrigado!",
                        secondaryMessage: "Respostas registradas com sucesso.",
                        result: Result.success,
                      )),
            );
          }
        }));
  }

  Widget _buildPanel() {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          var teste = !isExpanded;
          _data[index].isExpanded = teste;
        });
      },
      children: _data.map<ExpansionPanel>((Item item) {
        return ExpansionPanel(
          canTapOnHeader: true,
          headerBuilder: (BuildContext context, bool isExpanded) {
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: Text(
                      "QUESTÃO ${item.question.number}",
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
          body: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    item.question.statement,
                  ),
                ),
                item.question.type == QuestionType.multipleChoice
                    ? Row(children: [
                        const Text(
                          "Resposta:  ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Expanded(
                          child: Text(
                              answerToLikert[item.question.answer].toString()),
                        ),
                      ])
                    : Wrap(children: [
                        const Padding(
                            padding: EdgeInsets.only(bottom: 8.0),
                            child: Text(
                              "Resposta: ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            item.question.answer,
                          ),
                        )
                      ])
              ],
            ),
          ),
          isExpanded: item.isExpanded,
        );
      }).toList(),
    );
  }
}
