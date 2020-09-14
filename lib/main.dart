import 'dart:math';
import 'dart:ui' as ui;

import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';

void main() => runApp(new MyCalculatorApp());

class MyCalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora IMC', //indice de masa corporal
      home: MyCalculator(),
    );
  }
}

class MyCalculator extends StatefulWidget {
  State<StatefulWidget> createState() => Calculadora();
}

class Calculadora extends State<MyCalculator> {
  final controllerPeso = TextEditingController();
  final controllerAltura = TextEditingController();
  final myFormKey = GlobalKey<FormState>();
  final d = Decimal;

  String mostreImc = "";
  String pesoSugerido = "";

  // Claculadora Mulher
  void pesoIdealMulher() {
    int pesoidealm = 21;
    int decimals = 2; // so mostra os decimais
    int fad = pow(10, decimals);

    // validando se algum campo está vazio
    if (myFormKey.currentState.validate()) {
      double peso = double.parse(controllerPeso.text);
      double altura = double.parse(controllerAltura.text);
      double rtaAltura = (altura) / 100;
      double alturaAoQuadrado = rtaAltura * rtaAltura;
      double resultado = peso / alturaAoQuadrado;

      double d = resultado;
      d = (d * fad).round() / fad;

      //formula para sugerir o peso da pessoa
      double sugerido = (pesoidealm * peso) / d;
      sugerido = (sugerido * fad).round() / fad;

      setState(() {
        mostreImc = "IMC é: $d";
      });

      setState(() {
        pesoSugerido = "Peso ideal é: $sugerido Kg";
      });
    }
  }

  //formula para o homem
  void pesoIdealHomem() {
    int pesoidealh = 24;
    int decimals = 2;
    int fad = pow(10, decimals);

    // validando se algum campo está vazio
    if (myFormKey.currentState.validate()) {
      double peso = double.parse(controllerPeso.text);
      double altura = double.parse(controllerAltura.text);
      double rtaAltura = (altura) / 100;
      double alturaAoQuadrado = rtaAltura * rtaAltura;
      double resultado = peso / alturaAoQuadrado;

      double d = resultado;
      d = (d * fad).round() / fad;

      //formula para sugerir o peso da pessoa
      double sugerido = (pesoidealh * peso) / d;
      sugerido = (sugerido * fad).round() / fad;

      setState(() {
        mostreImc = "IMC é: $d";
      });

      setState(() {
        pesoSugerido = "Peso ideal é: $sugerido Kg";
      });
    }
  }

  void operacaoMatematica() {

    if (myFormKey.currentState.validate()) {
      double numero1 = double.parse(controllerPeso.text);
      double numero2 = double.parse(controllerAltura.text);

      double resultado = numero1 / numero2;

      setState(() {
        mostreImc = "A divisão é: $resultado";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // final ui.Size logicalSize = MediaQuery.of(context).size;
    // final double _height = logicalSize.height;
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Calculadora IMC'),
        backgroundColor: Color(0xFFf01DFD7),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {},
        ),
      ),
      body: Form(
          key: myFormKey,
          child: SingleChildScrollView(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Container(
                    width: 500,
                    height: 130,
                    decoration: BoxDecoration(
                      color: Color(0xFFf01DFD7),
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(80),
                          bottomLeft: Radius.circular(80)),
                    ),
                    child: Stack(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.center,
                          child: new Image(
                            width: 200.0,
                            height: 150.0,
                            image: new AssetImage('assets/images/scale.png'),
                          ),
                          )
                      ],
                    ),
                  ),

                  //agregamos un Container
                  Container(
                    padding: EdgeInsets.only(top: 40),
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: 200,
                          height: 50,
                          padding: EdgeInsets.all(7),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(color: Colors.black, blurRadius: 5)
                            ]),
                            child: TextFormField(
                              controller: controllerPeso,
                              validator: (value) {
                                if (value.isEmpty) return "Digite o peso em Kg";
                              },
                              decoration: InputDecoration(
                                hintText: "Peso Kg",
                                icon: Icon(Icons.account_balance_wallet,
                                color: Colors.purpleAccent)
                              ),
                              keyboardType: TextInputType.number,
                            ),
                        ),
                        Divider(),
                        Container(
                          width: 200,
                          height: 50,
                          padding: EdgeInsets.all(7),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(color: Colors.black, blurRadius: 5)
                            ]),
                            child: TextFormField(
                              controller: controllerAltura,
                              validator: (value) {
                                if (value.isEmpty) return "Digita Altura Cm";
                              },
                              decoration: InputDecoration(
                                hintText: "Altura Cm",
                                icon: Icon(Icons.present_to_all,
                                color: Colors.blueAccent)
                              ),
                              keyboardType: TextInputType.number,
                            ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    height: 30.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FlatButton(
                        onPressed: pesoIdealMulher,
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0)),
                          color: Colors.pinkAccent,
                          padding: EdgeInsets.all(10.0),
                          child: Column(
                            children: <Widget>[Icon(Icons.person), Text('Mulher')],
                          ),
                      ),
                      VerticalDivider(),
                      FlatButton(
                        onPressed: pesoIdealHomem,
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0)),
                          color: Colors.blueAccent,
                          padding: EdgeInsets.all(10.0),
                          child: Column(
                            children: <Widget>[Icon(Icons.person), Text('Homem')],
                          ),
                      ),
                    ],
                  ),
                  Divider(
                    height: 40.0,
                  ),
                  //caixa de resultado
                  Container(
                    height: 50.0,
                    width: 300,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFFFE2E64), Color(0xFFfF781D8)]
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                      //criamos o resultado do TextFormField
                      child: Center(
                        child: Text(
                          mostreImc,
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                  ),
                  Divider(
                    height: 15.0,
                  ),
                  Container(
                    height: 50.0,
                    width: 300,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFFf04B4AE), Color(0xFFf81F7F3)]
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                      //criamos o resultado do TextFormField
                      child: Center(
                        child: Text(
                          pesoSugerido,
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                  ),
                  Divider(
                    height: 1,
                  ),
                  new Container(
                    padding: EdgeInsets.all(2.0),
                    child: Stack(
                      children: <Widget>[
                        Align(
                          child: new Image(
                            width: 300.0,
                            height: 200.0,
                            image: new AssetImage('assets/images/imcx.png'),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ))),
    );
  }
}
