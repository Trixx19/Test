import 'dart:async';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:gonogo/controller/controller_children.dart';
import 'package:gonogo/models/sequencia.dart';
import '../models/utils/rotas-app.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class TelaAvaliar extends StatefulWidget {
  final String id;
  final int teste; // 0 for Visual, 1 for Audio <-- Comentário Original Preservado
  final int boolTeste;
  const TelaAvaliar(
      {super.key,
      required this.id,
      required this.teste,
      required this.boolTeste});

  @override
  State<TelaAvaliar> createState() => _TelaAvaliarState();
}

// adicionando WidgetsBindingObserver para usar os estados do sistema
class _TelaAvaliarState extends State<TelaAvaliar> with WidgetsBindingObserver {
  bool boolTeste = true;
  bool _carregar = false;
  bool mostrar = false;
  final FlutterTts flutterTts = FlutterTts();
  int i = 0;

  List<int> indices = [];
  bool _comecarLista = false;

  bool _isPaused = true;
  Timer? _visualTimer;
  bool _isDisposed = false;

  // NOVA FLAG: Para diferenciar pausa manual de automática
  bool _isManuallyPaused = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    WidgetsBinding.instance.addPostFrameCallback((_) {
       // Usa mounted (do State) aqui
       if (mounted) {
         final size = MediaQuery.of(context).size;
         // MODIFICADO: A reprodução inicial foi movida para dentro de _mostrarPopUpInicial
         _mostrarPopUpInicial(size);
       }
    });
    // REMOVIDO: _reproduzir("Treino, ${listaTexto[widget.teste]}"); // Movido para _mostrarPopUpInicial
  }

  @override
  void dispose() {
    _isDisposed = true; // Marca como disposed
    WidgetsBinding.instance.removeObserver(this);
    _visualTimer?.cancel();
    flutterTts.stop(); // Garante parada do TTS
    // NOVA MODIFICAÇÃO: Limpa handlers do TTS ao sair usando funções vazias para corrigir 'argument_type_not_assignable'
    flutterTts.setCompletionHandler(() {}); // Correção: Passa função vazia
    flutterTts.setErrorHandler((_) {}); // Correção: Passa função vazia com argumento ignorado
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (_isDisposed) return; // Evita erro se o estado mudar após dispose

    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive ||
        state == AppLifecycleState.detached) {
      // NOVA MODIFICAÇÃO: Chamar _pauseTest SEMPRE que o app ficar inativo.
      // Isso para o áudio introdutório (Bug 1).
      debugPrint("App Pausado pelo Sistema: $state"); // print de debug para ajudar em testes
      _pauseTest(manual: false); 

    }
     // NOVA MODIFICAÇÃO: Só resume automaticamente se NÃO estiver manualmente pausado
     else if (state == AppLifecycleState.resumed && !_isManuallyPaused) {
       debugPrint("App Resumed (e não pausado manualmente)"); // print de debug para ajudar em testes
       // NOVA MODIFICAÇÃO: Não retomar automaticamente se o teste
       // já estiver no estado pausado (ex: pop-up inicial)
       if(!_isPaused) {
          _resumeTest();
       }
     } else if (state == AppLifecycleState.resumed && _isManuallyPaused) {
         debugPrint("App Resumed, mas permanece pausado manualmente"); // print de debug para ajudar em testes
     }
  }

  _selecao() { //Função para retornar cores
    late int numero;
    List<Color> cores = const [Color(0xFF808080), Color(0xFF191919)];
    if (i % 2 == 0) {
      numero = 0;
    } else {
      numero = 1;
    }
    return cores[numero];
  }

  void _pauseTest({bool manual = true}) {
    if (_isDisposed) return;

    // NOVA MODIFICAÇÃO: Sempre parar o TTS e cancelar timers ANTES da checagem.
    // Isso resolve o Bug 1 (áudio tocando em segundo plano).
    debugPrint("Chamada para _pauseTest (Manual: $manual). Parando TTS e Timers."); // print de debug para ajudar em testes
    _visualTimer?.cancel();
    _visualTimer = null;
    flutterTts.stop(); // Para áudios (de instrução ou teste)

    // Se já estava pausado (ex: no pop-up inicial),
    // apenas atualiza a flag manual (se necessário) e sai.
    if (_isPaused) {
       debugPrint("Tentativa de Pausar, mas já estava pausado."); // print de debug para ajudar em testes
       if (manual && !_isManuallyPaused) {
         _isManuallyPaused = true;
         debugPrint("Marcado como pausado manualmente (estado existente)."); // print de debug para ajudar em testes
         if (mounted) setState(() {});
       }
       return;
    }

    // Se não estava pausado (teste estava rodando), pausa agora.
    debugPrint("Pausando Teste (estava rodando)."); // print de debug para ajudar em testes
    if(mounted){ // Adiciona verificação mounted antes de setState
      setState(() {
        _isPaused = true;
        if(manual) _isManuallyPaused = true;
      });
    } else {
       _isPaused = true; // Define diretamente se não estiver montado
       if(manual) _isManuallyPaused = true;
    }
  }

 void _resumeTest() {
    // Só continua se estava pausado
    if (_isDisposed || !_isPaused) {
       debugPrint("Tentativa de Continuar, mas não estava pausado ou já foi disposed."); // print de debug para ajudar em testes
       return;
    }
    debugPrint("Continuando Teste"); // print de debug para ajudar em testes

    // Usa mounted aqui também por segurança
    if(mounted){
      setState(() {
        _isPaused = false;
        // NOVA MODIFICAÇÃO: Ao resumir, desmarca pausa manual
        _isManuallyPaused = false;
      });
    } else {
      _isPaused = false; // Define diretamente
      _isManuallyPaused = false;
    }

    // NOVA MODIFICAÇÃO: Remove Future.delayed, usa addPostFrameCallback para iniciar a lógica
    WidgetsBinding.instance.addPostFrameCallback((_) {
        // NOVA MODIFICAÇÃO: Verifica pausa/dispose DE NOVO aqui dentro
        if (_isPaused || _isDisposed) {
          debugPrint("_resumeTest (PostFrameCallback): Pausado ou Disposed antes de iniciar lógica."); // print de debug para ajudar em testes
          return;
        }

        debugPrint("Iniciando lógica do teste após resume"); // print de debug para ajudar em testes
        if (boolTeste) {
          _testeAvaliacao(); // Continua o treino
        } else {
          _teste(); // Continua o teste real
        }
     });

  }

  _testeAvaliacao() async {
    // NOVA MODIFICAÇÃO: Verificação inicial mais robusta
    if (_isPaused || _isDisposed) {
      debugPrint("_testeAvaliacao: Pausado ou Disposed no início. Saindo."); // print de debug para ajudar em testes
      return;
    }
    debugPrint("Executando _testeAvaliacao - Índice: $i"); // print de debug para ajudar em testes


    if (widget.teste == 0) { // TESTE VISUAL
      if (i < 3) {
        // NOVA MODIFICAÇÃO: Garante cancelar timer anterior
        _visualTimer?.cancel();
        _visualTimer = Timer(const Duration(seconds: 1), () {
          // NOVA MODIFICAÇÃO: Verificação robusta dentro do timer
          if (_isPaused || _isDisposed) {
             debugPrint("_testeAvaliacao (Timer Visual): Pausado ou Disposed. Saindo."); // print de debug para ajudar em testes
             return;
          }
          if (mounted) {
            setState(() { i++; });
             debugPrint("_testeAvaliacao (Timer Visual): Avançou para índice $i"); // print de debug para ajudar em testes
          } else { return; } // Sai se não estiver montado
          _testeAvaliacao(); // Chama próximo
        });
      } else { // Fim do treino visual
         // NOVA MODIFICAÇÃO: Garante cancelar timer anterior
         _visualTimer?.cancel();
         final currentContext = context;
         final size = MediaQuery.of(currentContext).size;
         _visualTimer = Timer(
           const Duration(seconds: 1),
           () {
             // NOVA MODIFICAÇÃO: Verificação robusta dentro do timer
            if (_isPaused || _isDisposed) {
              debugPrint("_testeAvaliacao (Timer Final Treino Visual): Pausado ou Disposed. Saindo."); // print de debug para ajudar em testes
              return;
            }
             if (currentContext.mounted) {
               _mostrarPopUpPreparese(size); // Passa o size capturado
             }
              debugPrint("_testeAvaliacao (Timer Final Treino Visual): Mostrou PopUp Preparese"); // print de debug para ajudar em testes
             // REMOVIDO: _reproduzir("Prepare-se, agora é pra valer!"); // Movido para _mostrarPopUpPreparese
           },
         );
       }
    }
    else if (widget.teste == 1) { // TESTE DE AUDIO
       if (i < 4) {
          await _reproduzirTeste(sequenciaTeste[i].toString());
        } else { // Fim do treino áudio
          final currentContext = context;
          final size = MediaQuery.of(currentContext).size;
          // NOVA MODIFICAÇÃO: Timer para delay ANTES do PopUp
          Timer(const Duration(milliseconds: 500), () {
              // NOVA MODIFICAÇÃO: Verificação robusta dentro do timer
             if (_isPaused || _isDisposed) {
                debugPrint("_testeAvaliacao (Timer Final Treino Audio): Pausado ou Disposed. Saindo."); // print de debug para ajudar em testes
                return;
             }
              if (currentContext.mounted) {
                _mostrarPopUpPreparese(size); // Passa o size capturado
              }
              debugPrint("_testeAvaliacao (Timer Final Treino Audio): Mostrou PopUp Preparese"); // print de debug para ajudar em testes
              // REMOVIDO: _reproduzir("Prepare-se, agora é pra valer!"); // Movido para _mostrarPopUpPreparese
            });
        }
    }
  }

  _teste() async {
     // NOVA MODIFICAÇÃO: Verificação inicial mais robusta
    if (_isPaused || _isDisposed) {
      debugPrint("_teste: Pausado ou Disposed no início. Saindo."); // print de debug para ajudar em testes
      return;
    }
     debugPrint("Executando _teste - Índice: $i"); // print de debug para ajudar em testes

    if (widget.teste == 0) { // PARTE LÓGICA VISUAL
      if (i < 59) {
         // NOVA MODIFICAÇÃO: Garante cancelar timer anterior
         _visualTimer?.cancel();
        _visualTimer = Timer(const Duration(seconds: 1), () {
            // NOVA MODIFICAÇÃO: Verificação robusta dentro do timer
           if (_isPaused || _isDisposed) {
              debugPrint("_teste (Timer Visual): Pausado ou Disposed. Saindo."); // print de debug para ajudar em testes
              return;
           }
           if (mounted) {
             setState(() { i++; });
             debugPrint("_teste (Timer Visual): Avançou para índice $i"); // print de debug para ajudar em testes
           } else { return; } // Sai se não estiver montado
          _teste(); // Chama próximo
        });
      } else { // Fim do teste visual
        // NOVA MODIFICAÇÃO: Garante cancelar timer anterior
        _visualTimer?.cancel();
        final currentContext = context;
        final size = MediaQuery.of(currentContext).size;
        _visualTimer = Timer(const Duration(seconds: 1, milliseconds: 500), () async {
           // NOVA MODIFICAÇÃO: Verificação robusta dentro do timer
          if (_isPaused || _isDisposed) {
             debugPrint("_teste (Timer Final Visual): Pausado ou Disposed. Saindo."); // print de debug para ajudar em testes
             return;
          }
          debugPrint("_teste (Timer Final Visual): Salvando resultados..."); // print de debug para ajudar em testes
          await _salvarResultados("Visual Motor", currentContext, size); // Passa context e size capturados
        });
      }
    }
    else if (widget.teste == 1) { // PARTE LÓGICA AUDIO
       if (!_comecarLista) {
         if(mounted) { // Verifica mounted antes de setState
           setState(() { _comecarLista = true; });
           debugPrint("_teste (Audio): Iniciando lista"); // print de debug para ajudar em testes
         } else { return; } // Sai se não estiver montado
       }

        if (i < sequenciaLista.length) {
          await _reproduzirTeste(sequenciaLista[i].toString());
        } else { // Fim do teste áudio
          final currentContext = context;
          final size = MediaQuery.of(currentContext).size;
          Timer(const Duration(seconds: 1), () async {
              // NOVA MODIFICAÇÃO: Verificação robusta dentro do timer
             if (_isPaused || _isDisposed) {
                debugPrint("_teste (Timer Final Audio): Pausado ou Disposed. Saindo."); // print de debug para ajudar em testes
                return;
             }
             debugPrint("_teste (Timer Final Audio): Salvando resultados..."); // print de debug para ajudar em testes
             await _salvarResultados("Áudio Motor", currentContext, size); // Passa context e size capturados
           });
        }
    }
  }

  // Modificado para receber context e size
  Future<void> _salvarResultados(
      String tipoTeste, BuildContext capturedContext, Size size) async {
    try {
      if (!capturedContext.mounted || _isDisposed) return;
      // CORREÇÃO: Usar capturedContext.mounted aqui (erro use_build_context_synchronously)
      // (O erro 481 está aqui no código original)
      if (capturedContext.mounted) {
        // Ainda usamos setState do State, então a verificação 'mounted' é correta aqui
        if (mounted) {
           setState(() {
             _carregar = true;
           });
        } else { return; } // Sai se o State não estiver montado
      } else {
        return; // Sai se o BuildContext capturado não estiver montado
      }
      
      // Passa context e size capturados
      _popUpFinal("Salvando...", capturedContext, size);

      await ControllerChildren()
          .salvarTeste(widget.id, indices, tipoTeste, widget.boolTeste);

      if (!capturedContext.mounted || _isDisposed) return; // Verifica de novo ANTES de mexer no pop-up

      // NOVA MODIFICAÇÃO: Fecha pop-up ANTES de mostrar o próximo, com delay
      Navigator.of(capturedContext).pop(); // Fecha pop-up de carregamento
      await Future.delayed(Duration(milliseconds: 100)); // Pequeno delay
      if (!capturedContext.mounted || _isDisposed) return; // Verifica mais uma vez

       // Passa context e size capturados
      _popUpFinal("Avaliação concluída com sucesso", capturedContext, size);
      // Ainda usamos setState do State, então a verificação 'mounted' é correta aqui
      if (mounted) {
        setState(() {
          _carregar = false;
        });
      }
    } catch (error) {
      if (!capturedContext.mounted || _isDisposed) return;

      // NOVA MODIFICAÇÃO: Tenta fechar pop-up "Salvando" mesmo com erro
      try {
        Navigator.of(capturedContext).pop(); // Fecha pop-up de carregamento
        await Future.delayed(Duration(milliseconds: 100)); // Delay
      } catch (_) { /* Ignora erro se o pop-up já foi fechado */ }
      if (!capturedContext.mounted || _isDisposed) return; // Verifica de novo

       // Passa context e size capturados
      _popUpFinal(error.toString(), capturedContext, size);
       // Ainda usamos setState do State, então a verificação 'mounted' é correta aqui
      if (mounted) {
        setState(() {
          _carregar = false;
        });
      }
    }
  }

  _reproduzir(String texto) async { //Transforma texto em audio
    // NOVA MODIFICAÇÃO: Garante parada antes de falar
    await flutterTts.stop();
    await flutterTts.setLanguage("pt-BR");
    await flutterTts.setPitch(1);
    await flutterTts.setSpeechRate(0.5);
    debugPrint("Reproduzindo Info: $texto"); // print de debug para ajudar em testes
    await flutterTts.speak(texto);
  }

  _reproduzirTeste(String textoTeste) async { //Transforma texto em audio
    // NOVA MODIFICAÇÃO: Verificação robusta inicial
    if (_isPaused || _isDisposed) {
      debugPrint("_reproduzirTeste: Pausado ou Disposed no início. Saindo."); // print de debug para ajudar em testes
      return;
    }
    debugPrint("Preparando para reproduzir teste: $textoTeste (Índice $i)"); // print de debug para ajudar em testes

    // REMOVIDO: await flutterTts.stop(); // Removido para evitar interromper falas introdutórias desnecessariamente

    await flutterTts.setLanguage("pt-BR");
    await flutterTts.setPitch(1);
    if (!kIsWeb) {
      await flutterTts.setSpeechRate(0.5);
    } else {
       // Ajustado para web (treino e teste usam a mesma velocidade aqui)
      await flutterTts.setSpeechRate(0.72);
    }

    // Configura o completion handler ANTES de falar
    flutterTts.setCompletionHandler(() {
       // NOVA MODIFICAÇÃO: Verificação robusta dentro do handler
      if (_isPaused || _isDisposed) {
         debugPrint("_reproduzirTeste (Completion Handler): Pausado ou Disposed. Saindo."); // print de debug para ajudar em testes
         return; // NÃO continua se pausado
      }
      debugPrint("_reproduzirTeste (Completion Handler): Áudio $textoTeste concluído (Índice $i). Agendando próximo."); // print de debug para ajudar em testes

      Timer(const Duration(milliseconds: 435), () {
          // NOVA MODIFICAÇÃO: Verificação robusta dentro do timer do handler
        if (_isPaused || _isDisposed) {
           debugPrint("_reproduzirTeste (Timer do Handler): Pausado ou Disposed. Saindo."); // print de debug para ajudar em testes
           return;
        }

        if (mounted) { // Garante que o widget ainda existe
          setState(() { i++; }); // Avança o índice
           debugPrint("_reproduzirTeste (Timer do Handler): Avançou para índice $i"); // print de debug para ajudar em testes
        } else {
           return; // Sai se não estiver montado
        }

        // Chama a função apropriada para o próximo passo
        if (boolTeste) {
          _testeAvaliacao(); // Próximo passo do treino
        } else {
          _teste(); // Próximo passo do teste real
        }
      });
    });

     // NOVA MODIFICAÇÃO: Ajuste no Error Handler para não pausar em 'interrupted'
    flutterTts.setErrorHandler((msg) {
        debugPrint("TTS Error: $msg"); // print de debug para ajudar em testes
        // Só pausa se o erro NÃO for 'interrupted' (que pode ser intencional ou causado por chamadas stop)
         if (msg != 'interrupted' && !_isPaused && !_isDisposed) {
            _pauseTest(manual: false); // Pausa automaticamente em caso de erro TTS não esperado
            debugPrint("Teste pausado devido a erro não esperado no TTS ($msg)."); // print de debug para ajudar em testes
         } else if (msg == 'interrupted') {
             debugPrint("TTS Interrompido (ignorado para pausa automática)."); // print de debug para ajudar em testes
         }
    });

    // Inicia a fala
     debugPrint("Iniciando reprodução teste: $textoTeste (Índice $i)"); // print de debug para ajudar em testes
    await flutterTts.speak(textoTeste);
  }

  Future<void> _pararTesteCompleto() async {
    debugPrint("Parando Teste Completo (cancelando timer e parando TTS)"); // print de debug para ajudar em testes
    _visualTimer?.cancel();
    _visualTimer = null;
    await flutterTts.stop(); // Garante que o TTS pare
    // NOVA MODIFICAÇÃO: Limpa handlers para evitar chamadas tardias usando funções vazias
    flutterTts.setCompletionHandler(() {}); // Correção: Passa função vazia
    flutterTts.setErrorHandler((_) {}); // Correção: Passa função vazia com argumento ignorado
  }

   // Modificado para receber size e chamar _reproduzir
  void _mostrarPopUpInicial(Size size) {
    // NOVA MODIFICAÇÃO: Reproduz o áudio ANTES de mostrar o pop-up
     _reproduzir("Treino, ${listaTexto[widget.teste]}");

    // CORREÇÃO: Chamando PopUpAlert (P maiúsculo) como no seu original
    PopUpAlert(
      context: context,
      size: size, // Passa o size
      texto: listaTexto[widget.teste],
      textoBotao: 'COMEÇAR TREINO',
      onPressed: () async { // NOVA MODIFICAÇÃO: Adicionado async
        // NOVA MODIFICAÇÃO: Para o áudio introdutório ANTES de continuar
        await flutterTts.stop();
        // NOVA MODIFICAÇÃO: Adiciona pequeno delay após parar
        await Future.delayed(Duration(milliseconds: 50));
        if (mounted) Navigator.pop(context); // Fecha o pop-up
        if (mounted) { // setState usa mounted do State
           setState(() {
             mostrar = true; // Mostra número (visual)
           });
        }
        _resumeTest(); // Inicia o treino
      },
    );
  }

  // Modificado para receber size
   void _mostrarPopUpPreparese(Size size) {
     // Pausa ANTES de mostrar o pop-up
     _pauseTest(manual: false);
     // NOVA MODIFICAÇÃO: Reproduz "Prepare-se..." aqui, QUANDO o pop-up aparece
     _reproduzir("Prepare-se, agora é pra valer!");


     // CORREÇÃO: Chamando PopUpAlert (P maiúsculo) como no seu original
     PopUpAlert(
      context: context,
      size: size, // Passa o size
      texto: "Prepare-se, agora é pra valer",
      textoBotao: 'COMEÇAR TESTE',
      onPressed: () async { // NOVA MODIFICAÇÃO: Adicionado async
        // REMOVIDO: _reproduzir("Prepare-se, agora é pra valer!");
        // NOVA MODIFICAÇÃO: Para o áudio "Prepare-se..." ANTES de continuar
        await flutterTts.stop();
        // NOVA MODIFICAÇÃO: Adiciona pequeno delay após parar
        await Future.delayed(Duration(milliseconds: 50));

        if (mounted) Navigator.pop(context); // Fecha o pop-up
        if (mounted) { // setState usa mounted do State
           setState(() {
             i = 0; // Reseta índice
             indices.clear(); // Limpa cliques anteriores
             mostrar = true;
             boolTeste = false; // Muda para modo teste real
           });
        }
         _resumeTest(); // Inicia o teste real
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    // 'size' definido aqui é acessível em todo o build method
    final size = MediaQuery.of(context).size;
    final alturaTela = size.height -
        (MediaQuery.of(context).padding.top +
            MediaQuery.of(context).padding.bottom);
    final padding = MediaQuery.of(context).padding;

    return PopScope( // trocado pelo pop scope e adicionando vários if(context.mounted) em partes assíncronas, chamadas depois de usar time ou await
      canPop: false,
      onPopInvokedWithResult: (bool didPop, dynamic result) async {
        if (didPop) return;
        _pauseTest(manual: false); // Pausa primeiro
        await _pararTesteCompleto(); // Garante que tudo pare
        if (context.mounted) {
          // NOVA MODIFICAÇÃO: Usa replace para não empilhar telas
          Navigator.pushReplacementNamed(context, RotasApp.menu);
        }
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          leading: Center(
              child: Padding(
            padding: EdgeInsets.only(left: size.width * .01),
            child: SizedBox(
              height: size.height * .07,
              child: FloatingActionButton(
                child: const Icon(
                  Icons.arrow_back_ios_new_outlined,
                ),
                onPressed: () async {
                  _pauseTest(manual: false); // Pausa primeiro
                  await _pararTesteCompleto(); // Garante que tudo pare
                  if (context.mounted) {
                     // NOVA MODIFICAÇÃO: Usa replace para não empilhar telas
                     Navigator.pushReplacementNamed(context, RotasApp.menu);
                  }
                },
              ),
            ),
          )),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: size.width * .02),
              child: IconButton(
                 icon: Icon(
                   // NOVA MODIFICAÇÃO: Condição para ícone - mostra Play se pausado (manual ou auto), Pause se rodando
                  _isPaused ? Icons.play_circle_fill : Icons.pause_circle_filled,
                  size: size.height * .06,
                  color: const Color(0xff48CC48),
                ),
                onPressed: () {
                  if (_isPaused) {
                    _resumeTest(); // Tenta resumir
                  } else {
                    _pauseTest(manual: true); // Pausa manualmente
                  }
                },
              ),
            ),
          ],
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
                    Container(
                      height: size.height * .20, // Altura estimada do texto
                      alignment: Alignment.center,
                      child: (widget.teste == 0 && mostrar) // TEXTO E AÚDIO (Só mostra se for visual E `mostrar` for true)
                          ? AutoSizeText(
                               // Mostra o número correto (treino ou real)
                              (boolTeste
                                  ? (i < sequenciaTeste.length ? sequenciaTeste[i].toString() : "") // Evita erro de índice no treino
                                  : (i < sequenciaLista.length ? sequenciaLista[i].toString() : "")), // Evita erro de índice no teste
                              maxLines: 1,
                              minFontSize: 10,
                              style: TextStyle(
                                fontSize: 120,
                                fontWeight: FontWeight.bold,
                                color: _selecao(),
                              ),
                            )
                          : null, // Não mostra nada se for áudio ou se `mostrar` for false
                    ),
                    // BOTÃO DE CLIQUE
                    Padding(
                      padding: EdgeInsets.only(
                        top: size.height * .10,
                        bottom: size.height * .05,
                      ),
                      child: SizedBox(
                        height: size.height * .40,
                        width: size.width * .80,
                        child: ElevatedButton(
                          onPressed: _isPaused ? null : () { // Desabilita botão se pausado
                            // Só registra clique se o teste real tiver começado
                            if (!boolTeste) {
                              indices.add(i);
                               // print de debug para ajudar em testes
                               debugPrint("Clique registrado no índice: $i (${indices.length} cliques total)");
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 10,
                            backgroundColor: Colors.white,
                            shadowColor: Colors.black,
                             disabledBackgroundColor: Colors.grey[300] // Cor quando desabilitado
                          ),
                          child: Center(
                            child: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: (widget.teste == 0) // Teste Visual
                                      ? const AssetImage(
                                          'assets/images/click.png')
                                      : const AssetImage( // Teste Áudio
                                          'assets/images/Fala.png'),
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
      ),
    );
  }

  final listaTexto = [
    "NÃO CLIQUE QUANDO APARECER O NÚMERO 6",
    "NÃO CLIQUE QUANDO OUVIR O NÚMERO 6",
  ];

  // Pop-up genérico reutilizado
  // ignore: non_constant_identifier_names
  dynamic PopUpAlert({ // CORREÇÃO: Nome mantido como PopUpAlert (P maiúsculo)
    required BuildContext context,
    required Size size, // Recebe o size
    required String texto,
    required String textoBotao,
    required VoidCallback onPressed, // Mantido como VoidCallback
  }) {
     if (!context.mounted) return; // Segurança extra

    // exibir o alerta
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        // REMOVIDO: StatefulBuilder
        return AlertDialog( // Construído diretamente
               content: SizedBox(
                 height: size.height * .40,
                 width: size.width * .70,
                 child: Stack(
                   children: [
                     Align(
                       alignment: Alignment.center,
                       child: SizedBox(
                         height: size.height * .15,
                         child: Center(
                           child: AutoSizeText(
                             texto,
                             maxLines: 3,
                             minFontSize: 10,
                             textAlign: TextAlign.center,
                             style: const TextStyle(
                               fontSize: 30,
                               color: Colors.white,
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
                         width: size.width * .80,
                         // O botão agora é simples e sempre habilitado
                         child: ElevatedButton(
                           onPressed: onPressed, // CORREÇÃO: Chama o onPressed (que é async) diretamente
                           style: ElevatedButton.styleFrom(
                             backgroundColor: const Color(0xff48CC48),
                             shape: RoundedRectangleBorder(
                               borderRadius: BorderRadius.circular(30),
                             ),
                           ),
                           child: AutoSizeText(
                             textoBotao, // Usa o texto do botão
                             maxLines: 1,
                             minFontSize: 10,
                             style: const TextStyle(
                               fontWeight: FontWeight.bold,
                               fontFamily: 'Raleway',
                               fontSize: 25,
                               color: Colors.white,
                             ),
                           ),
                         ),
                       ),
                     )
                   ],
                 ),
               ),
               backgroundColor: const Color(0xff1E70AD),
               shape: const RoundedRectangleBorder(
                 borderRadius: BorderRadius.all(
                   Radius.circular(20.0),
                 ),
               ),
             );
      },
    );
  }

  // Pop-up final (Sucesso ou Erro)
  // Modificado para receber context e size
  dynamic _popUpFinal(String msg, BuildContext capturedContext, Size size) {
     if (!capturedContext.mounted) return; // Segurança extra

    const valorSucesso = "Avaliação concluída com sucesso";
    bool sucesso = msg == valorSucesso;

     // Usa showDialog com o context CAPTURADO da tela principal
    return showDialog(
      context: capturedContext,
      barrierDismissible: false,
      builder: (dialogContext) => AlertDialog( // Usa um novo context (dialogContext) para o builder interno
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(30),
          ),
        ),
        backgroundColor: Colors.white,
        content: Builder(
          builder: (builderContext) { // Pode usar dialogContext ou builderContext aqui
            return SizedBox(
              // Usa o size passado
              height: size.height * .35,
              width: size.width * .70,
              child: _carregar // Mostra indicador se _carregar for true
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
                            // Usa o size passado
                            height: size.height * .15,
                            child: Center(
                              child: AutoSizeText(
                                msg,
                                maxLines: 3, // Aumentado para acomodar erros
                                minFontSize: 10,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 30,
                                  color: sucesso ? const Color(0xff1E70AD) : Colors.red, // Cor diferente para erro
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
                            // Usa o size passado
                            height: size.height * .08,
                            width: size.width * .60,
                            child: Center(
                              child: SizedBox(
                                      height: size.height,
                                      // Usa o size passado
                                      width: size.width * .3,
                                      child: ElevatedButton(
                                        onPressed: () {
                                           // Fecha este diálogo usando o contexto dele (dialogContext)
                                           if (dialogContext.mounted) {
                                              Navigator.of(dialogContext).pop();
                                           }
                                           // Navega na tela principal usando o contexto capturado (capturedContext)
                                           if (capturedContext.mounted) {
                                              // NOVA MODIFICAÇÃO: Usa pushReplacementNamed para evitar empilhar telas
                                              Navigator.pushReplacementNamed(capturedContext, RotasApp.criancasCadastradas);
                                            }
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: sucesso ? const Color(0xff48CC48) : Colors.grey, // Cor diferente para erro
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                        ),
                                        child: AutoSizeText(
                                          sucesso ? 'FINALIZAR' : 'FECHAR', // Texto diferente
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
                                    )

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

} // Fim da classe _TelaAvaliarState
