import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gonogo/models/utils/rotas-app.dart';
import 'package:gonogo/views/components/appBar_personalizado.dart';

class TelaSobre extends StatelessWidget {
  const TelaSobre({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final alturaTela = MediaQuery.of(context).size.height -
        (MediaQuery.of(context).padding.top +
            MediaQuery.of(context).padding.bottom);
    final padding = MediaQuery.of(context).padding;
    final titles = [
      "Pesquisadores: ",
      "Desenvolvedores: ",
      "Gerente do Projeto: ",
    ];
    final values = [
      "Prof.Dr: Glauber Carvalho Nobre",
      "Prof.Dr: Rodrigo Flores Sartori",
    ];
    final values0 = [
      "Francisco Andeson Sousa da Silva",
      "Lucas Silva Correa",
    ];
    final values1 = ["Rubens Abraão da Silva Sousa"];

    int index = 0;
    var myFirstGroup = AutoSizeGroup();

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: const Center(
          child: IconButtonBack(
            navigator: RotasApp.home,
          ),
        ),
        centerTitle: true,
        title: const AutoSizeText(
          "Sobre",
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
                  image: AssetImage(
                    'assets/images/Fundo1.png',
                  ),
                  fit: BoxFit.fill,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: size.height * .34,
                    width: size.width * .90,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      // color: Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: SizedBox(
                        height: size.height * .30,
                        width: size.width * .80,
                        child: const AutoSizeText.rich(
                          TextSpan(
                            text:
                                "O aplicativo tem como finalidade auxiliar profissionais da neuropsicologia, da educação física e psicomotricidade quanto as avaliações do controle inibitório por meio do paradigma GoNoGo.\nFoi proposto pelo Grupo Discente de Programação e Projetos Inovadores do IFCE, campus Canindé.\nEm caso de problemas com a utilização do aplicativo entre em contato com ",
                            style: TextStyle(
                              fontSize: 100,
                            ),
                            children: [
                              TextSpan(
                                text: "suporte@gdppi.ifce.edu.br",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 100,
                                ),
                              ),
                            ],
                          ),
                          maxLines: 12,
                          minFontSize: 1,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 100,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: size.height * .03,
                      bottom: size.height * .03,
                    ),
                    child: SizedBox(
                      height: size.height * .35,
                      width: size.width * .90,
                      child: Center(
                        child: Column(
                          children: [
                            for (index = 0; index < 3; index++)
                              Padding(
                                padding: index == 1
                                    ? EdgeInsets.only(
                                        top: size.height * .01,
                                        bottom: size.height * .01,
                                      )
                                    : const EdgeInsets.all(0),
                                child: SizedBox(
                                  height: size.height * .11,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          bottom: 5,
                                        ),
                                        child: AutoSizeText(
                                          titles[index],
                                          maxLines: 1,
                                          minFontSize: 1,
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      AutoSizeText(
                                        index == 0
                                            ? values[0]
                                            : index == 1
                                                ? values0[0]
                                                : values1[0],
                                        maxLines: 2,
                                        minFontSize: 1,
                                        group: myFirstGroup,
                                        style: const TextStyle(
                                          fontSize: 17,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                      if (index != 2)
                                        AutoSizeText(
                                          index == 0
                                              ? values[1]
                                              : index == 1
                                                  ? values0[1]
                                                  : "",
                                          maxLines: 1,
                                          minFontSize: 1,
                                          group: myFirstGroup,
                                          style: const TextStyle(
                                            fontSize: 17,
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: size.height * .04,
                    ),
                    child: Center(
                      child: SizedBox(
                        height: size.height * .07,
                        child: Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.black,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Image.asset(
                                "assets/images/logo_gdppi.png",
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
