import 'package:flutter/material.dart';
import 'package:gonogo/controller/controller_evaluator.dart';
import 'package:gonogo/models/utils/rotas-app.dart';

class VerLogin {
  resultado(BuildContext context) async {
    int logado = await ControllerEvaluator().seeUser();
    if (logado != 1) {
      // ignore: use_build_context_synchronously
      Navigator.pushNamed(context, RotasApp.login);
    }
  }
}
