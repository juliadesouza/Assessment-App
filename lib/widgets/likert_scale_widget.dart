import 'package:assessment_app/logic/assessment/assessment_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../constants/colors.dart';
import 'package:flutter/material.dart';
import '../model/question.dart';

class LikertScaleWidget extends StatefulWidget {
  const LikertScaleWidget({Key? key, required this.question}) : super(key: key);

  final Question question;

  @override
  State<LikertScaleWidget> createState() => _LikertScaleWidgetState();
}

class _LikertScaleWidgetState extends State<LikertScaleWidget> {
  String? _option;

  @override
  void initState() {
    super.initState();
    if (widget.question.answer != "") {
      _option = widget.question.answer;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        decoration: BoxDecoration(
            color: _option == "5" ? kLightBlue : Colors.transparent,
            border: Border.all(color: kLightGrey, width: 2)),
        child: RadioListTile<String>(
          title: Text("Concordo Totalmente",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight:
                      _option == "5" ? FontWeight.bold : FontWeight.normal)),
          value: "5",
          groupValue: _option,
          selected: _option == "5",
          onChanged: (String? value) {
            setState(() {
              _option = value;
            });
            BlocProvider.of<AssessmentBloc>(context)
                .add(RegisterAnswer(widget.question.number, value!));
          },
        ),
      ),
      Container(
        decoration: BoxDecoration(
            color: _option == "4" ? kLightBlue : Colors.transparent,
            border: const Border(
                left: BorderSide(color: kLightGrey, width: 2),
                right: BorderSide(color: kLightGrey, width: 2))),
        child: RadioListTile<String>(
          title: Text("Concordo Parcialmente",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight:
                      _option == "4" ? FontWeight.bold : FontWeight.normal)),
          value: "4",
          groupValue: _option,
          selected: _option == "4" ? true : false,
          onChanged: (String? value) {
            setState(() {
              _option = value;
            });
            BlocProvider.of<AssessmentBloc>(context)
                .add(RegisterAnswer(widget.question.number, value!));
          },
        ),
      ),
      Container(
        decoration: BoxDecoration(
            color: _option == "3" ? kLightBlue : Colors.transparent,
            border: Border.all(color: kLightGrey, width: 2)),
        child: RadioListTile<String>(
          title: Text("Indiferente / Neutro",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight:
                      _option == "3" ? FontWeight.bold : FontWeight.normal)),
          value: "3",
          groupValue: _option,
          selected: _option == "3" ? true : false,
          onChanged: (String? value) {
            setState(() {
              _option = value;
            });
            BlocProvider.of<AssessmentBloc>(context)
                .add(RegisterAnswer(widget.question.number, value!));
          },
        ),
      ),
      Container(
        decoration: BoxDecoration(
            color: _option == "2" ? kLightBlue : Colors.transparent,
            border: const Border(
                left: BorderSide(color: kLightGrey, width: 2),
                right: BorderSide(color: kLightGrey, width: 2))),
        child: RadioListTile<String>(
          title: Text("Discordo Parcialmente",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight:
                      _option == "2" ? FontWeight.bold : FontWeight.normal)),
          value: "2",
          groupValue: _option,
          selected: _option == "2" ? true : false,
          onChanged: (String? value) {
            setState(() {
              _option = value;
            });
            BlocProvider.of<AssessmentBloc>(context)
                .add(RegisterAnswer(widget.question.number, value!));
          },
        ),
      ),
      Container(
        decoration: BoxDecoration(
            color: _option == "1" ? kLightBlue : Colors.transparent,
            border: Border.all(color: kLightGrey, width: 2)),
        child: RadioListTile<String>(
          title: Text("Discordo Totalmente",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight:
                      _option == "1" ? FontWeight.bold : FontWeight.normal)),
          value: "1",
          groupValue: _option,
          selected: _option == "1" ? true : false,
          onChanged: (String? value) {
            setState(() {
              _option = value;
            });
            BlocProvider.of<AssessmentBloc>(context)
                .add(RegisterAnswer(widget.question.number, value!));
          },
        ),
      ),
      Container(
        decoration: BoxDecoration(
            color: _option == "0" ? kLightBlue : Colors.transparent,
            border: const Border(
                left: BorderSide(color: kLightGrey, width: 2),
                right: BorderSide(color: kLightGrey, width: 2),
                bottom: BorderSide(color: kLightGrey, width: 2))),
        child: RadioListTile<String>(
          title: Text("Não consigo avaliar / Não se aplica",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight:
                      _option == "0" ? FontWeight.bold : FontWeight.normal)),
          value: "0",
          groupValue: _option,
          selected: _option == "0" ? true : false,
          onChanged: (String? value) {
            setState(() {
              _option = value;
            });
            BlocProvider.of<AssessmentBloc>(context)
                .add(RegisterAnswer(widget.question.number, value!));
          },
        ),
      ),
    ]);
  }
}
