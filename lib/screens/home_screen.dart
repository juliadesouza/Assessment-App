import 'package:assessment_app/constants/colors.dart';
import 'package:assessment_app/logic/home/home_bloc.dart';
import 'package:assessment_app/screens/info_screen.dart';
import 'package:assessment_app/screens/assessment_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'info_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController codeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("AVALIAÇÃO DA GRADUAÇÃO",
              style: TextStyle(fontWeight: FontWeight.bold)),
          actions: [
            IconButton(
              icon: const Icon(Icons.info),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const InfoScreen()),
                );
              },
            ),
          ]),
      body: BlocProvider(
        create: (context) => HomeBloc(),
        child: BlocConsumer<HomeBloc, HomeState>(listener: (context, state) {
          if (state is AuthenticatedCode) {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    AssessmentScreen(code: codeController.text)));
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
            return LayoutBuilder(builder:
                (BuildContext context, BoxConstraints viewportConstraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: viewportConstraints.maxHeight,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Image.asset(
                          'assets/images/logo.png',
                          width: 250,
                          height: 250,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: const [
                            Padding(
                              padding: EdgeInsets.only(bottom: 10.0),
                              child: Text(
                                "Sua opinião em poucos minutos.",
                                textAlign: TextAlign.justify,
                                style: TextStyle(fontSize: 28),
                              ),
                            ),
                            Text(
                                "Avaliação das disciplinas oferecidas na Faculdade de Tecnologia a fim de aperfeiçoar as condições e metodologias de ensino e aprendizagem.",
                                textAlign: TextAlign.justify,
                                style: TextStyle(fontSize: 18)),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: TextFormField(
                                        controller: codeController,
                                        textAlignVertical:
                                            TextAlignVertical.center,
                                        decoration: const InputDecoration(
                                            border: OutlineInputBorder(),
                                            hintText: 'Código',
                                            prefixIcon:
                                                Icon(Icons.lock_outline)),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Digite o código.';
                                          }
                                          return null;
                                        })),
                                SizedBox(
                                    height: 50,
                                    child: ElevatedButton(
                                        onPressed: () {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            BlocProvider.of<HomeBloc>(context)
                                                .add(VerifyCode(
                                                    codeController.text));
                                          }
                                        },
                                        child: const Text('Iniciar',
                                            style: TextStyle(fontSize: 20)))),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            });
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
