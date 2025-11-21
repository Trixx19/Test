import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gonogo/controller/controller_evaluator.dart';
import 'package:gonogo/models/utils/rotas-app.dart';
import 'package:gonogo/views/components/appBar_personalizado.dart';

class TelaRecuperarSenha extends StatefulWidget {
  const TelaRecuperarSenha({super.key});

  @override
  State<TelaRecuperarSenha> createState() => _TelaRecuperarSenhaState();
}

class _TelaRecuperarSenhaState extends State<TelaRecuperarSenha> {
  final TextEditingController _email = TextEditingController(text: " ");
  final _formKey = GlobalKey<FormState>();
  bool _carregar = true;
  final Map<String, String> _authData = {
    "email": '',
  };
  Future<void> _recSenha() async {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) {
      return;
    }
    _formKey.currentState?.save();
    final currentContext = context; //capturando contexto antes do await
    try {
      await ControllerEvaluator()
          .resetPassword(email: _authData["email"].toString());
      if (currentContext.mounted) {
        _popUp("Um link foi enviado para o seu email! Verifique por favor.");
      }
      setState(() {
        _carregar = false;
      });
    } catch (error) {
      if (currentContext.mounted) {
        _popUp(error.toString());
      }
    } finally {
      setState(() {
        _carregar = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final alturaTela = MediaQuery.of(context).size.height -
        (MediaQuery.of(context).padding.top +
            MediaQuery.of(context).padding.bottom);
    final padding = MediaQuery.of(context).padding;
    double largura = size.width * .80;
    final espacamento = EdgeInsets.only(
      top: size.height * .01,
      bottom: size.height * .01,
    );
    final titles = ["Email", "Confirmar email"];

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, dynamic result) {
        if (didPop) return;
        if (context.mounted) {
          Navigator.pushNamed(context, RotasApp.home);
        }
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          leading: const Center(
            child: IconButtonBack(
              navigator: '',
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
                    Padding(
                      padding: EdgeInsets.only(bottom: size.height * .10),
                      child: const AutoSizeText(
                        "RECUPERAR SENHA",
                        maxLines: 1,
                        minFontSize: 10,
                        style: TextStyle(
                          color: Color(0xff1E70AD),
                          fontSize: 30,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Form(
                      key: _formKey,
                      child: SizedBox(
                        height: size.height * .25,
                        width: largura,
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: espacamento,
                              child: SizedBox(
                                height: size.height * .10,
                                child: TextFormField(
                                  initialValue: ' ',
                                  onChanged: (value) {
                                    if (index == 0) {
                                      setState(() {
                                        _email.text = value.toString();
                                      });
                                    }
                                  },
                                  decoration: InputDecoration(
                                    labelText: titles[index],
                                  ),
                                  onSaved: (newValue) {
                                    if (index == 0) {
                                      _authData["email"] =
                                          newValue.toString().trim();
                                    }
                                  },
                                  validator: (value) {
                                    final email = value ?? '';
                                    if (email.trim().isEmpty) {
                                      return '*Campo obrigatório';
                                    } else if (!email.contains('@')) {
                                      return "Preencha com '@'";
                                    } else if (index == 1) {
                                      if (email != _email.text) {
                                        return 'O email não confere';
                                      }
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            );
                          },
                          padding: const EdgeInsets.all(0),
                          itemCount: titles.length,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: size.height * .15),
                      child: SizedBox(
                        height: size.height * .20,
                        child: Center(
                          child: SizedBox(
                            height: size.height * .09,
                            width: size.width * .70,
                            child: ElevatedButton(
                              onPressed: () {
                                _recSenha();
                              },
                              child: const AutoSizeText(
                                'CONFIRMAR',
                                maxLines: 1,
                                minFontSize: 10,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
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

  dynamic _popUp(String msg) {
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
                                maxLines: 3,
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
                                  RotasApp.login,
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xff48CC48),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              child: const AutoSizeText(
                                'FECHAR',
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
