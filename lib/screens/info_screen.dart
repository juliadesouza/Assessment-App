import 'package:assessment_app/constants/colors.dart';
import 'package:flutter/material.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({Key? key}):super(key: key); 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text("INFORMAÇÕES", style: TextStyle(fontWeight:FontWeight.bold))
        ),
        body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
               children:[
                const Text("Este instrumento tem como objetivo coletar informações para avaliar as disciplinas oferecidas na Faculdade de Tecnologia para que possamos aperfeiçoar as condições e metodologias de ensino e aprendizagem.", textAlign: TextAlign.justify, style: TextStyle(fontSize: 18) ),
                const SizedBox(height: 20),
                const Text("Uma parte do instrumento é formada por afirmações que você deve indicar o grau de concordância a elas, ou se a afirmação não se aplica para esta disciplina. Na outra parte do instrumento, você terá um espaço para indicar os aspectos positivos da disciplina e sugestões para melhorá-la.", textAlign: TextAlign.justify, style: TextStyle(fontSize: 18)),
                const SizedBox(height: 20),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: const [
                     Padding(
                       padding: EdgeInsets.only(bottom: 5),
                       child: Text("IMPORTANTE",textAlign: TextAlign.justify, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: kBlue)),
                     ),
                     ListTile(horizontalTitleGap: 0.0, contentPadding: EdgeInsets.symmetric(horizontal: 0.0), leading: Icon(Icons.circle, size: 12, color: kBlue),title: Text("Existem 25 questões neste questionário.", textAlign: TextAlign.justify, style: TextStyle(fontSize: 18))),
                     ListTile(horizontalTitleGap: 0.0, contentPadding: EdgeInsets.symmetric(horizontal: 0.0), leading: Icon(Icons.circle, size: 12, color: kBlue),title: Text("O questionário é anônimo.", textAlign: TextAlign.justify, style: TextStyle(fontSize: 18))),
                     ListTile(horizontalTitleGap: 0.0, contentPadding: EdgeInsets.symmetric(horizontal: 0.0), leading: Icon(Icons.circle, size: 12, color: kBlue),title: Text("O registro de suas respostas não contém nenhuma informação de identificação sobre você, a não ser que uma pergunta específica da pesquisa explicitamente solicitou.", textAlign: TextAlign.justify, style: TextStyle(fontSize: 18)))    
                  ],
                ),
                const SizedBox(height: 20),
                const Text("OBSERVAÇÃO", textAlign: TextAlign.justify, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: kBlue)),
                const SizedBox(height: 10),
                RichText(
                    text: const TextSpan(
                      text: 'Se você usou um código de identificação para acessar esta pesquisa, por favor, tenha a certeza de que esse código ',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal, color: Colors.black87),
                      children: <TextSpan>[
                        TextSpan(text: 'não', style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: ' será armazenado junto com suas respostas. Ele é armazenado em uma base de dados separada e será atualizado apenas para indicar se você completou (ou não) a pesquisa e não há nenhuma maneira de relacionar os códigos de identificação com suas respostas!'),
                      ],
                    ),
                    textAlign: TextAlign.justify,
                  )
               ],
              )
            ),
        ),
    );
  }
}