import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gonogo/controller/controller_evaluator.dart';
import 'package:gonogo/models/utils/ver_login.dart';
import 'components/botao_next_finished.dart';
import 'components/botao_entrar_sair.dart';
import '../models/utils/rotas-app.dart';

class TelaMenu extends StatefulWidget {
  const TelaMenu({super.key});

  @override
  State<TelaMenu> createState() => _TelaMenuState();
}

class _TelaMenuState extends State<TelaMenu> {
  String urlImage = "";

  _foto() async {
    var dados = await ControllerEvaluator().seeProfile();
    setState(() {
      urlImage = dados[1]["foto_perfil"];
    });
  }

  @override
  void initState() {
    _foto();
    VerLogin().resultado(context);
    super.initState();
  }

  DateTime pressionar = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final alturaTela = MediaQuery.of(context).size.height -
        (MediaQuery.of(context).padding.top +
            MediaQuery.of(context).padding.bottom);
    final padding = MediaQuery.of(context).padding;
    const largura = .11;
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, dynamic result) {
        if (didPop) return;
        final diferenca = DateTime.now().difference(pressionar);
        final avisoSair = diferenca >= const Duration(seconds: 2);
        pressionar = DateTime.now();

        if (avisoSair) {
          Fluttertoast.showToast(
              msg: "Pressione novamente para sair", fontSize: 18);
        } else {
          Fluttertoast.cancel();
          if (Platform.isAndroid) {
            SystemNavigator.pop();
          } else {
            exit(0);
          }
        }
      },
      child: Scaffold(
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: size.height * .30,
                      width: size.width * .40,
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              height: size.height * .20,
                              width: size.height * .20,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: CircleAvatar(
                                radius: size.height * .20,
                                backgroundImage: urlImage.isNotEmpty
                                    ? NetworkImage(urlImage)
                                    : const NetworkImage(
                                        "https://firebasestorage.googleapis.com/v0/b/gonogomobile-fb16c.appspot.com/o/FotoAdd.jpg?alt=media&token=30a21fea-75b9-4ec6-8ea5-58b317807f15"),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: SizedBox(
                              height: size.height * .08,
                              width: size.width * .08,
                              child: FloatingActionButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, RotasApp.editarPerfil);
                                },
                                child: const Icon(Icons.edit),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: size.height * largura,
                      child: Center(
                        child: BotaoNextFinished(
                          context: context,
                          texto: 'ADD. CRIANÇA',
                          navigator: RotasApp.addCrianca,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * largura,
                      child: Center(
                        child: BotaoNextFinished(
                          context: context,
                          texto: 'AVALIAR',
                          navigator: RotasApp.criancasCadastradas,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * largura,
                      child: Center(
                        child: BotaoNextFinished(
                          context: context,
                          texto: 'RESULTADOS',
                          navigator: RotasApp.criancasAvaliadas,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: size.height * .12,
                      child: Center(
                        child: BotaoEntrarSair(
                          context: context,
                          navigator: RotasApp.home,
                          corBotao: Colors.red,
                          texto: "SAIR",
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
      ),
    );
  }
}
