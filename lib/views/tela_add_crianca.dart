import 'package:auto_size_text/auto_size_text.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gonogo/controller/controller_children.dart';
import 'package:gonogo/models/utils/format.dart';
import 'package:gonogo/models/utils/validator.dart';
import 'package:gonogo/views/components/appBar_personalizado.dart';
import 'package:gonogo/models/utils/rotas-app.dart';
import 'package:gonogo/views/tela_add_crianca_perg.dart';

class TelaAddCrianca1 extends StatefulWidget {
  const TelaAddCrianca1({super.key});

  @override
  State<TelaAddCrianca1> createState() => _TelaAddCrianca1State();
}

class _TelaAddCrianca1State extends State<TelaAddCrianca1> {
  bool _carregar = true;
  final List racas = [" ", "Branca", "Preta", "Parda", "Indígena", "Amarela"];
  final List _sexo = [' ', 'Masculino', 'Feminino'];
  dynamic valorInicialR = " ";
  dynamic valorInicialS = " ";
  final TextEditingController _dataN = TextEditingController(text: "");
  final _key = GlobalKey<FormState>();
  final _formData = <String, dynamic>{};
  String _id = "";
  bool _submittedOnce = false;

  final _names = [
    "name",
    "date_birth",
    "color",
    "sex",
    "income",
    "time_gadgets",
    "time_play",
    "time_out",
  ];
  final _types = [
    TextInputType.text,
    TextInputType.number,
    TextInputType.number,
    TextInputType.text,
    TextInputType.number,
    TextInputType.number,
    TextInputType.number,
    TextInputType.number,
  ];

  final titles = [
    'Nome completo',
    'Data de nascimento',
    'Cor de pele',
    'Sexo',
    'Renda familiar',
    'Tempo(min) em frente a aparelhos eletrônicos em minutos',
    'Tempo(min) que brinca em casa',
    'Tempo(min) que brinca fora de casa',
  ];

  Future<void> _registerChild() async {
    setState(() {
      _submittedOnce = true;
    });

    final isValid = _key.currentState?.validate() ?? false;
    if (!isValid) {
      return;
    }
    _key.currentState?.save();
    setState(() {
      _carregar = true;
    });
    try {
      var cadastrar = await ControllerChildren().registerChild(_formData);
      _popUp("Dados cadastrados! Deseja preencher outras caracteristicas?");
      setState(() {
        _carregar = false;
        _id = cadastrar;
      });
    } catch (error) {
      _popUp("Erro ao tentar cadastrar a criança!");
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: size.height * .65,
                    width: largura,
                    child: Form(
                      key: _key,
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: espacamento,
                            child: SizedBox(
                              height: altura * 1.2,
                              child: (index == 2 || index == 3)
                                  ? DropdownButtonFormField(
                                      autovalidateMode: _submittedOnce
                                          ? AutovalidateMode.onUserInteraction
                                          : AutovalidateMode.disabled,
                                      initialValue: (index == 2)
                                          ? valorInicialR
                                          : valorInicialS,
                                      items: index == 3
                                          ? _sexo.map(
                                              (valueItem) {
                                                return DropdownMenuItem(
                                                  value: valueItem,
                                                  child:
                                                      AutoSizeText(valueItem),
                                                );
                                              },
                                            ).toList()
                                          : racas.map(
                                              (valueItem) {
                                                return DropdownMenuItem(
                                                  value: valueItem,
                                                  child:
                                                      AutoSizeText(valueItem),
                                                );
                                              },
                                            ).toList(),
                                      decoration: InputDecoration(
                                        label: AutoSizeText(
                                          titles[index],
                                          maxLines: 1,
                                          minFontSize: 1,
                                        ),
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                      dropdownColor: Colors.white,
                                      onChanged: (newValue) {
                                        if (index == 2) {
                                          setState(
                                            () {
                                              valorInicialR =
                                                  newValue.toString();
                                            },
                                          );
                                        } else {
                                          setState(() {
                                            valorInicialS = newValue.toString();
                                          });
                                        }
                                      },
                                      onSaved: (newValue) =>
                                          _formData[_names[index]] =
                                              newValue.toString(),
                                      validator: (newValidator) {
                                        return Validator()
                                            .validarCampoObrigatorio(
                                                newValidator as String?);
                                      },
                                    )
                                  : TextFormField(
                                      autovalidateMode: _submittedOnce
                                          ? AutovalidateMode.onUserInteraction
                                          : AutovalidateMode.disabled,
                                      keyboardType: _types[index],
                                      decoration: InputDecoration(
                                        label: AutoSizeText(
                                          titles[index],
                                          maxLines: 1,
                                          minFontSize: 1,
                                        ),
                                        helperText: " ",
                                        helperStyle: TextStyle(height: 0.8),
                                        errorStyle: TextStyle(height: 0.8),
                                      ),
                                      inputFormatters: [
                                        if (index == 1 || index > 3)
                                          FilteringTextInputFormatter
                                              .digitsOnly,
                                        if (index == 1)
                                          DataInputFormatter()
                                        else if (index == 4)
                                          FormatoReal()
                                      ],
                                      onChanged: ((value) {
                                        if (index == 1) {
                                          setState(() {
                                            _dataN.text = value;
                                          });
                                        }
                                      }),
                                      onSaved: (newValue) =>
                                          _formData[_names[index]] =
                                              newValue ?? '',
                                      validator: (value) {
                                        final valor = value ?? '';

                                        if (index <= 4) {
                                          final erroObrigatorio = Validator()
                                              .validarCampoObrigatorio(valor);
                                          if (erroObrigatorio != null) {
                                            return erroObrigatorio;
                                          }
                                        }

                                        if (index == 0) {
                                          return Validator().validarNome(valor);
                                        } else if (index == 1) {
                                          return Validator()
                                              .validarDataNascimento(valor);
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
                    height: size.height * .20,
                    child: Center(
                      child: SizedBox(
                        height: size.height * .09,
                        width: size.width * .70,
                        child: ElevatedButton(
                          onPressed: () {
                            _registerChild();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            padding: const EdgeInsets.all(0),
                          ),
                          child: const AutoSizeText(
                            'SEGUINTE',
                            maxLines: 1,
                            minFontSize: 10,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xff1E70AD),
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
    const valor = "Dados cadastrados! Deseja preencher outras caracteristicas?";
    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(30),
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
                                minFontSize: 10,
                                maxLines: 3,
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
                              child: msg == valor
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        SizedBox(
                                          height: size.height,
                                          width: size.width * .25,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (_) =>
                                                      TelaAddCriancaPerg1(
                                                    id: _id,
                                                  ),
                                                ),
                                              );
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  const Color(0xff48CC48),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30),
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
                                              Navigator.pushNamed(
                                                  context, RotasApp.menu);
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.grey,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30),
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
                                    )
                                  : SizedBox(
                                      height: size.height,
                                      width: size.width * .25,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.grey,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                        ),
                                        child: const AutoSizeText(
                                          'Fechar ',
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
