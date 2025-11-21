import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../models/utils/rotas-app.dart';
import 'components/botao_next_finished.dart';
import 'package:flutter/services.dart';

class TelaHome extends StatefulWidget {
  const TelaHome({super.key});

  @override
  State<TelaHome> createState() => _TelaHomeState();
}

class _TelaHomeState extends State<TelaHome> {
  DateTime pressionar = DateTime.now();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final altura = MediaQuery.of(context).size.height -
        (MediaQuery.of(context).padding.top +
            MediaQuery.of(context).padding.bottom);
    final padding = MediaQuery.of(context).padding;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, dynamic result) {
        if (didPop) return;
        final diferenca = DateTime.now().difference(pressionar);
        final avisoSair = diferenca >= const Duration(seconds: 2);
        pressionar = DateTime.now();

        if (avisoSair) {
          Fluttertoast.showToast(
              msg: "Pressione novamente para sair", fontSize: 18
        );} else {
          Fluttertoast.cancel();
          SystemNavigator.pop();
        }
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            Center(
              child: Padding(
                padding: EdgeInsets.only(right: size.width * .02),
                child: SizedBox(
                  height: size.height * .07,
                  child: FloatingActionButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(RotasApp.sobre);
                    },
                    backgroundColor: const Color(0xff48CC48),
                    tooltip: "Sobre",
                    heroTag: 'btn1',
                    child: const Icon(
                      Icons.question_mark,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
          toolbarHeight: size.height * .08,
        ),
        body: SingleChildScrollView(
          padding: padding,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: altura,
                width: size.width,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/Fundo1.png'),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: size.height * .20,
                      width: size.width * .30,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/Logo.png'),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    AutoSizeText(
                      'GONOGO\nMotor Control',
                      maxLines: 2,
                      minFontSize: 30,
                      maxFontSize: 50,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    SizedBox(
                      height: size.height * .25,
                      width: size.width * .80,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: size.height * .11,
                            child: Center(
                              child: BotaoNextFinished(
                                context: context,
                                navigator: RotasApp.login,
                                texto: 'ENTRAR',
                              ),
                            ),
                          ),
                          SizedBox(
                            height: size.height * .11,
                            child: Center(
                              child: BotaoNextFinished(
                                context: context,
                                navigator: RotasApp.cadastro,
                                texto: 'CADASTRO',
                                corBotao: const Color(0xff48CC48),
                                corTexto: Colors.white,
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
}
