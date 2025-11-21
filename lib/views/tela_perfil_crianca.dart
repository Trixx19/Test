import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gonogo/models/child.dart';
import 'package:gonogo/views/tela_avaliacoes.dart';
import 'package:gonogo/views/tela_avaliar.dart';
import 'components/appBar_personalizado.dart';
import '../models/utils/rotas-app.dart';

class TelaPerfilCriancaSelecionada extends StatefulWidget {
  final Child child;
  final int local;
  const TelaPerfilCriancaSelecionada(
      {super.key, required this.child, required this.local});

  @override
  State<TelaPerfilCriancaSelecionada> createState() =>
      _TelaPerfilCriancaSelecionadaState();
}

class _TelaPerfilCriancaSelecionadaState
    extends State<TelaPerfilCriancaSelecionada> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final alturaTela = MediaQuery.of(context).size.height -
        (MediaQuery.of(context).padding.top +
            MediaQuery.of(context).padding.bottom);
    final padding = MediaQuery.of(context).padding;

return PopScope( // trocando para o popscope de novo
      canPop: false,
      onPopInvokedWithResult: (bool didPop, dynamic result) {
         if (didPop) return;
         if (context.mounted) {
           Navigator.pushNamed(
             context,
             widget.local == 0
                 ? RotasApp.criancasCadastradas
                 : RotasApp.criancasAvaliadas,
           );
         }
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          centerTitle: true,
          title: const AutoSizeText(
            'PERFIL',
            minFontSize: 12,
            maxFontSize: 22,
            maxLines: 1,
          ),
          leading: Center(
            child: IconButtonBack(
              navigator: widget.local == 0
                  ? RotasApp.criancasCadastradas
                  : RotasApp.criancasAvaliadas,
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
                    image: AssetImage('assets/images/Fundo1.png'),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      height: size.height * .20,
                      width: size.height * .20,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: CircleAvatar(
                        foregroundImage: AssetImage(
                          widget.child.sex == "Masculino"
                              ? 'assets/images/menino.png'
                              : 'assets/images/menina.png',
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * .45,
                      child: Column(
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AutoSizeText(
                                  'NOME',
                                  minFontSize: 10,
                                  maxFontSize: 25,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium,
                                  maxLines: 1,
                                ),
                                AutoSizeText(
                                  widget.child.completeName,
                                  minFontSize: 10,
                                  maxFontSize: 25,
                                  style:
                                      Theme.of(context).textTheme.headlineSmall,
                                  maxLines: 1,
                                ),
                              ],
                            ),
                          ),
                          //teste
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AutoSizeText(
                                  'DATA DE NASCIMENTO',
                                  minFontSize: 10,
                                  maxFontSize: 25,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium,
                                  maxLines: 1,
                                ),
                                AutoSizeText(
                                  widget.child.date,
                                  minFontSize: 10,
                                  maxFontSize: 25,
                                  style:
                                      Theme.of(context).textTheme.headlineSmall,
                                  maxLines: 1,
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AutoSizeText(
                                  'SEXO',
                                  minFontSize: 10,
                                  maxFontSize: 25,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium,
                                  maxLines: 1,
                                ),
                                AutoSizeText(
                                  widget.child.sex,
                                  minFontSize: 10,
                                  maxFontSize: 25,
                                  textAlign: TextAlign.left,
                                  style:
                                      Theme.of(context).textTheme.headlineSmall,
                                  maxLines: 1,
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AutoSizeText(
                                  'COR DA PELE',
                                  minFontSize: 10,
                                  maxFontSize: 25,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium,
                                  maxLines: 1,
                                ),
                                AutoSizeText(
                                  widget.child.color,
                                  minFontSize: 10,
                                  maxFontSize: 25,
                                  textAlign: TextAlign.left,
                                  style:
                                      Theme.of(context).textTheme.headlineSmall,
                                  maxLines: 1,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: size.height * .25,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (widget.child.boolTests == 1)
                            Padding(
                              padding: EdgeInsets.only(
                                bottom: size.height * .02,
                              ),
                              child: SizedBox(
                                height: size.height * .09,
                                width: size.width * .70,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => TelaAvaliacoes(
                                                id: widget.child.id)));
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                  ),
                                  child: const AutoSizeText(
                                    "RESULTADOS",
                                    maxLines: 1,
                                    minFontSize: 10,
                                    style: TextStyle(
                                      color: Color(0xff1E70AD),
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          SizedBox(
                            height: size.height * .09,
                            width: size.width * .70,
                            child: ElevatedButton(
                              onPressed: () {
                                _popUp();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xff48CC48),
                              ),
                              child: AutoSizeText(
                                widget.child.boolTests == 1
                                    ? 'AVALIAR NOV.'
                                    : 'AVALIAR',
                                maxLines: 1,
                                minFontSize: 10,
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
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

  dynamic _popUp() {
    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
        ),
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
                      child: Center(
                        child: AutoSizeText(
                          widget.child.boolTests == 1
                              ? "Você deseja mesmo fazer outra avaliação?"
                              : "Você deseja mesmo fazer uma avaliação?",
                          maxLines: 3,
                          minFontSize: 10,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
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
                                  _popUpEscolha();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xff48CC48),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                                child: const AutoSizeText(
                                  'SIM',
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
                                  Navigator.pop(context);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.grey,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                                child: const AutoSizeText(
                                  'NÃO',
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

  dynamic _popUpEscolha() {
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
                          "Escolha a avaliação",
                          maxLines: 2,
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
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => TelaAvaliar(
                                        id: widget.child.id,
                                        teste: 0,
                                        boolTeste: widget.child.boolTests,
                                      ),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xff48CC48),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                                child: const AutoSizeText(
                                  'Visual',
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
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => TelaAvaliar(
                                        id: widget.child.id,
                                        teste: 1,
                                        boolTeste: widget.child.boolTests,
                                      ),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.grey,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                                child: const AutoSizeText(
                                  'Audio',
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
}
