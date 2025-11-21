import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_pt.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('pt')
  ];

  /// No description provided for @button_login.
  ///
  /// In pt, this message translates to:
  /// **'ENTRAR'**
  String get button_login;

  /// No description provided for @button_cadastro.
  ///
  /// In pt, this message translates to:
  /// **'CADASTRO'**
  String get button_cadastro;

  /// No description provided for @button_fechar.
  ///
  /// In pt, this message translates to:
  /// **'FECHAR'**
  String get button_fechar;

  /// No description provided for @button_finalizar.
  ///
  /// In pt, this message translates to:
  /// **'FINALIZAR'**
  String get button_finalizar;

  /// No description provided for @button_continuar.
  ///
  /// In pt, this message translates to:
  /// **'CONTINUAR'**
  String get button_continuar;

  /// No description provided for @button_salvar.
  ///
  /// In pt, this message translates to:
  /// **'SALVAR'**
  String get button_salvar;

  /// No description provided for @button_seguinte.
  ///
  /// In pt, this message translates to:
  /// **'SEGUINTE'**
  String get button_seguinte;

  /// No description provided for @button_sim.
  ///
  /// In pt, this message translates to:
  /// **'SIM'**
  String get button_sim;

  /// No description provided for @button_nao.
  ///
  /// In pt, this message translates to:
  /// **'NÃO'**
  String get button_nao;

  /// No description provided for @button_add_crianca.
  ///
  /// In pt, this message translates to:
  /// **'ADD. CRIANÇA'**
  String get button_add_crianca;

  /// No description provided for @button_avaliar.
  ///
  /// In pt, this message translates to:
  /// **'AVALIAR'**
  String get button_avaliar;

  /// No description provided for @button_resultados.
  ///
  /// In pt, this message translates to:
  /// **'RESULTADOS'**
  String get button_resultados;

  /// No description provided for @button_sair.
  ///
  /// In pt, this message translates to:
  /// **'SAIR'**
  String get button_sair;

  /// No description provided for @button_cancelar.
  ///
  /// In pt, this message translates to:
  /// **'CANCELAR'**
  String get button_cancelar;

  /// No description provided for @button_avaliar_novamente.
  ///
  /// In pt, this message translates to:
  /// **'AVALIAR NOV.'**
  String get button_avaliar_novamente;

  /// No description provided for @button_visual.
  ///
  /// In pt, this message translates to:
  /// **'Visual'**
  String get button_visual;

  /// No description provided for @button_audio.
  ///
  /// In pt, this message translates to:
  /// **'Áudio'**
  String get button_audio;

  /// No description provided for @button_comecar.
  ///
  /// In pt, this message translates to:
  /// **'COMEÇAR'**
  String get button_comecar;

  /// No description provided for @button_confirmar.
  ///
  /// In pt, this message translates to:
  /// **'CONFIRMAR'**
  String get button_confirmar;

  /// No description provided for @form_obrigatorio.
  ///
  /// In pt, this message translates to:
  /// **'campo obrigatório'**
  String get form_obrigatorio;

  /// No description provided for @form_senha_incorreta.
  ///
  /// In pt, this message translates to:
  /// **'senha incorreta'**
  String get form_senha_incorreta;

  /// No description provided for @form_senha_naoconferem.
  ///
  /// In pt, this message translates to:
  /// **'senhas não conferem'**
  String get form_senha_naoconferem;

  /// No description provided for @form_email_naoconferem.
  ///
  /// In pt, this message translates to:
  /// **'e-mails não conferem'**
  String get form_email_naoconferem;

  /// No description provided for @form_email_naoencontrado.
  ///
  /// In pt, this message translates to:
  /// **'e-mail não encontrado'**
  String get form_email_naoencontrado;

  /// No description provided for @form_email_caractere.
  ///
  /// In pt, this message translates to:
  /// **'preencha com \'@\''**
  String get form_email_caractere;

  /// No description provided for @form_names_carecteres.
  ///
  /// In pt, this message translates to:
  /// **'este campo deve ter pelo menos 3 caracteres'**
  String get form_names_carecteres;

  /// No description provided for @form_senha_caracteres.
  ///
  /// In pt, this message translates to:
  /// **'a senha deve ter no mínimo 6 caracteres'**
  String get form_senha_caracteres;

  /// No description provided for @global_nome_completo.
  ///
  /// In pt, this message translates to:
  /// **'Nome completo'**
  String get global_nome_completo;

  /// No description provided for @global_email.
  ///
  /// In pt, this message translates to:
  /// **'E-mail'**
  String get global_email;

  /// No description provided for @global_confirmaremail.
  ///
  /// In pt, this message translates to:
  /// **'Confirmar email'**
  String get global_confirmaremail;

  /// No description provided for @global_senha.
  ///
  /// In pt, this message translates to:
  /// **'Senha'**
  String get global_senha;

  /// No description provided for @global_novasenha.
  ///
  /// In pt, this message translates to:
  /// **'Nova senha'**
  String get global_novasenha;

  /// No description provided for @global_confirmarsenha.
  ///
  /// In pt, this message translates to:
  /// **'Confirmar senha'**
  String get global_confirmarsenha;

  /// No description provided for @global_instituicao.
  ///
  /// In pt, this message translates to:
  /// **'Instituição'**
  String get global_instituicao;

  /// No description provided for @global_pesquisar.
  ///
  /// In pt, this message translates to:
  /// **'Pesquisar criança...'**
  String get global_pesquisar;

  /// No description provided for @global_carregando.
  ///
  /// In pt, this message translates to:
  /// **'Carregando informações...'**
  String get global_carregando;

  /// No description provided for @global_erro_dados1.
  ///
  /// In pt, this message translates to:
  /// **'Erro ao carregar dados'**
  String get global_erro_dados1;

  /// No description provided for @global_erro_dados2.
  ///
  /// In pt, this message translates to:
  /// **'Erro ao tentar carregar os dados!'**
  String get global_erro_dados2;

  /// No description provided for @global_data_teste.
  ///
  /// In pt, this message translates to:
  /// **'Data do Teste'**
  String get global_data_teste;

  /// No description provided for @global_avaliacoes.
  ///
  /// In pt, this message translates to:
  /// **'Avaliações'**
  String get global_avaliacoes;

  /// No description provided for @global_erros.
  ///
  /// In pt, this message translates to:
  /// **'Erros'**
  String get global_erros;

  /// No description provided for @global_omissoes.
  ///
  /// In pt, this message translates to:
  /// **'Omissões'**
  String get global_omissoes;

  /// No description provided for @global_acertos.
  ///
  /// In pt, this message translates to:
  /// **'Acertos'**
  String get global_acertos;

  /// No description provided for @global_quant_toques.
  ///
  /// In pt, this message translates to:
  /// **'Quantidade de toques'**
  String get global_quant_toques;

  /// No description provided for @validator_nome_minimo.
  ///
  /// In pt, this message translates to:
  /// **'O nome deve ter mais de 2 caracteres'**
  String get validator_nome_minimo;

  /// No description provided for @validator_nome_invalido.
  ///
  /// In pt, this message translates to:
  /// **'Nome inválido'**
  String get validator_nome_invalido;

  /// No description provided for @validator_data_invalida.
  ///
  /// In pt, this message translates to:
  /// **'Data inválida'**
  String get validator_data_invalida;

  /// No description provided for @exceptions_email_invalido.
  ///
  /// In pt, this message translates to:
  /// **'Este e-mail é inválido'**
  String get exceptions_email_invalido;

  /// No description provided for @exceptions_email_naoencontrado.
  ///
  /// In pt, this message translates to:
  /// **'E-mail não encontrado'**
  String get exceptions_email_naoencontrado;

  /// No description provided for @exceptions_erro_login.
  ///
  /// In pt, this message translates to:
  /// **'Ocorreu um erro no processo de login'**
  String get exceptions_erro_login;

  /// No description provided for @exceptions_erro_recsenha.
  ///
  /// In pt, this message translates to:
  /// **'Ocorreu um erro no processo de recuperação de senha'**
  String get exceptions_erro_recsenha;

  /// No description provided for @exceptions_email_cadastrado.
  ///
  /// In pt, this message translates to:
  /// **'E-mail já cadastrado'**
  String get exceptions_email_cadastrado;

  /// No description provided for @exceptions_pedidos.
  ///
  /// In pt, this message translates to:
  /// **'Muitos pedidos.\nTente mais tarde'**
  String get exceptions_pedidos;

  /// No description provided for @exceptions_operacao_negada.
  ///
  /// In pt, this message translates to:
  /// **'Operação não permitida'**
  String get exceptions_operacao_negada;

  /// No description provided for @exceptions_erro_processo.
  ///
  /// In pt, this message translates to:
  /// **'Ocorreu um erro neste processo.\n Tente novamente'**
  String get exceptions_erro_processo;

  /// No description provided for @exceptions_senha_incorreta.
  ///
  /// In pt, this message translates to:
  /// **'A senha está incorreta'**
  String get exceptions_senha_incorreta;

  /// No description provided for @exceptions_conta_desabilitada.
  ///
  /// In pt, this message translates to:
  /// **'A conta do usuário foi desabilitada por um administrador'**
  String get exceptions_conta_desabilitada;

  /// No description provided for @exceptions_erro_servidor.
  ///
  /// In pt, this message translates to:
  /// **'Erro no servidor, tente novamente mais tarde'**
  String get exceptions_erro_servidor;

  /// No description provided for @exceptions_email_desativado.
  ///
  /// In pt, this message translates to:
  /// **'Este e-mail está desativado'**
  String get exceptions_email_desativado;

  /// No description provided for @exceptions_token_expirado.
  ///
  /// In pt, this message translates to:
  /// **'A credencial do usuário não é mais válida. O usuário deve entrar novamente.'**
  String get exceptions_token_expirado;

  /// No description provided for @popup_cad_sucesso.
  ///
  /// In pt, this message translates to:
  /// **'Cadastro realizado com sucesso'**
  String get popup_cad_sucesso;

  /// No description provided for @popup_dados_altsucesso.
  ///
  /// In pt, this message translates to:
  /// **'Dados alterados com sucesso'**
  String get popup_dados_altsucesso;

  /// No description provided for @popup_dados_cadastrados_perg.
  ///
  /// In pt, this message translates to:
  /// **'Dados cadastrados!\nDeseja preencher outras caracteristicas?'**
  String get popup_dados_cadastrados_perg;

  /// No description provided for @popup_dados_cadastrados.
  ///
  /// In pt, this message translates to:
  /// **'Dados cadastrados com sucesso'**
  String get popup_dados_cadastrados;

  /// No description provided for @popup_avaliacao_sucesso.
  ///
  /// In pt, this message translates to:
  /// **'Avaliação concluída com sucesso'**
  String get popup_avaliacao_sucesso;

  /// No description provided for @popup_confirmar_sair.
  ///
  /// In pt, this message translates to:
  /// **'Deseja mesmo sair?'**
  String get popup_confirmar_sair;

  /// No description provided for @popup_dados_erro_crianca.
  ///
  /// In pt, this message translates to:
  /// **'Erro ao tentar cadastrar a criança'**
  String get popup_dados_erro_crianca;

  /// No description provided for @popup_dados_erro_cadastrados.
  ///
  /// In pt, this message translates to:
  /// **'Erro ao tentar adicionar informações!'**
  String get popup_dados_erro_cadastrados;

  /// No description provided for @popup_realizar.
  ///
  /// In pt, this message translates to:
  /// **'Você deseja realizar uma avaliação?'**
  String get popup_realizar;

  /// No description provided for @popup_realizar_outra.
  ///
  /// In pt, this message translates to:
  /// **'Você deseja realizar outra avaliação?'**
  String get popup_realizar_outra;

  /// No description provided for @popup_escolha_avaliacao.
  ///
  /// In pt, this message translates to:
  /// **'Escolha a avaliação'**
  String get popup_escolha_avaliacao;

  /// No description provided for @popup_link_enviado.
  ///
  /// In pt, this message translates to:
  /// **'Um link foi enviado para o seu email! Verifique por favor.'**
  String get popup_link_enviado;

  /// No description provided for @home_titulo.
  ///
  /// In pt, this message translates to:
  /// **'GONOGO\nMotor Control'**
  String get home_titulo;

  /// No description provided for @login_esquecer.
  ///
  /// In pt, this message translates to:
  /// **'Esqueceu sua senha?'**
  String get login_esquecer;

  /// No description provided for @login_lembrar.
  ///
  /// In pt, this message translates to:
  /// **'Lembrar-me'**
  String get login_lembrar;

  /// No description provided for @recuperar_senha_titulo.
  ///
  /// In pt, this message translates to:
  /// **'RECUPERAR SENHA'**
  String get recuperar_senha_titulo;

  /// No description provided for @menu_confirmar_sair.
  ///
  /// In pt, this message translates to:
  /// **'Pressione novamente para sair'**
  String get menu_confirmar_sair;

  /// No description provided for @add_crian_datanascimento.
  ///
  /// In pt, this message translates to:
  /// **'Data de nascimento'**
  String get add_crian_datanascimento;

  /// No description provided for @add_crian_cor.
  ///
  /// In pt, this message translates to:
  /// **'Cor de pele'**
  String get add_crian_cor;

  /// No description provided for @add_crian_corBranca.
  ///
  /// In pt, this message translates to:
  /// **'Branca'**
  String get add_crian_corBranca;

  /// No description provided for @add_crian_corPreta.
  ///
  /// In pt, this message translates to:
  /// **'Preta'**
  String get add_crian_corPreta;

  /// No description provided for @add_crian_corParda.
  ///
  /// In pt, this message translates to:
  /// **'Parda'**
  String get add_crian_corParda;

  /// No description provided for @add_crian_corIndigena.
  ///
  /// In pt, this message translates to:
  /// **'Indígena'**
  String get add_crian_corIndigena;

  /// No description provided for @add_crian_corAmarela.
  ///
  /// In pt, this message translates to:
  /// **'Amarela'**
  String get add_crian_corAmarela;

  /// No description provided for @add_crian_sexo.
  ///
  /// In pt, this message translates to:
  /// **'Sexo'**
  String get add_crian_sexo;

  /// No description provided for @add_crian_sexoMas.
  ///
  /// In pt, this message translates to:
  /// **'Masculino'**
  String get add_crian_sexoMas;

  /// No description provided for @add_crian_sexoFem.
  ///
  /// In pt, this message translates to:
  /// **'Feminino'**
  String get add_crian_sexoFem;

  /// No description provided for @add_crian_renda.
  ///
  /// In pt, this message translates to:
  /// **'Renda familiar'**
  String get add_crian_renda;

  /// No description provided for @add_crian_temp_eletronicos.
  ///
  /// In pt, this message translates to:
  /// **'Tempo(min) em frente a aparelhos eletrônicos'**
  String get add_crian_temp_eletronicos;

  /// No description provided for @add_crian_temp_brinca_casa.
  ///
  /// In pt, this message translates to:
  /// **'Tempo(min) que brinca em casa'**
  String get add_crian_temp_brinca_casa;

  /// No description provided for @add_crian_temp_brinca_fora.
  ///
  /// In pt, this message translates to:
  /// **'Tempo(min) que brinca fora de casa'**
  String get add_crian_temp_brinca_fora;

  /// No description provided for @add_crianca_perg1.
  ///
  /// In pt, this message translates to:
  /// **'Tem dificuldade de manter a atenção em tarefas ou atividades de lazer.'**
  String get add_crianca_perg1;

  /// No description provided for @add_crianca_perg2.
  ///
  /// In pt, this message translates to:
  /// **'Não segue instruções até o fim e não termina deveres de escola, tarefas ou obrigações.'**
  String get add_crianca_perg2;

  /// No description provided for @add_crianca_perg3.
  ///
  /// In pt, this message translates to:
  /// **'Tem dificuldade em se envolver tarefas que exigem esforço mental prolongado.'**
  String get add_crianca_perg3;

  /// No description provided for @add_crianca_perg4.
  ///
  /// In pt, this message translates to:
  /// **'Responde as perguntas de forma precipitada antes delas terem sido terminadas.'**
  String get add_crianca_perg4;

  /// No description provided for @crian_cadastradas_titulo.
  ///
  /// In pt, this message translates to:
  /// **'CRIANÇAS CADASTRADAS'**
  String get crian_cadastradas_titulo;

  /// No description provided for @crian_avaliadas_titulo.
  ///
  /// In pt, this message translates to:
  /// **'CRIANÇAS AVALIADAS'**
  String get crian_avaliadas_titulo;

  /// No description provided for @crian_avaliadas_vazio.
  ///
  /// In pt, this message translates to:
  /// **'Vázio!'**
  String get crian_avaliadas_vazio;

  /// No description provided for @editar_perfil_titulo.
  ///
  /// In pt, this message translates to:
  /// **'PERFIL'**
  String get editar_perfil_titulo;

  /// No description provided for @editar_perfil_nome.
  ///
  /// In pt, this message translates to:
  /// **'NOME'**
  String get editar_perfil_nome;

  /// No description provided for @editar_perfil_dataNascimento.
  ///
  /// In pt, this message translates to:
  /// **'DATA DE NASCIMENTO'**
  String get editar_perfil_dataNascimento;

  /// No description provided for @editar_perfil_sexo.
  ///
  /// In pt, this message translates to:
  /// **'SEXO'**
  String get editar_perfil_sexo;

  /// No description provided for @editar_perfil_cor.
  ///
  /// In pt, this message translates to:
  /// **'COR DA PELE'**
  String get editar_perfil_cor;

  /// No description provided for @avaliacoes_titulo.
  ///
  /// In pt, this message translates to:
  /// **'AVALIAÇÕES'**
  String get avaliacoes_titulo;

  /// No description provided for @resultados_erros.
  ///
  /// In pt, this message translates to:
  /// **'ERROS:'**
  String get resultados_erros;

  /// No description provided for @resultados_omissoes.
  ///
  /// In pt, this message translates to:
  /// **'OMISSÕES:'**
  String get resultados_omissoes;

  /// No description provided for @resultados_acertos.
  ///
  /// In pt, this message translates to:
  /// **'ACERTOS:'**
  String get resultados_acertos;

  /// No description provided for @resultados_toque.
  ///
  /// In pt, this message translates to:
  /// **'TOQUE:'**
  String get resultados_toque;

  /// No description provided for @avaliar_nao_clique_aparecer.
  ///
  /// In pt, this message translates to:
  /// **'NÃO CLIQUE QUANDO APARECER O NÚMERO 6'**
  String get avaliar_nao_clique_aparecer;

  /// No description provided for @avaliar_nao_clique_ouvir.
  ///
  /// In pt, this message translates to:
  /// **'NÃO CLIQUE QUANDO OUVIR O NÚMERO 6'**
  String get avaliar_nao_clique_ouvir;

  /// No description provided for @avaliar_prepare_se.
  ///
  /// In pt, this message translates to:
  /// **'Prepare-se, agora é pra valer'**
  String get avaliar_prepare_se;

  /// No description provided for @avaliar_treino.
  ///
  /// In pt, this message translates to:
  /// **'Treino'**
  String get avaliar_treino;

  /// No description provided for @avaliar_audio.
  ///
  /// In pt, this message translates to:
  /// **'Áudio Motor'**
  String get avaliar_audio;

  /// No description provided for @avaliar_visual.
  ///
  /// In pt, this message translates to:
  /// **'Visual Motor'**
  String get avaliar_visual;

  /// No description provided for @sobre_titulo.
  ///
  /// In pt, this message translates to:
  /// **'Sobre'**
  String get sobre_titulo;

  /// No description provided for @sobre_descricao.
  ///
  /// In pt, this message translates to:
  /// **'O aplicativo tem como finalidade auxiliar profissionais da neuropsicologia, da educação física e psicomotricidade quanto as avaliações do controle inibitório por meio do paradigma GoNoGo.\nFoi proposto pelo Grupo Discente de Programação e Projetos Inovadores do IFCE, campus Canindé.\nEm caso de problemas com a utilização do aplicativo entre em contato com '**
  String get sobre_descricao;

  /// No description provided for @sobre_pesquisadores.
  ///
  /// In pt, this message translates to:
  /// **'Pesquisadores'**
  String get sobre_pesquisadores;

  /// No description provided for @sobre_desenvolvedores.
  ///
  /// In pt, this message translates to:
  /// **'Desenvolvedores'**
  String get sobre_desenvolvedores;

  /// No description provided for @sobre_gerente.
  ///
  /// In pt, this message translates to:
  /// **'Gerente do Projeto'**
  String get sobre_gerente;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'pt'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'pt':
      return AppLocalizationsPt();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
