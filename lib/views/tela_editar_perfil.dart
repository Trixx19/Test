import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gonogo/controller/controller_evaluator.dart';
import 'package:gonogo/models/utils/rotas-app.dart';
import 'package:gonogo/models/utils/validator.dart';
import 'package:gonogo/views/components/appBar_personalizado.dart';
import 'package:image_picker/image_picker.dart';

class TelaEditarPerfil extends StatefulWidget {
  const TelaEditarPerfil({super.key});

  @override
  State<TelaEditarPerfil> createState() => _TelaEditarPerfilState();
}

class _TelaEditarPerfilState extends State<TelaEditarPerfil> {
  File? _imagemSelecionada;
  String email = "";
  String urlImage = "";
  bool carregar = false;

  final _key = GlobalKey<FormState>();
  final _formData = <String, dynamic>{};

  final List<TextEditingController> _controllers = [
    TextEditingController(text: " "),
    TextEditingController(text: " "),
    TextEditingController(),
    TextEditingController(),
  ];

  _dadosPerfil() async {
    final dados = await ControllerEvaluator().seeProfile();
    if (mounted) {
      setState(() {
        _controllers[0].text = dados[1]["nome"];
        _controllers[1].text = dados[0];
        email = dados[0];
        urlImage = dados[1]["foto_perfil"];
      });
    }
  }

  Future _recuperarImagem() async {
    final picker = ImagePicker();
    XFile? imagem;
    try {
      imagem = await picker.pickImage(source: ImageSource.gallery);
    } catch (e) {
      if (mounted) {
        _popUp("Erro ao selecionar imagem.");
      }
      return;
    }

    final XFile? tempImage = imagem;

    if (tempImage != null) {
      if (mounted) {
        setState(() {
          _imagemSelecionada = File(tempImage.path);
          carregar = true;
        });
      }
      _uploadImagem();
    }
  }

  Future _uploadImagem() async {
    if (!mounted) return;
    setState(() {
      carregar = true;
    });
    try {
      var image = await ControllerEvaluator().upload(_imagemSelecionada!);
      if (mounted) {
        setState(() {
          urlImage = image;
        });
      }
    } catch (error) {
      if (mounted) {
        _popUp("Erro ao fazer upload da imagem: ${error.toString()}");
      }
    } finally {
      if (mounted) {
        setState(() {
          carregar = false;
        });
      }
    }
  }

  Future<void> _atualizar() async {
    final isValid = _key.currentState?.validate() ?? false;
    if (!isValid) {
      return;
    }
    _key.currentState?.save();

    if (mounted) {
      _popUp("Salvando...");
    }

    try {
      final newPassword = _controllers[2].text;

      await ControllerEvaluator().updateUser(_formData["nome"], email,
          _formData["email"], newPassword.isNotEmpty ? newPassword : "******");

      if (mounted) {
        Navigator.pop(context);
        _popUp("Dados Alterados com Sucesso! \n Verifique o e-mail Cadastrado");

        setState(() {
          _controllers[2].clear();
          _controllers[3].clear();
          email = _formData["email"];
        });
      }
    } catch (error) {
      if (mounted) {
        Navigator.pop(context);
        _popUp(error.toString());
      }
    } finally {
      if (mounted) {
        setState(() {
          carregar = false;
        });
      }
    }
  }

  @override
  void initState() {
    _dadosPerfil();
    super.initState();
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
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
      "Nome",
      "E-mail",
      "Nova senha (opcional)",
      "Confirmar nova senha"
    ];
    final names = ["nome", "email", "novaSenha", "confirmarNovaSenha"];

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        leading: const Center(
          child: IconButtonBack(
            navigator: RotasApp.menu,
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
                    height: size.height * .30,
                    width: size.width * .40,
                    child: Stack(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16),
                          child: carregar
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    CircularProgressIndicator(
                                        color: Color(0xff1E70AD)),
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text("Carregando..."),
                                    )
                                  ],
                                )
                              : Center(
                                  child: Container(
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
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: SizedBox(
                            height: size.height * .08,
                            width: size.width * .08,
                            child: FloatingActionButton(
                              heroTag: 'btn1',
                              onPressed: () {
                                _recuperarImagem();
                              },
                              child: const Icon(Icons.edit),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: size.height * .01),
                    child: SizedBox(
                      height: size.height * .45,
                      width: size.width * .80,
                      child: Form(
                        key: _key,
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: espacamento,
                              child: SizedBox(
                                height: altura * 1.5,
                                child: TextFormField(
                                  controller: _controllers[index],
                                  obscureText:
                                      index == 2 || index == 3 ? true : false,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  decoration: InputDecoration(
                                    labelText: titles[index],
                                    helperText: " ",
                                    helperStyle: TextStyle(height: 0.8),
                                    errorStyle: TextStyle(height: 0.8),
                                  ),
                                  onChanged: (value) {
                                    if (index == 2) {
                                      _controllers[3].text =
                                          _controllers[3].text;
                                    }
                                  },
                                  onSaved: (newValue) {
                                    if (index < 3) {
                                      _formData[names[index]] = newValue ?? '';
                                    }
                                  },
                                  validator: (value) {
                                    final validator = Validator();
                                    final valores = value ?? '';

                                    switch (index) {
                                      case 0:
                                        return validator.validarNome(valores);
                                      case 1:
                                        return validator.validarEmail(valores);
                                      case 2:
                                        return validator
                                            .validarNovaSenhaOpcional(valores);
                                      case 3:
                                        return validator
                                            .validarConfirmarNovaSenha(
                                                valores, _controllers[2].text);
                                      default:
                                        return null;
                                    }
                                  },
                                ),
                              ),
                            );
                          },
                          itemCount: titles.length,
                          padding: const EdgeInsets.all(0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * .13,
                    child: SizedBox(
                      height: size.height * .11,
                      width: largura,
                      child: Center(
                        child: SizedBox(
                          height: size.height * .09,
                          width: size.width * .70,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xff1E70AD),
                            ),
                            onPressed: () {
                              _atualizar();
                            },
                            child: const AutoSizeText(
                              'SALVAR',
                              maxLines: 1,
                              minFontSize: 10,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  dynamic _popUp(String msg) {
    const variavel = "Dados alterados com sucesso";
    final bool isSaving = msg == "Salvando...";

    return showDialog(
      context: context,
      barrierDismissible: !isSaving,
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
              child: isSaving
                  ? const Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircularProgressIndicator(
                            color: Color(0xff1E70AD),
                          ),
                          SizedBox(height: 20),
                          Text(
                            "Salvando...",
                            style: TextStyle(
                              color: Color(0xff1E70AD),
                              fontSize: 20,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
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
                                if (msg == variavel) {
                                  Navigator.pop(context);
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
                                (msg == variavel) ? "OK" : "FECHAR",
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
