import 'package:flutter/material.dart';
import 'package:flutter_cep2/flutter_cep2.dart';
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController cepController = TextEditingController();

  String resultadoConsulta = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Consulta de CEP'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: cepController,
              decoration: InputDecoration(labelText: 'Digite o CEP'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                consultarCEP();
              },
              child: Text('Consultar CEP'),
            ),
            SizedBox(height: 20),
            Text(resultadoConsulta),
          ],
        ),
      ),
    );
  }

  void consultarCEP() async {
    var CEP = flutter_cep2();

    try {
      var result = await CEP.search(cepController.text);

      setState(() {
        resultadoConsulta = '''
          CEP: ${result.cep}
          Logradouro: ${result.logradouro}
          Complemento: ${result.complemento ?? ''}
          Bairro: ${result.bairro}
          Localidade: ${result.localidade}
          UF: ${result.uf}
          Unidade: ${result.unidade ?? ''}
          IBGE: ${result.ibge}
          GIA: ${result.gia ?? ''}
          DDD: ${result.ddd ?? ''}
          SIAF: ${result.siaf ?? ''}
        ''';
      });

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Resultado da Consulta'),
            content: Text(resultadoConsulta),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Fechar'),
              ),
            ],
          );
        },
      );
    } catch (e) {
      print(e);
      setState(() {
        resultadoConsulta = 'Erro na consulta: $e';
      });
    }
  }
}
