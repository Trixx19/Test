import 'package:flutter/material.dart';

class BotaoNextFinished extends StatelessWidget {
  final BuildContext context;
  final String navigator;
  final Color corBotao;
  final String texto;
  final Color corTexto;

  const BotaoNextFinished({
    required this.context,
    required this.navigator,
    this.corBotao = Colors.white,
    required this.texto,
    this.corTexto = const Color(0xff1E70AD),
    super.key,
  });

  void _botaoNextFinished(BuildContext context) {
    Navigator.of(context).pushNamed(navigator);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SizedBox(
      height: size.height * .09,
      width: size.width * .70,
      child: ElevatedButton(
        onPressed: () => _botaoNextFinished(context),
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
