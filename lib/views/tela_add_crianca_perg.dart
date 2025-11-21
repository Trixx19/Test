import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gonogo/controller/controller_children.dart';
import 'package:gonogo/views/components/animations.dart';
import '../models/utils/rotas-app.dart';

class TelaAddCriancaPerg1 extends StatefulWidget {
  final String id;
  const TelaAddCriancaPerg1({super.key, required this.id});

  @override
  State<TelaAddCriancaPerg1> createState() => _TelaAddCriancaPerg1State();
}

class _TelaAddCriancaPerg1State extends State<TelaAddCriancaPerg1> {
  int i = 0;
  bool _carregar = false;
  final List<int> _notas = [];

  void _increment() {
    setState(() {
      i++;
    });
  }

  Future<void> _addPerguntas() async {
    setState(() {
      _carregar = true;
    });
    _popUp("");
    try {
      ControllerChildren().addPerguntas(widget.id, _notas);
      setState(() {
        _carregar = false;
      });
      _popUp("Dados cadastrados!");
    } catch (error) {
      setState(() {
        _carregar = false;
      });
      _popUp("Error ao tentar adicionar informações!");
    }
  }

  Future<bool?> confirmar() async {
    return showDialog(
      context: context,
      barrierColor: Colors.transparent,
      builder: (ctx) => AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        content: Builder(
          builder: (context) {
            final size = MediaQuery.of(context).size;
            return SizedBox(
              height: size.height * .40,
              width: size.width * .70,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      height: size.height * .15,
                      child: const Center(
                        child: AutoSizeText(
                          "Deseja mesmo sair?",
                          maxLines: 3,
                          minFontSize: 10,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 30,
                            color: Color(0xff1E70AD),
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      height: size.height * .08,
                      width: size.width * .60,
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(
                              height: size.height,
                              width: size.width * .25,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context, false);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.grey,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                                child: const AutoSizeText(
                                  'Cancelar',
                                  maxLines: 1,
                                  minFontSize: 10,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Raleway',
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: size.height,
                              width: size.width * .25,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, RotasApp.menu);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xff48CC48),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                                child: const AutoSizeText(
                                  'Sair',
                                  maxLines: 10,
                                  minFontSize: 10,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Raleway',
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final listaTexto = [
      "Tem dificuldade de manter a atenção em tarefas ou atividades de lazer.",
      "Não segue instruções até o fim e não termina deveres de escola, tarefas ou obrigações.",
      "Tem dificuldade em se envolver tarefas que exigem esforço mental prolongado.",
      "Responde as perguntas de forma precipitada antes delas terem sido terminadas.",
    ];
    final alturaTela = MediaQuery.of(context).size.height -
        (MediaQuery.of(context).padding.top +
            MediaQuery.of(context).padding.bottom);
    final padding = MediaQuery.of(context).padding;
    double largura = size.width * .80;

    return PopScope( // willPopScope agora é só PopScope
      canPop: false,
      onPopInvokedWithResult: (bool didPop, dynamic result) {
        if (didPop) {
          return;
        }
        confirmar();
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          leading: Center(
            child: Padding(
              padding: EdgeInsets.only(left: size.width * .01),
              child: SizedBox(
                height: size.height * .07,
                child: FloatingActionButton(
                  child: const Icon(
                    Icons.arrow_back_ios_new_outlined,
                  ),
                  onPressed: () async {
                    confirmar();
                  },
                  // ROTA = rota do botão "voltar"
                ),
              ),
            ),
          ),
          toolbarHeight: size.height * .08,
        ),
        body: SingleChildScrollView(
          padding: padding,
          child: Stack(
            children: [
              Container(
                height: alturaTela,
                width: size.width,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/Fundo3.png'),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: size.height * .15,
                      width: largura,
                      child: AutoSizeText(
                        listaTexto[i],
                        maxLines: 3,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Color(0xff1E70AD),
                          fontSize: 30,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: size.height * .15),
                      child: SizedBox(
                        height: size.height * .08,
                        width: largura,
                        child: Row(
                          children: [
                            for (int aux = 0; aux < 5; aux++)
                              Expanded(
                                child: FloatingActionButton(
                                  onPressed: () {
                                    _increment();
                                    setState(() {
                                      _notas.add(aux + 1);
                                    });
                                    if (i == 4) {
                                      _addPerguntas();
                                      setState(() {
                                        i = 3;
                                      });
                                    }
                                  },
                                  elevation: 10,
                                  heroTag: "btn$aux",
                                  backgroundColor: const Color(0xff1E70AD),
                                  child: Text(
                                    "${aux + 1}",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: "Roboto Condesed",
                                      fontSize: size.height * .04,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: size.height * .20,
                        bottom: size.height * .10,
                      ),
                      child: AnimatedPageIndicatorFb1(
                        currentPage: i,
                        numPages: 4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  dynamic _popUp(String msg) {
    const valor = "Dados cadastrados!";
    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        backgroundColor: Colors.white,
        content: Builder(
          builder: (context) {
            final size = MediaQuery.of(context).size;
            return SizedBox(
              height: size.height * .35,
              width: size.width * .70,
              child: _carregar
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: Colors.blue,
                      ),
                    )
                  : Stack(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: SizedBox(
                            height: size.height * .15,
                            child: Center(
                              child: AutoSizeText(
                                msg,
                                maxLines: 2,
                                minFontSize: 10,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Color(0xff1E70AD),
                                  fontSize: 30,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: SizedBox(
                            height: size.height * .08,
                            width: size.width * .50,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  RotasApp.menu,
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xff48CC48),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              child: AutoSizeText(
                                msg == valor ? 'FINALIZAR' : "SAIR",
                                maxLines: 1,
                                minFontSize: 10,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Raleway',
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
            );
          },
        ),
      ),
    );
  }
}
