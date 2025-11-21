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
/// import 'l10n/app_localizations.dart';
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
    Locale('pt'),
  ];

  /// No description provided for @button_login.
  ///
  /// In en, this message translates to:
  /// **'LOGIN'**
  String get button_login;

  /// No description provided for @button_cadastro.
  ///
  /// In en, this message translates to:
  /// **'REGISTER'**
  String get button_cadastro;

  /// No description provided for @button_fechar.
  ///
  /// In en, this message translates to:
  /// **'CLOSE'**
  String get button_fechar;

  /// No description provided for @button_finalizar.
  ///
  /// In en, this message translates to:
  /// **'FINALIZE'**
  String get button_finalizar;

  /// No description provided for @button_continuar.
  ///
  /// In en, this message translates to:
  /// **'CONTINUE'**
  String get button_continuar;

  /// No description provided for @button_salvar.
  ///
  /// In en, this message translates to:
  /// **'SAVE'**
  String get button_salvar;

  /// No description provided for @button_seguinte.
  ///
  /// In en, this message translates to:
  /// **'NEXT'**
  String get button_seguinte;

  /// No description provided for @button_sim.
  ///
  /// In en, this message translates to:
  /// **'YES'**
  String get button_sim;

  /// No description provided for @button_nao.
  ///
  /// In en, this message translates to:
  /// **'NO'**
  String get button_nao;

  /// No description provided for @button_add_crianca.
  ///
  /// In en, this message translates to:
  /// **'ADD. CHILD'**
  String get button_add_crianca;

  /// No description provided for @button_avaliar.
  ///
  /// In en, this message translates to:
  /// **'EVALUATE'**
  String get button_avaliar;

  /// No description provided for @button_resultados.
  ///
  /// In en, this message translates to:
  /// **'RESULTS'**
  String get button_resultados;

  /// No description provided for @button_sair.
  ///
  /// In en, this message translates to:
  /// **'EXIT'**
  String get button_sair;

  /// No description provided for @button_cancelar.
  ///
  /// In en, this message translates to:
  /// **'CANCEL'**
  String get button_cancelar;

  /// No description provided for @button_avaliar_novamente.
  ///
  /// In en, this message translates to:
  /// **'AGAIN EVALUATE'**
  String get button_avaliar_novamente;

  /// No description provided for @button_visual.
  ///
  /// In en, this message translates to:
  /// **'Visual'**
  String get button_visual;

  /// No description provided for @button_audio.
  ///
  /// In en, this message translates to:
  /// **'Audio'**
  String get button_audio;

  /// No description provided for @button_comecar.
  ///
  /// In en, this message translates to:
  /// **'START'**
  String get button_comecar;

  /// No description provided for @button_confirmar.
  ///
  /// In en, this message translates to:
  /// **'CONFIRM'**
  String get button_confirmar;

  /// No description provided for @form_obrigatorio.
  ///
  /// In en, this message translates to:
  /// **'required field'**
  String get form_obrigatorio;

  /// No description provided for @form_senha_incorreta.
  ///
  /// In en, this message translates to:
  /// **'incorrect password'**
  String get form_senha_incorreta;

  /// No description provided for @form_senha_naoconferem.
  ///
  /// In en, this message translates to:
  /// **'passwords do not match'**
  String get form_senha_naoconferem;

  /// No description provided for @form_email_naoconferem.
  ///
  /// In en, this message translates to:
  /// **'emails do not match'**
  String get form_email_naoconferem;

  /// No description provided for @form_email_naoencontrado.
  ///
  /// In en, this message translates to:
  /// **'email not found'**
  String get form_email_naoencontrado;

  /// No description provided for @form_email_caractere.
  ///
  /// In en, this message translates to:
  /// **'fill with \'@\''**
  String get form_email_caractere;

  /// No description provided for @form_names_carecteres.
  ///
  /// In en, this message translates to:
  /// **'this field must be at least 3 characters long'**
  String get form_names_carecteres;

  /// No description provided for @form_senha_caracteres.
  ///
  /// In en, this message translates to:
  /// **'password must be at least 6 characters long'**
  String get form_senha_caracteres;

  /// No description provided for @global_nome_completo.
  ///
  /// In en, this message translates to:
  /// **'Name complete'**
  String get global_nome_completo;

  /// No description provided for @global_email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get global_email;

  /// No description provided for @global_confirmaremail.
  ///
  /// In en, this message translates to:
  /// **'Confirm email'**
  String get global_confirmaremail;

  /// No description provided for @global_senha.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get global_senha;

  /// No description provided for @global_novasenha.
  ///
  /// In en, this message translates to:
  /// **'New password'**
  String get global_novasenha;

  /// No description provided for @global_confirmarsenha.
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get global_confirmarsenha;

  /// No description provided for @global_instituicao.
  ///
  /// In en, this message translates to:
  /// **'Institution'**
  String get global_instituicao;

  /// No description provided for @global_pesquisar.
  ///
  /// In en, this message translates to:
  /// **'Search child...'**
  String get global_pesquisar;

  /// No description provided for @global_carregando.
  ///
  /// In en, this message translates to:
  /// **'Loading information...'**
  String get global_carregando;

  /// No description provided for @global_erro_dados1.
  ///
  /// In en, this message translates to:
  /// **'Error loading data'**
  String get global_erro_dados1;

  /// No description provided for @global_erro_dados2.
  ///
  /// In en, this message translates to:
  /// **'Error trying to load data!'**
  String get global_erro_dados2;

  /// No description provided for @global_data_teste.
  ///
  /// In en, this message translates to:
  /// **'Test Date'**
  String get global_data_teste;

  /// No description provided for @global_avaliacoes.
  ///
  /// In en, this message translates to:
  /// **'Evaluations'**
  String get global_avaliacoes;

  /// No description provided for @global_erros.
  ///
  /// In en, this message translates to:
  /// **'Errors'**
  String get global_erros;

  /// No description provided for @global_omissoes.
  ///
  /// In en, this message translates to:
  /// **'Omissions'**
  String get global_omissoes;

  /// No description provided for @global_acertos.
  ///
  /// In en, this message translates to:
  /// **'Hits'**
  String get global_acertos;

  /// No description provided for @global_quant_toques.
  ///
  /// In en, this message translates to:
  /// **'Number of touches'**
  String get global_quant_toques;

  /// No description provided for @validator_nome_minimo.
  ///
  /// In en, this message translates to:
  /// **'Name must be more than 2 characters'**
  String get validator_nome_minimo;

  /// No description provided for @validator_nome_invalido.
  ///
  /// In en, this message translates to:
  /// **'Invalid name'**
  String get validator_nome_invalido;

  /// No description provided for @validator_data_invalida.
  ///
  /// In en, this message translates to:
  /// **'Invalid date'**
  String get validator_data_invalida;

  /// No description provided for @exceptions_email_invalido.
  ///
  /// In en, this message translates to:
  /// **'This email is invalid'**
  String get exceptions_email_invalido;

  /// No description provided for @exceptions_email_naoencontrado.
  ///
  /// In en, this message translates to:
  /// **'Email not found'**
  String get exceptions_email_naoencontrado;

  /// No description provided for @exceptions_erro_login.
  ///
  /// In en, this message translates to:
  /// **'An error occurred in the login process'**
  String get exceptions_erro_login;

  /// No description provided for @exceptions_erro_recsenha.
  ///
  /// In en, this message translates to:
  /// **'An error occurred in the password recovery process'**
  String get exceptions_erro_recsenha;

  /// No description provided for @exceptions_email_cadastrado.
  ///
  /// In en, this message translates to:
  /// **'E-mail already registered'**
  String get exceptions_email_cadastrado;

  /// No description provided for @exceptions_pedidos.
  ///
  /// In en, this message translates to:
  /// **'Too many requests.\nPlease try again later'**
  String get exceptions_pedidos;

  /// No description provided for @exceptions_operacao_negada.
  ///
  /// In en, this message translates to:
  /// **'Operation not allowed'**
  String get exceptions_operacao_negada;

  /// No description provided for @exceptions_erro_processo.
  ///
  /// In en, this message translates to:
  /// **'An error occurred in this process.\n Please try again'**
  String get exceptions_erro_processo;

  /// No description provided for @exceptions_senha_incorreta.
  ///
  /// In en, this message translates to:
  /// **'The password is incorrect'**
  String get exceptions_senha_incorreta;

  /// No description provided for @exceptions_conta_desabilitada.
  ///
  /// In en, this message translates to:
  /// **'User account has been disabled by an administrator'**
  String get exceptions_conta_desabilitada;

  /// No description provided for @exceptions_erro_servidor.
  ///
  /// In en, this message translates to:
  /// **'Server error, please try again later'**
  String get exceptions_erro_servidor;

  /// No description provided for @exceptions_email_desativado.
  ///
  /// In en, this message translates to:
  /// **'This email is disabled'**
  String get exceptions_email_desativado;

  /// No description provided for @exceptions_token_expirado.
  ///
  /// In en, this message translates to:
  /// **'The user\'s credential is no longer valid. The user must sign in again.'**
  String get exceptions_token_expirado;

  /// No description provided for @popup_cad_sucesso.
  ///
  /// In en, this message translates to:
  /// **'Registration completed successfully'**
  String get popup_cad_sucesso;

  /// No description provided for @popup_dados_altsucesso.
  ///
  /// In en, this message translates to:
  /// **'Successfully changed data'**
  String get popup_dados_altsucesso;

  /// No description provided for @popup_dados_cadastrados_perg.
  ///
  /// In en, this message translates to:
  /// **'Registered data!\nDo you want to fill in other characteristics?'**
  String get popup_dados_cadastrados_perg;

  /// No description provided for @popup_dados_cadastrados.
  ///
  /// In en, this message translates to:
  /// **'Data successfully registered'**
  String get popup_dados_cadastrados;

  /// No description provided for @popup_avaliacao_sucesso.
  ///
  /// In en, this message translates to:
  /// **'Evaluation completed successfully'**
  String get popup_avaliacao_sucesso;

  /// No description provided for @popup_confirmar_sair.
  ///
  /// In en, this message translates to:
  /// **'Do you really want to leave?'**
  String get popup_confirmar_sair;

  /// No description provided for @popup_dados_erro_crianca.
  ///
  /// In en, this message translates to:
  /// **'Error when trying to register the child'**
  String get popup_dados_erro_crianca;

  /// No description provided for @popup_dados_erro_cadastrados.
  ///
  /// In en, this message translates to:
  /// **'Error when trying to add information!'**
  String get popup_dados_erro_cadastrados;

  /// No description provided for @popup_realizar.
  ///
  /// In en, this message translates to:
  /// **'Do you want to carry out an assessment?'**
  String get popup_realizar;

  /// No description provided for @popup_realizar_outra.
  ///
  /// In en, this message translates to:
  /// **'Do you want to carry out another assessment?'**
  String get popup_realizar_outra;

  /// No description provided for @popup_escolha_avaliacao.
  ///
  /// In en, this message translates to:
  /// **'Choose the evaluation'**
  String get popup_escolha_avaliacao;

  /// No description provided for @popup_link_enviado.
  ///
  /// In en, this message translates to:
  /// **'A link has been sent to your email! Please check.'**
  String get popup_link_enviado;

  /// No description provided for @home_titulo.
  ///
  /// In en, this message translates to:
  /// **'GONOGO\nMotor Control'**
  String get home_titulo;

  /// No description provided for @login_esquecer.
  ///
  /// In en, this message translates to:
  /// **'Forgot your password?'**
  String get login_esquecer;

  /// No description provided for @login_lembrar.
  ///
  /// In en, this message translates to:
  /// **'Remember me'**
  String get login_lembrar;

  /// No description provided for @recuperar_senha_titulo.
  ///
  /// In en, this message translates to:
  /// **'RECOVER PASSWORD'**
  String get recuperar_senha_titulo;

  /// No description provided for @menu_confirmar_sair.
  ///
  /// In en, this message translates to:
  /// **'Press again to exit'**
  String get menu_confirmar_sair;

  /// No description provided for @add_crian_datanascimento.
  ///
  /// In en, this message translates to:
  /// **'Date of birth'**
  String get add_crian_datanascimento;

  /// No description provided for @add_crian_cor.
  ///
  /// In en, this message translates to:
  /// **'Skin color'**
  String get add_crian_cor;

  /// No description provided for @add_crian_corBranca.
  ///
  /// In en, this message translates to:
  /// **'White'**
  String get add_crian_corBranca;

  /// No description provided for @add_crian_corPreta.
  ///
  /// In en, this message translates to:
  /// **'Black'**
  String get add_crian_corPreta;

  /// No description provided for @add_crian_corParda.
  ///
  /// In en, this message translates to:
  /// **'Brown'**
  String get add_crian_corParda;

  /// No description provided for @add_crian_corIndigena.
  ///
  /// In en, this message translates to:
  /// **'Indigenous'**
  String get add_crian_corIndigena;

  /// No description provided for @add_crian_corAmarela.
  ///
  /// In en, this message translates to:
  /// **'Yellow'**
  String get add_crian_corAmarela;

  /// No description provided for @add_crian_sexo.
  ///
  /// In en, this message translates to:
  /// **'Sex'**
  String get add_crian_sexo;

  /// No description provided for @add_crian_sexoMas.
  ///
  /// In en, this message translates to:
  /// **'Masculine'**
  String get add_crian_sexoMas;

  /// No description provided for @add_crian_sexoFem.
  ///
  /// In en, this message translates to:
  /// **'Feminine'**
  String get add_crian_sexoFem;

  /// No description provided for @add_crian_renda.
  ///
  /// In en, this message translates to:
  /// **'Family income'**
  String get add_crian_renda;

  /// No description provided for @add_crian_temp_eletronicos.
  ///
  /// In en, this message translates to:
  /// **'Time(min) in front of electronic devices'**
  String get add_crian_temp_eletronicos;

  /// No description provided for @add_crian_temp_brinca_casa.
  ///
  /// In en, this message translates to:
  /// **'Time(min) playing at home'**
  String get add_crian_temp_brinca_casa;

  /// No description provided for @add_crian_temp_brinca_fora.
  ///
  /// In en, this message translates to:
  /// **'Time(min) playing outside the home'**
  String get add_crian_temp_brinca_fora;

  /// No description provided for @add_crianca_perg1.
  ///
  /// In en, this message translates to:
  /// **'Has difficulty sustaining attention in tasks or leisure activities.'**
  String get add_crianca_perg1;

  /// No description provided for @add_crianca_perg2.
  ///
  /// In en, this message translates to:
  /// **'Does not follow through on instructions and fails to finish schoolwork, assignments, or obligations.'**
  String get add_crianca_perg2;

  /// No description provided for @add_crianca_perg3.
  ///
  /// In en, this message translates to:
  /// **'Has difficulty engaging in tasks that require prolonged mental effort.'**
  String get add_crianca_perg3;

  /// No description provided for @add_crianca_perg4.
  ///
  /// In en, this message translates to:
  /// **'Responds to questions in a rush before they are finished.'**
  String get add_crianca_perg4;

  /// No description provided for @crian_cadastradas_titulo.
  ///
  /// In en, this message translates to:
  /// **'REGISTERED CHILDREN'**
  String get crian_cadastradas_titulo;

  /// No description provided for @crian_avaliadas_titulo.
  ///
  /// In en, this message translates to:
  /// **'EVALUATED CHILDREN'**
  String get crian_avaliadas_titulo;

  /// No description provided for @crian_avaliadas_vazio.
  ///
  /// In en, this message translates to:
  /// **'Empty!'**
  String get crian_avaliadas_vazio;

  /// No description provided for @editar_perfil_titulo.
  ///
  /// In en, this message translates to:
  /// **'PROFILE'**
  String get editar_perfil_titulo;

  /// No description provided for @editar_perfil_nome.
  ///
  /// In en, this message translates to:
  /// **'NAME'**
  String get editar_perfil_nome;

  /// No description provided for @editar_perfil_dataNascimento.
  ///
  /// In en, this message translates to:
  /// **'BIRTH DATE'**
  String get editar_perfil_dataNascimento;

  /// No description provided for @editar_perfil_sexo.
  ///
  /// In en, this message translates to:
  /// **'SEX'**
  String get editar_perfil_sexo;

  /// No description provided for @editar_perfil_cor.
  ///
  /// In en, this message translates to:
  /// **'SKIN COLOR'**
  String get editar_perfil_cor;

  /// No description provided for @avaliacoes_titulo.
  ///
  /// In en, this message translates to:
  /// **'EVALUATIONS'**
  String get avaliacoes_titulo;

  /// No description provided for @resultados_erros.
  ///
  /// In en, this message translates to:
  /// **'ERRORS:'**
  String get resultados_erros;

  /// No description provided for @resultados_omissoes.
  ///
  /// In en, this message translates to:
  /// **'OMISSIONS:'**
  String get resultados_omissoes;

  /// No description provided for @resultados_acertos.
  ///
  /// In en, this message translates to:
  /// **'HITS:'**
  String get resultados_acertos;

  /// No description provided for @resultados_toque.
  ///
  /// In en, this message translates to:
  /// **'TOUCH:'**
  String get resultados_toque;

  /// No description provided for @avaliar_nao_clique_aparecer.
  ///
  /// In en, this message translates to:
  /// **'DO NOT CLICK WHEN THE NUMBER 6 APPEARS'**
  String get avaliar_nao_clique_aparecer;

  /// No description provided for @avaliar_nao_clique_ouvir.
  ///
  /// In en, this message translates to:
  /// **'DON\'T CLICK WHEN YOU HEAR THE NUMBER 6'**
  String get avaliar_nao_clique_ouvir;

  /// No description provided for @avaliar_prepare_se.
  ///
  /// In en, this message translates to:
  /// **'Get ready, now it\'s for real!'**
  String get avaliar_prepare_se;

  /// No description provided for @avaliar_treino.
  ///
  /// In en, this message translates to:
  /// **'Training'**
  String get avaliar_treino;

  /// No description provided for @avaliar_audio.
  ///
  /// In en, this message translates to:
  /// **'Engine Audio'**
  String get avaliar_audio;

  /// No description provided for @avaliar_visual.
  ///
  /// In en, this message translates to:
  /// **'Visual Engine'**
  String get avaliar_visual;

  /// No description provided for @sobre_titulo.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get sobre_titulo;

  /// No description provided for @sobre_descricao.
  ///
  /// In en, this message translates to:
  /// **'The application aims to help neuropsychology, physical education and psychomotricity professionals regarding the assessment of inhibitory control through the GoNoGo paradigm.\nIt was proposed by the Student Group of Programming and Innovative Projects of the IFCE, Canindé campus.\nIn case of problems with the use of the application contact '**
  String get sobre_descricao;

  /// No description provided for @sobre_pesquisadores.
  ///
  /// In en, this message translates to:
  /// **'Researchers'**
  String get sobre_pesquisadores;

  /// No description provided for @sobre_desenvolvedores.
  ///
  /// In en, this message translates to:
  /// **'Developers'**
  String get sobre_desenvolvedores;

  /// No description provided for @sobre_gerente.
  ///
  /// In en, this message translates to:
  /// **'Project Manager'**
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
    'that was used.',
  );
}
