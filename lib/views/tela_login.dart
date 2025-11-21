import 'package:flutter/material.dart';
import 'package:gonogo/controller/controller_evaluator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'components/appBar_personalizado.dart';
import '../models/utils/rotas-app.dart';
import 'package:auto_size_text/auto_size_text.dart';

class TelaLogin extends StatefulWidget {
  const TelaLogin({super.key});

  @override
  State<TelaLogin> createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  bool isChecked = false;
  final _formKey = GlobalKey<FormState>();
  bool _carregar = true;
  final Map<String, String> _authData = {
    "email": '',
    "senha": '',
  };
  bool iniciar = true;
  _verUsuario() async {
    int valor = await ControllerEvaluator().seeUser();
    // Navigator.pop(context);
    if (valor == 1) {
      Future(() {
        if (mounted) {
          // adicionando mounted
          Navigator.pushNamed(context, RotasApp.menu);
        }
      });
    }
  }

  Future _fazerLogin() async {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) {
      return;
    }
    _formKey.currentState?.save();
    final currentContext =
        context; // adicionando variavel para o contexto atual antes do await
    try {
      _popUp("");
      await ControllerEvaluator().login(_authData);
      if (currentContext.mounted) {
        Navigator.pop(currentContext);
        Navigator.pushNamed(currentContext, RotasApp.menu);
      }
    } catch (error) {
      if (currentContext.mounted) {
        Navigator.pop(currentContext);
        _popUp(error.toString());
      }
    } finally {
      setState(() {
        _carregar = false;
      });
    }
  }

  _lembrar() async {
    final prefs = await SharedPreferences.getInstance();
    if (isChecked) {
      //Salvar
      await prefs.setString("email", _authData["email"] ?? ""); // mudando todos para strings vazias, 
      await prefs.setString("senha", _authData["senha"] ?? ""); // para evitar trabalho do usuário de apagar
      await prefs.setBool("lembrar", isChecked);
    } else {
      prefs.remove("email");
      prefs.remove("senha");
      prefs.remove("lembrar");
    }
  }

  _recuperar() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _email.text = prefs.getString("email") ?? "";
      _password.text = prefs.getString("senha") ?? "";
      isChecked = prefs.getBool("lembrar") ?? false;
    });
  }

  @override
  void initState() {
    _verUsuario();
    _recuperar();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final alturaTela = MediaQuery.of(context).size.height -
        (MediaQuery.of(context).padding.top +
            MediaQuery.of(context).padding.bottom);
    final padding = MediaQuery.of(context).padding;
    final espacamento = EdgeInsets.only(
      top: size.height * .01,
      bottom: size.height * .01,
    );
    final titles = ["Email", "Senha"];
    double altura = size.height * .08;
    double largura = size.width * .80;

    return PopScope(
      // mudando para o popscore
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
              navigator: RotasApp.home,
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: size.height * .20,
                      width: size.width * .30,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/Logo.png'),
                        ),
                      ),
                    ),
                    Form(
                      key: _formKey,
                      child: SizedBox(
                        height: size.height * .20,
                        width: largura,
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: espacamento,
                              child: SizedBox(
                                height: altura,
                                child: TextFormField(
                                  controller: index == 0 ? _email : _password,
                                  decoration: InputDecoration(
                                    labelText: titles[index],
                                  ),
                                  obscureText: index == 1 ? true : false,
                                  onSaved: (newValue) {
                                    if (index == 0) {
                                      _authData["email"] =
                                          newValue.toString().trim();
                                    } else {
                                      _authData["senha"] = newValue ?? "";
                                    }
                                  },
                                  validator: (value) {
                                    final valores = value ?? "";
                                    if (valores.trim().isEmpty) {
                                      return "Campo obrigatório";
                                    } else if (index == 0 &&
                                        !valores.contains("@")) {
                                      return "Preencha com '@'";
                                    } else if (index == 1 &&
                                        valores.length < 6) {
                                      return "Preecha com pelo menos 6 caracteres!";
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
                    SizedBox(
                      width: size.width * .80,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: TextButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, RotasApp.recuperarSenha);
                          },
                          child: const AutoSizeText(
                            'Esqueceu sua senha?',
                            maxLines: 1,
                            minFontSize: 10,
                            maxFontSize: 20,
                            style: TextStyle(
                              color: Color(0xff48CC48),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const AutoSizeText(
                          'Lembrar-me',
                          maxLines: 1,
                          minFontSize: 10,
                          maxFontSize: 20,
                          style: TextStyle(
                            color: Color(0xff48CC48),
                          ),
                        ),
                        Checkbox(
                          value: isChecked,
                          onChanged: (bool? value) {
                            setState(() {
                              isChecked = value!;
                            });
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.height * .12,
                      width: size.width * .80,
                      child: Center(
                        child: SizedBox(
                          height: size.height * .09,
                          width: size.width * .70,
                          child: ElevatedButton(
                            onPressed: () {
                              _fazerLogin();
                              _lembrar();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                            ),
                            child: const AutoSizeText(
                              'ENTRAR',
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
                                Navigator.of(context).pop(); // simplesmente fecha o dialogo
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
