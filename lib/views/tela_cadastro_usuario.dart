import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gonogo/controller/controller_evaluator.dart';
import 'package:gonogo/models/utils/validator.dart';
import 'components/appBar_personalizado.dart';
import '../models/utils/rotas-app.dart';

class TelaCadastroUsuario extends StatefulWidget {
  const TelaCadastroUsuario({super.key});

  @override
  State<TelaCadastroUsuario> createState() => _TelaCadastroUsuarioState();
}

class _TelaCadastroUsuarioState extends State<TelaCadastroUsuario> {
  final _key = GlobalKey<FormState>();
  final _formData = <String, dynamic>{};
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormFieldState> _passwordKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _confirmPasswordKey =
      GlobalKey<FormFieldState>();

  bool _carregar = false;

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    final isValid = _key.currentState?.validate() ?? false;
    if (!isValid) {
      return;
    }
    _key.currentState?.save();
    setState(() {
      _carregar = true;
    });
    final currentContext = context;
    _popUp("");
    try {
      await ControllerEvaluator().register(_formData);
      setState(() {
        _carregar = false;
      });
      if (currentContext.mounted) {
        _popUp("Cadastro realizado com sucesso!");
      }
    } catch (error) {
      if (currentContext.mounted) {
        Navigator.pop(currentContext);
        setState(() {
          _carregar = false;
        });
        _popUp(error.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final alturaTela = MediaQuery.of(context).size.height -
        (MediaQuery.of(context).padding.top +
            MediaQuery.of(context).padding.bottom);
    final padding = MediaQuery.of(context).padding;
    double altura = size.height * .08;
    double largura = size.width * .80;
    final espacamento = EdgeInsets.only(
      top: size.height * .01,
      bottom: size.height * .01,
    );
    final titles = [
      "Nome completo",
      "Instituição",
      "E-mail",
      "Senha",
      "Confirmar senha",
    ];
    final names = [
      "name",
      "institution",
      "email",
      "password",
      "confirmPassword"
    ];

    return Scaffold(
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
                  image: AssetImage('assets/images/Fundo1.png'),
                  fit: BoxFit.fill,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Form(
                    key: _key,
                    child: SizedBox(
                      height: size.height * .60,
                      width: size.width * .80,
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: espacamento,
                            child: SizedBox(
                              height: altura * 1.5,
                              child: TextFormField(
                                key: (index == 3)
                                    ? _passwordKey
                                    : (index == 4)
                                        ? _confirmPasswordKey
                                        : null,
                                controller:
                                    (index == 3) ? _passwordController : null,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                decoration: InputDecoration(
                                  labelText: titles[index],
                                  helperText: " ",
                                  helperStyle: TextStyle(height: 0.8),
                                  errorStyle: TextStyle(height: 0.8),
                                ),
                                onSaved: (newValue) {
                                  if (index < 4) {
                                    _formData[names[index]] = newValue ?? '';
                                  }
                                },
                                obscureText: (index > 2) ? true : false,
                                onChanged: (index == 3)
                                    ? (value) {
                                        if (_passwordKey.currentState != null) {
                                          _passwordKey.currentState!.validate();
                                        }
                                        if (_confirmPasswordKey.currentState !=
                                            null) {
                                          _confirmPasswordKey.currentState!
                                              .validate();
                                        }
                                      }
                                    : null,
                                validator: (value) {
                                  final validator = Validator();
                                  switch (index) {
                                    case 0:
                                      return validator.validarNome(value);
                                    case 1:
                                      return validator.validarNome(value);
                                    case 2:
                                      return validator.validarEmail(value);
                                    case 3:
                                      return validator.validarSenha(value);
                                    case 4:
                                      return validator.validarConfirmarSenha(
                                          value, _passwordController.text);
                                    default:
                                      return null;
                                  }
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
                    height: size.height * .20,
                    child: SizedBox(
                      height: size.height * .11,
                      width: largura,
                      child: Center(
                        child: SizedBox(
                          height: size.height * .09,
                          width: size.width * .70,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                            ),
                            onPressed: () {
                              _register();
                            },
                            child: const Text(
                              'FINALIZAR',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xff1E70AD),
                              ),
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
    );
  }

  dynamic _popUp(String msg) {
    const variavel = "Cadastro realizado com sucesso!";
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
                        color: Color(0xff1E70AD),
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
                                minFontSize: 10,
                                maxLines: 3,
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
                                if (msg == variavel) {
                                  Navigator.pushNamedAndRemoveUntil(
                                    context,
                                    RotasApp.menu,
                                    (route) => false,
                                  );
                                } else {
                                  Navigator.pop(context);
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xff48CC48),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              child: AutoSizeText(
                                (msg == variavel) ? "CONTINUAR" : "FECHAR",
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
