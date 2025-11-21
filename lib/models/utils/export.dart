import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gonogo/models/child.dart';
import 'package:gonogo/models/tests.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'package:universal_html/html.dart' show AnchorElement;
import 'package:flutter/foundation.dart' show kIsWeb;

class Export extends StatefulWidget {
  final List<Child> children;
  final dynamic size;
  const Export({super.key, required this.size, required this.children});

  @override
  State<Export> createState() => _ExportState();
}

class _ExportState extends State<Export> {
  List<Tests> testes = [];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.size.height * .07,
      child: FloatingActionButton(
        heroTag: 'btn2',
        child: const Icon(
          Icons.download_rounded,
        ),
        onPressed: () {
          criarArquivo();
        },
      ),
    );
  }

  Future<void> criarArquivo() async {
    final Workbook workbook = Workbook();
    final Worksheet sheet = workbook.worksheets[0];

    //Estilo coluna
    Style cabecalho = workbook.styles.add('style');
    cabecalho.hAlign = HAlignType.center;
    cabecalho.vAlign = VAlignType.center;
    cabecalho.borders.all.lineStyle = LineStyle.thin;
    cabecalho.fontName = 'Arial';
    cabecalho.bold = true;
    cabecalho.backColor = '#42A5F5';
    sheet.getRangeByName('A1:K1').cellStyle = cabecalho;

    //Estilos das celulas
    final Style celulasTestes = workbook.styles.add('globalStyle');
    celulasTestes.hAlign = HAlignType.center;
    celulasTestes.vAlign = VAlignType.center;
    celulasTestes.borders.all.lineStyle = LineStyle.thin;
    celulasTestes.fontName = 'Arial';
    celulasTestes.bold = true;
    celulasTestes.backColor = '#FFFFFF';

    //Texto das colunas
    final List column = [
      "Nome",
      "Data de Nascimento",
      "Sexo",
      "Cor",
      "Renda",
      "Data do Teste",
      "Avaliações",
      "Erros",
      "Omissões",
      "Acertos",
      "Quantidade de toques"
    ];

    final rows = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K"];
    for (int i = 0; i < column.length; i++) {
      sheet.getRangeByName("${rows[i]}1").setText(column[i]);
    }

    //Estilo informações
    Style celulasInfo = workbook.styles.add('style2');
    celulasInfo.hAlign = HAlignType.center;
    celulasInfo.vAlign = VAlignType.center;
    celulasInfo.borders.all.lineStyle = LineStyle.thin;
    celulasInfo.fontName = 'Arial';
    celulasInfo.bold = true;
    celulasInfo.backColor = '#FFFFFF';

    //Settando informações
    int linha = 2; //Variavel auxiliar
    sheet.getRangeByIndex(1, 2).autoFitColumns();
    sheet.getRangeByIndex(1, 6).autoFitColumns();
    sheet.getRangeByIndex(1, 7).autoFitColumns();
    sheet.getRangeByIndex(1, 8).autoFitColumns();
    sheet.getRangeByIndex(1, 9).autoFitColumns();
    sheet.getRangeByIndex(1, 10).autoFitColumns();
    sheet.getRangeByIndex(1, 11).autoFitColumns();
    for (int i = 0; i < widget.children.length; i++) {
      sheet.getRangeByIndex(linha, 1).autoFitColumns();
      sheet.getRangeByIndex(linha, 3).autoFitColumns();
      sheet.getRangeByIndex(linha, 4).autoFitColumns();
      sheet.getRangeByIndex(linha, 5).autoFitColumns();
      sheet.getRangeByName("A$linha:K$linha").cellStyle = celulasTestes;
      final Range name = sheet.getRangeByName('A$linha');
      final Range date = sheet.getRangeByIndex(linha, 2);
      final Range sex = sheet.getRangeByIndex(linha, 3);
      final Range cor = sheet.getRangeByIndex(linha, 4);
      // final Range dataTeste = sheet.getRangeByIndex(linha, 5);
      final Range renda = sheet.getRangeByIndex(linha, 5);
      name.setText(widget.children[i].completeName);
      date.setText(widget.children[i].date);
      sex.setText(widget.children[i].sex);
      cor.setText(widget.children[i].color);
      renda.setText(widget.children[i].income.toString());

      //Caso tenha testes, inserir no planilha
      if (widget.children[i].boolTests == 1) {
        setState(() {
          testes.clear();
        });
        int valor = await loadReviews(widget.children[i].id);
        for (int v = 0; v < valor; v++) {
          sheet.getRangeByName("A$linha:K$linha").cellStyle = celulasTestes;
          sheet
              .getRangeByIndex(linha, 1)
              .setText(widget.children[i].completeName);
          sheet.getRangeByIndex(linha, 2).setText(widget.children[i].date);
          sheet.getRangeByIndex(linha, 3).setText(widget.children[i].sex);
          sheet.getRangeByIndex(linha, 4).setText(widget.children[i].color);
          sheet
              .getRangeByIndex(linha, 5)
              .setText(widget.children[i].income.toString());
          sheet.getRangeByIndex(linha, 6).setText(testes[v].dataAvaliacao);
          sheet.getRangeByIndex(linha, 7).setText(testes[v].tipo);
          sheet.getRangeByIndex(linha, 8).setText(testes[v].erros.toString());
          sheet
              .getRangeByIndex(linha, 9)
              .setText(testes[v].omissoes.toString());
          sheet
              .getRangeByIndex(linha, 10)
              .setText(testes[v].acertos.toString());
          sheet
              .getRangeByIndex(linha, 11)
              .setText(testes[v].qtdeCliques.toString());
          if (v != (valor - 1)) {
            // sheet.getRangeByIndex(linha, 1, linha + 1, 1).merge();
            linha++;
          }
        }
      }
      sheet.autoFitRow(linha);
      sheet.autoFitColumn(i + 1);
      linha++;
    }

    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();
    if (kIsWeb) {
      Timer(const Duration(seconds: 1), () {
        AnchorElement(
            href:
                'data:application/octet-stream;charset=utf-16le;base64,${base64.encode(bytes)}')
          ..setAttribute('download', 'criancas_testes.xlsx')
          ..click();
      });
    } else {
      try {
        final String path = (await getApplicationSupportDirectory()).path;
        final String fileName = "$path/exportar.xlsx";
        final File file = File(fileName);
        await file.writeAsBytes(bytes, flush: true);
        OpenFile.open(fileName);
      } catch (error) {
        return;
      }
    }
  }

  //Obtendo os resultados do banco
  loadReviews(String id) async {
    int qtde = 0;
    FirebaseFirestore db = FirebaseFirestore.instance;
    final resultados = await db
        .collection("Avaliacoes")
        .doc(id)
        .collection("resultados")
        .get();
    for (int i = 0; i < resultados.docs.length; i++) {
      final dados = resultados.docs[i].data();

      _addTestes(Tests(
          resultados.docs[i].id,
          dados["data_avaliacao"],
          dados["erros"],
          dados["omissoes"],
          dados["acertos"],
          dados["qtde_cliques"],
          dados["tipo"]));
      qtde = qtde + 1;
    }
    return qtde;
  }

  //Adicionando os resultados em uma lista
  _addTestes(Tests test) {
    testes.add(test);
  }
}
