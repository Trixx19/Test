import 'package:flutter/material.dart';
import 'package:gonogo/controller/controller_evaluator.dart';
import 'package:gonogo/models/utils/rotas-app.dart';

class BotaoEntrarSair extends StatelessWidget {
  final BuildContext context;
  final String navigator;
  final Color corBotao;
  final String texto;
  final Color corTexto;

  const BotaoEntrarSair({
    required this.context,
    required this.navigator,
    required this.corBotao,
    required this.texto,
    required this.corTexto,
    super.key,
  });

  Future _logout() async {
try {
      await ControllerEvaluator().logout();
      Future(() { // adicionando o context.mounted para a versão mais nova do context
        if (context.mounted) {
          Navigator.pushNamed(context, RotasApp.login);
        }
      });
    } catch (error) {
      if (context.mounted) {
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * .10,
      width: size.width * .40,
      child: ElevatedButton(
        onPressed: () => _logout(),
        style: ElevatedButton.styleFrom(
          backgroundColor: corBotao,
        ),
        child: Text(
          texto,
          style: TextStyle(
            color: corTexto,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
