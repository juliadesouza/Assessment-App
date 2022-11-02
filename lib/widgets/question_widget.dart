import 'package:assessment_app/constants/colors.dart';
import 'package:assessment_app/model/question.dart';
import 'package:assessment_app/widgets/likert_scale_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../constants/enums.dart';
import '../logic/form/form_bloc.dart';

class QuestionWidget extends StatefulWidget {
  const QuestionWidget({Key? key, required this.question}) : super(key: key);

  final Question question;

  @override
  State<QuestionWidget> createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {
  TextEditingController textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.question.answer != "") {
      textController.text = widget.question.answer;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Container(
          margin: const EdgeInsets.only(bottom: 20),
          child: Text(
            widget.question.statement,
            style: const TextStyle(fontSize: 20),
          )),
      if (widget.question.type == QuestionType.multipleChoice)
        LikertScaleWidget(question: widget.question)
      else
        SizedBox(
          height: MediaQuery.of(context).size.height / 2.5,
          child: Container(
            padding: const EdgeInsets.only(left: 10, right: 10),
            decoration:
                BoxDecoration(border: Border.all(color: kGrey, width: 2)),
            child: TextFormField(
              controller: textController,
              maxLines: null,
              expands: true,
              onChanged: (String? value) {
                BlocProvider.of<FormBloc>(context).add(RegisterAnswer(
                    widget.question.number, textController.text));
              },
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
            ),
          ),
        )
    ]);
  }
}
