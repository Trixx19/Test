import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gonogo/controller/controller_children.dart';
import 'package:gonogo/models/child.dart';
import 'package:gonogo/models/utils/export.dart';
import 'package:gonogo/views/tela_perfil_crianca.dart';
import 'components/appBar_personalizado.dart';
import '../models/utils/rotas-app.dart';

class TelaCriancasCadastradas extends StatefulWidget {
  const TelaCriancasCadastradas({super.key});

  @override
  State<TelaCriancasCadastradas> createState() =>
      _TelaCriancasCadastradasState();
}

class _TelaCriancasCadastradasState extends State<TelaCriancasCadastradas> {
  final _controller = StreamController<QuerySnapshot>.broadcast();
  final TextEditingController _pesquisarCrianca = TextEditingController();
  List<Child> children = [];
  List<Child> search = [];
  void _carregarCriancas() async {
    final stream = await ControllerChildren().loadChildren();
    stream.listen((event) {
      _controller.add(event);
    });
  }

  _pesquisar() {
    setState(() {
      search.clear();
      search = children
          .where((element) => element.completeName
              .toLowerCase()
              .contains(_pesquisarCrianca.text.toString().toLowerCase()))
          .toList();
    });
  }

  @override
  void initState() {
    _carregarCriancas();
    super.initState();
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

    return PopScope( // trocando pelo popscope
      canPop: false,
      onPopInvokedWithResult: (bool didPop, dynamic result) {
        if (didPop) return; 
        if (context.mounted) {
          Navigator.pushNamed(context, RotasApp.menu);
        }
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          leading: const Center(
            child: IconButtonBack(
              navigator: RotasApp.menu,
            ),
          ),
          centerTitle: true,
          title: const AutoSizeText(
            'CRIANÇAS CADASTRADAS',
            minFontSize: 12,
            maxFontSize: 22,
            maxLines: 1,
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
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: size.height * .10),
                      child: SizedBox(
                        width: largura,
                        child: TextFormField(
                          controller: _pesquisarCrianca,
                          textAlign: TextAlign.left,
                          onChanged: (value) {
                            _pesquisar();
                          },
                          decoration: InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            fillColor: Colors.white,
                            label: const AutoSizeText(
                              'Pesquisar criança...',
                              maxLines: 1,
                              minFontSize: 12,
                              style: TextStyle(
                                color: Color(0xff0585D1), fontSize: 18,
                                // fontWeight: FontWeight.bold,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            contentPadding:
                                const EdgeInsets.only(left: 12, right: 12),
                            suffixIcon: const Icon(Icons.search),
                          ),
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: size.height * .05),
                      child: SizedBox(
                        height: size.height * .70,
                        width: largura,
                        child: StreamBuilder<QuerySnapshot>(
                          stream: _controller.stream,
                          builder: (context, snapshot) {
                            try {
                              switch (snapshot.connectionState) {
                                case ConnectionState.none:
                                case ConnectionState.waiting:
                                  return Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        CircularProgressIndicator(),
                                        Text("Carregando informações")
                                      ],
                                    ),
                                  );
                                case ConnectionState.active:
                                case ConnectionState.done:
                                  if (snapshot.hasError) {
                                    return const Expanded(
                                      child: Text("Erro ao carregar dados"),
                                    );
                                  } else {
                                    QuerySnapshot querySnapshot =
                                        snapshot.data as QuerySnapshot;
                                    return ListView.builder(
                                      itemBuilder: (context, index) {
                                        List<DocumentSnapshot> criancas =
                                            querySnapshot.docs.toList();

                                        Child crianca = Child(
                                          criancas[index].id,
                                          criancas[index]["nome"],
                                          criancas[index]["data_de_nascimento"],
                                          criancas[index]["cor"],
                                          criancas[index]["sexo"],
                                          criancas[index]["renda"],
                                          criancas[index]["tempo_aparelhos"],
                                          criancas[index]["tempo_em_casa"],
                                          criancas[index]["tempo_fora"],
                                          criancas[index]["boolTestes"],
                                        );

                                        if (children.length < criancas.length) {
                                          children.add(crianca);
                                        }

                                        return Padding(
                                          padding: espacamento,
                                          child: SizedBox(
                                            height: altura,
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.white,
                                              ),
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (_) =>
                                                        TelaPerfilCriancaSelecionada(
                                                      child: _pesquisarCrianca
                                                              .text.isEmpty
                                                          ? crianca
                                                          : search[index],
                                                      local: 0,
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: AutoSizeText(
                                                _pesquisarCrianca.text.isEmpty
                                                    ? children[index]
                                                        .completeName
                                                    : search[index]
                                                        .completeName,
                                                maxLines: 1,
                                                minFontSize: 10,
                                                style: const TextStyle(
                                                  fontSize: 22,
                                                  color: Color(0xff1E70AD),
                                                  fontFamily: 'Montserrat',
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      padding: const EdgeInsets.all(0),
                                      itemCount: _pesquisarCrianca.text.isEmpty
                                          ? querySnapshot.docs.length
                                          : search.length,
                                    );
                                  }
                              }
                            } catch (error) {
                              return const Text(
                                  "Erro ao tentar carregar os dados!");
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: Export(
          size: size,
          children: children,
        ),
      ),
    );
  }
}
