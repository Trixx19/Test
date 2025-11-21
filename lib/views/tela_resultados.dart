import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gonogo/views/components/appBar_personalizado.dart';

class TelaResultados extends StatefulWidget {
  final Map result;
  const TelaResultados({super.key, required this.result});

  @override
  State<TelaResultados> createState() => _TelaResultadosState();
}

class _TelaResultadosState extends State<TelaResultados> {
  @override
  Widget build(BuildContext context) {
    final listaTitulos = [
      "ERROS:",
      "OMISSÕES:",
      "ACERTOS:",
      "TOQUE:",
    ];
    final listaNotas = [
      "${widget.result['erros']}/15",
      "${widget.result['omissoes']}/45",
      "${widget.result['acertos']}/45",
      "${widget.result['qtde_cliques']}/45",
    ];
    final size = MediaQuery.of(context).size;
    final alturaTela = MediaQuery.of(context).size.height -
        (MediaQuery.of(context).padding.top +
            MediaQuery.of(context).padding.bottom);
    final padding = MediaQuery.of(context).padding;
    final espacamento = EdgeInsets.only(
      top: size.height * .01,
      bottom: size.height * .01,
    );

    return PopScope( // comportamento padrão já permite o pop
      // onWillPop: () async {
      //   Navigator.pop(context);
      //   return true;
      // },
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
                    image: AssetImage('assets/images/Fundo1.png'),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: size.height * .10),
                      child: const AutoSizeText(
                        "RESULTADOS",
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
                    SizedBox(
                      height: size.height * .60,
                      width: size.width * .90,
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: espacamento,
                            child: Center(
                              child: Container(
                                height: size.height * .10,
                                width: index == 0
                                    ? size.width * .50
                                    : size.width * .90,
                                decoration: BoxDecoration(
                                  color: (index == 0)
                                      ? Colors.black54
                                      : (index % 2 == 0)
                                          ? const Color(0xff1E70AD)
                                          : const Color(0xff3DB2E8),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(20),
                                  ),
                                ),
                                child: Center(
                                  child: SizedBox(
                                    width: size.width * .75,
                                    child: (index == 0)
                                        ? Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Align(
                                                alignment: Alignment.center,
                                                child: AutoSizeText(
                                                  widget.result["tipo"],
                                                  maxLines: 1,
                                                  minFontSize: 10,
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 25,
                                                    fontFamily: 'Montserrat',
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        : Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: AutoSizeText(
                                                  listaTitulos[index - 1],
                                                  maxLines: 1,
                                                  minFontSize: 10,
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 25,
                                                    fontFamily: 'Montserrat',
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: AutoSizeText(
                                                  listaNotas[index - 1],
                                                  maxLines: 1,
                                                  minFontSize: 10,
                                                  textAlign: TextAlign.right,
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 25,
                                                    fontFamily: 'Montserrat',
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        padding: const EdgeInsets.all(0),
                        itemCount: 5,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
