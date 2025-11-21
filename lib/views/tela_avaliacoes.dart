import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gonogo/controller/controller_children.dart';
import 'package:gonogo/views/components/appBar_personalizado.dart';
import 'package:gonogo/views/tela_resultados.dart';

class TelaAvaliacoes extends StatefulWidget {
  final String id;
  const TelaAvaliacoes({super.key, required this.id});

  @override
  State<TelaAvaliacoes> createState() => _TelaAvaliacoesState();
}

class _TelaAvaliacoesState extends State<TelaAvaliacoes> {
  final _controller = StreamController<QuerySnapshot>.broadcast();
  _carregarAvaliacoes() async {
    final stream = await ControllerChildren().loadReviews(widget.id);
    stream.listen((event) {
      _controller.add(event);
    });
  }

  @override
  void initState() {
    _carregarAvaliacoes();
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

    return PopScope( // willPopScope agora é PopScope e o padrão dele já permite fazer o pop da tela
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
          centerTitle: true,
          title: const AutoSizeText(
            'AVALIAÇÕES',
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
                    image: AssetImage('assets/images/Fundo1.png'),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: size.height * .70,
                      child: Center(
                          child: StreamBuilder<QuerySnapshot>(
                        stream: _controller.stream,
                        builder: (context, snapshot) {
                          try {
                            switch (snapshot.connectionState) {
                              case ConnectionState.none:
                              case ConnectionState.waiting:
                                return Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                      List<DocumentSnapshot> avaliacoes =
                                          querySnapshot.docs.toList();
                                      return Padding(
                                        padding: espacamento,
                                        child: Center(
                                          child: SizedBox(
                                            height: size.height * .08,
                                            width: size.width * .80,
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.white,
                                              ),
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (_) =>
                                                          TelaResultados(
                                                              result: {
                                                            "tipo": avaliacoes[
                                                                index]["tipo"],
                                                            "erros": avaliacoes[
                                                                index]["erros"],
                                                            "acertos":
                                                                avaliacoes[
                                                                        index]
                                                                    ["acertos"],
                                                            "omissoes":
                                                                avaliacoes[
                                                                        index][
                                                                    "omissoes"],
                                                            "qtde_cliques":
                                                                avaliacoes[
                                                                        index][
                                                                    "qtde_cliques"],
                                                          }),
                                                    ));
                                              },
                                              child: AutoSizeText(
                                                avaliacoes[index]
                                                    ["data_avaliacao"],
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
                                        ),
                                      );
                                    },
                                    padding: const EdgeInsets.all(0),
                                    itemCount: querySnapshot.docs.length,
                                  );
                                }
                            }
                          } catch (error) {
                            return const Text(
                                "Erro ao tentar carregar os dados!");
                          }
                        },
                      )),
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
}
