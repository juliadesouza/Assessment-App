import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/form.dart';
import '../model/response.dart';

class Service {
  static final Service _instance = Service._internal();

  factory Service() {
    return _instance;
  }

  Service._internal() {
    // initialization logic
  }

  var client = http.Client();

  Future<Response> verifyCode(String code) async {
    var uri = Uri.parse(
        "https://avaliacao-alunos-ft.herokuapp.com/disciplinas/$code");
    var response = await client.get(uri);
    String message = "${response.reasonPhrase}";

    if (response.statusCode == 200) {
      return Response(true, message);
    } else {
      return Response(false, message);
    }
  }

  Future<Response> registerAssessment(Form form) async {
    var uri = Uri.parse("https://avaliacao-alunos-ft.herokuapp.com/formulario");

    var response = await client.post(
      uri,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'cod': form.code,
        'dataIni': form.start.toString(),
        'dataFim': form.end.toString(),
        'questoes': form.questionsToJson()
      }),
    );
    String message = "Código ${response.statusCode}: ${response.reasonPhrase}";

    if (response.statusCode == 201) {
      return Response(true, message);
    } else {
      return Response(false, message);
    }
  }
}
