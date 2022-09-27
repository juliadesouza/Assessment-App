import 'package:assessment_app/screens/home_screen.dart';
import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../constants/enums.dart';

class ResultScreen extends StatelessWidget {
  final String primaryMessage;
  final String secondaryMessage;
  final String errorMessage;
  final Result result;
  const ResultScreen(
      {Key? key,
      required this.primaryMessage,
      required this.secondaryMessage,
      this.errorMessage = "",
      required this.result})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.delayed(
          const Duration(seconds: 5),
          () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return const HomeScreen();
                },
              ),
              (route) => false,
            );
          },
        ),
        builder: (context, snapshot) {
          return Scaffold(
              body: Padding(
            padding:
                const EdgeInsets.only(left: 30, right: 30, top: 80, bottom: 80),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                result == Result.success
                    ? const Icon(Icons.check_circle, color: kGreen, size: 180)
                    : const Icon(Icons.report, color: kRed, size: 180),
                Column(children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(primaryMessage,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: result == Result.success ? kGreen : kRed)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(secondaryMessage,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold)),
                  ),
                  Text(errorMessage,
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: kRed)),
                ]),
                const Text(
                    "Você será redirecionado para a tela inicial em breve ou clique no botão abaixo para retornar para a tela inicial.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16)),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const HomeScreen()));
                    },
                    style: ElevatedButton.styleFrom(
                        primary: result == Result.success ? kGreen : kRed,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 60, vertical: 10),
                        textStyle: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold)),
                    child: const Text("Home"))
              ],
            ),
          ));
        });
  }
}
