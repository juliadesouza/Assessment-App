import 'package:assessment_app/constants/colors.dart';
import 'package:assessment_app/logic/home/home_bloc.dart';
import 'package:assessment_app/model/classroom.dart';
import 'package:assessment_app/screens/verification_screen.dart';
import 'package:assessment_app/widgets/qrcode_button.dart';
import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Slide> slides = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => HomeBloc(),
        child: BlocConsumer<HomeBloc, HomeState>(listener: (context, state) {
          if (state is AuthenticatedCode) {
            Classroom classroom = state.classroom!;
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    VerificationScreen(classroom: classroom)));
          }

          if (state is CodeError) {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text(
                      "ERRO",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, color: kBlue),
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
        }, builder: (context, state) {
          if (state is UnauthenticatedCode) {
            return IntroSlider(
              slides: [
                Slide(
                    widgetTitle: const Text(
                      "AVALIAÇÃO INSTUCIONAL DE DISCIPLINAS",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: kBlue,
                          fontWeight: FontWeight.bold,
                          fontSize: 22),
                    ),
                    centerWidget: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Image.asset(
                          'assets/images/logo.png',
                          width: 270,
                          height: 270,
                        ),
                        Container(
                          margin: const EdgeInsets.only(right: 50, left: 50),
                          child: const Text(
                            "Avalie as disciplinas da FT em poucos minutos.",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 22),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(50.0),
                          child: SizedBox(
                              height: 50,
                              child: QRCodeButton(blocContext: context)),
                        ),
                      ],
                    )),
                Slide(
                  widgetTitle: const Text(
                    "INFORMAÇÕES",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: kBlue,
                        fontWeight: FontWeight.bold,
                        fontSize: 22),
                  ),
                  pathImage: 'assets/images/graph.png',
                  widthImage: 150,
                  heightImage: 150,
                  widgetDescription: const Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Text(
                        textAlign: TextAlign.justify,
                        "Este instrumento tem como objetivo coletar informações para avaliar as disciplinas oferecidas na Faculdade de Tecnologia para que possamos aperfeiçoar as condições e metodologias de ensino e aprendizagem.",
                        style: TextStyle(fontSize: 20)),
                  ),
                ),
                Slide(
                  widgetTitle: const Text(
                    "INFORMAÇÕES",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: kBlue,
                        fontWeight: FontWeight.bold,
                        fontSize: 24),
                  ),
                  pathImage: 'assets/images/tasks.png',
                  widthImage: 150,
                  heightImage: 150,
                  widgetDescription: const Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Text(
                        textAlign: TextAlign.justify,
                        "Uma parte do instrumento é formada por afirmações que você deve indicar o grau de concordância a elas, ou se a afirmação não se aplica para esta disciplina. Na outra parte do instrumento, você terá um espaço para indicar os aspectos positivos da disciplina e sugestões para melhorá-la.",
                        style: TextStyle(fontSize: 20)),
                  ),
                ),
                Slide(
                  widgetTitle: const Text(
                    "IMPORTANTE",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: kBlue,
                        fontWeight: FontWeight.bold,
                        fontSize: 24),
                  ),
                  pathImage: "assets/images/important.png",
                  widthImage: 150,
                  heightImage: 150,
                  widgetDescription: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 20.0),
                          child: ListTile(
                            leading: Image.asset(
                              'assets/images/question.png',
                            ),
                            title: const Text(
                              'Existem 25 questões neste questionário.',
                              style: TextStyle(fontSize: 18),
                              textAlign: TextAlign.justify,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 20.0),
                          child: ListTile(
                            leading: Image.asset(
                              'assets/images/person.png',
                            ),
                            title: const Text(
                              'O questionário é anônimo.',
                              style: TextStyle(fontSize: 18),
                              textAlign: TextAlign.justify,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 20.0),
                          child: ListTile(
                            leading: Image.asset(
                              'assets/images/id.png',
                            ),
                            title: const Text(
                              'O registro de suas respostas não contém nenhuma informação de identificação sobre você.',
                              style: TextStyle(fontSize: 18),
                              textAlign: TextAlign.justify,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
              showNextBtn: false,
              showPrevBtn: false,
              showSkipBtn: false,
              showDoneBtn: false,
              backgroundColorAllSlides: kBackground,
              colorDot: kGrey,
              colorActiveDot: kBlue,
            );
          }

          if (state is Authenticating) {
            return Padding(
                padding: const EdgeInsets.all(70),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(30),
                      child: CircularProgressIndicator(
                        color: kBlue,
                      ),
                    ),
                    Text("Autenticando o código...",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: kBlue)),
                  ],
                ));
          }

          return SingleChildScrollView(child: Container());
        }),
      ),
    );
  }
}
