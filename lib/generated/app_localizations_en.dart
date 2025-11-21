// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get button_login => 'LOGIN';

  @override
  String get button_cadastro => 'REGISTER';

  @override
  String get button_fechar => 'CLOSE';

  @override
  String get button_finalizar => 'FINALIZE';

  @override
  String get button_continuar => 'CONTINUE';

  @override
  String get button_salvar => 'SAVE';

  @override
  String get button_seguinte => 'NEXT';

  @override
  String get button_sim => 'YES';

  @override
  String get button_nao => 'NO';

  @override
  String get button_add_crianca => 'ADD. CHILD';

  @override
  String get button_avaliar => 'EVALUATE';

  @override
  String get button_resultados => 'RESULTS';

  @override
  String get button_sair => 'EXIT';

  @override
  String get button_cancelar => 'CANCEL';

  @override
  String get button_avaliar_novamente => 'AGAIN EVALUATE';

  @override
  String get button_visual => 'Visual';

  @override
  String get button_audio => 'Audio';

  @override
  String get button_comecar => 'START';

  @override
  String get button_confirmar => 'CONFIRM';

  @override
  String get form_obrigatorio => 'required field';

  @override
  String get form_senha_incorreta => 'incorrect password';

  @override
  String get form_senha_naoconferem => 'passwords do not match';

  @override
  String get form_email_naoconferem => 'emails do not match';

  @override
  String get form_email_naoencontrado => 'email not found';

  @override
  String get form_email_caractere => 'fill with \'@\'';

  @override
  String get form_names_carecteres =>
      'this field must be at least 3 characters long';

  @override
  String get form_senha_caracteres =>
      'password must be at least 6 characters long';

  @override
  String get global_nome_completo => 'Name complete';

  @override
  String get global_email => 'Email';

  @override
  String get global_confirmaremail => 'Confirm email';

  @override
  String get global_senha => 'Password';

  @override
  String get global_novasenha => 'New password';

  @override
  String get global_confirmarsenha => 'Confirm password';

  @override
  String get global_instituicao => 'Institution';

  @override
  String get global_pesquisar => 'Search child...';

  @override
  String get global_carregando => 'Loading information...';

  @override
  String get global_erro_dados1 => 'Error loading data';

  @override
  String get global_erro_dados2 => 'Error trying to load data!';

  @override
  String get global_data_teste => 'Test Date';

  @override
  String get global_avaliacoes => 'Evaluations';

  @override
  String get global_erros => 'Errors';

  @override
  String get global_omissoes => 'Omissions';

  @override
  String get global_acertos => 'Hits';

  @override
  String get global_quant_toques => 'Number of touches';

  @override
  String get validator_nome_minimo => 'Name must be more than 2 characters';

  @override
  String get validator_nome_invalido => 'Invalid name';

  @override
  String get validator_data_invalida => 'Invalid date';

  @override
  String get exceptions_email_invalido => 'This email is invalid';

  @override
  String get exceptions_email_naoencontrado => 'Email not found';

  @override
  String get exceptions_erro_login => 'An error occurred in the login process';

  @override
  String get exceptions_erro_recsenha =>
      'An error occurred in the password recovery process';

  @override
  String get exceptions_email_cadastrado => 'E-mail already registered';

  @override
  String get exceptions_pedidos => 'Too many requests.\nPlease try again later';

  @override
  String get exceptions_operacao_negada => 'Operation not allowed';

  @override
  String get exceptions_erro_processo =>
      'An error occurred in this process.\n Please try again';

  @override
  String get exceptions_senha_incorreta => 'The password is incorrect';

  @override
  String get exceptions_conta_desabilitada =>
      'User account has been disabled by an administrator';

  @override
  String get exceptions_erro_servidor => 'Server error, please try again later';

  @override
  String get exceptions_email_desativado => 'This email is disabled';

  @override
  String get exceptions_token_expirado =>
      'The user\'s credential is no longer valid. The user must sign in again.';

  @override
  String get popup_cad_sucesso => 'Registration completed successfully';

  @override
  String get popup_dados_altsucesso => 'Successfully changed data';

  @override
  String get popup_dados_cadastrados_perg =>
      'Registered data!\nDo you want to fill in other characteristics?';

  @override
  String get popup_dados_cadastrados => 'Data successfully registered';

  @override
  String get popup_avaliacao_sucesso => 'Evaluation completed successfully';

  @override
  String get popup_confirmar_sair => 'Do you really want to leave?';

  @override
  String get popup_dados_erro_crianca =>
      'Error when trying to register the child';

  @override
  String get popup_dados_erro_cadastrados =>
      'Error when trying to add information!';

  @override
  String get popup_realizar => 'Do you want to carry out an assessment?';

  @override
  String get popup_realizar_outra =>
      'Do you want to carry out another assessment?';

  @override
  String get popup_escolha_avaliacao => 'Choose the evaluation';

  @override
  String get popup_link_enviado =>
      'A link has been sent to your email! Please check.';

  @override
  String get home_titulo => 'GONOGO\nMotor Control';

  @override
  String get login_esquecer => 'Forgot your password?';

  @override
  String get login_lembrar => 'Remember me';

  @override
  String get recuperar_senha_titulo => 'RECOVER PASSWORD';

  @override
  String get menu_confirmar_sair => 'Press again to exit';

  @override
  String get add_crian_datanascimento => 'Date of birth';

  @override
  String get add_crian_cor => 'Skin color';

  @override
  String get add_crian_corBranca => 'White';

  @override
  String get add_crian_corPreta => 'Black';

  @override
  String get add_crian_corParda => 'Brown';

  @override
  String get add_crian_corIndigena => 'Indigenous';

  @override
  String get add_crian_corAmarela => 'Yellow';

  @override
  String get add_crian_sexo => 'Sex';

  @override
  String get add_crian_sexoMas => 'Masculine';

  @override
  String get add_crian_sexoFem => 'Feminine';

  @override
  String get add_crian_renda => 'Family income';

  @override
  String get add_crian_temp_eletronicos =>
      'Time(min) in front of electronic devices';

  @override
  String get add_crian_temp_brinca_casa => 'Time(min) playing at home';

  @override
  String get add_crian_temp_brinca_fora => 'Time(min) playing outside the home';

  @override
  String get add_crianca_perg1 =>
      'Has difficulty sustaining attention in tasks or leisure activities.';

  @override
  String get add_crianca_perg2 =>
      'Does not follow through on instructions and fails to finish schoolwork, assignments, or obligations.';

  @override
  String get add_crianca_perg3 =>
      'Has difficulty engaging in tasks that require prolonged mental effort.';

  @override
  String get add_crianca_perg4 =>
      'Responds to questions in a rush before they are finished.';

  @override
  String get crian_cadastradas_titulo => 'REGISTERED CHILDREN';

  @override
  String get crian_avaliadas_titulo => 'EVALUATED CHILDREN';

  @override
  String get crian_avaliadas_vazio => 'Empty!';

  @override
  String get editar_perfil_titulo => 'PROFILE';

  @override
  String get editar_perfil_nome => 'NAME';

  @override
  String get editar_perfil_dataNascimento => 'BIRTH DATE';

  @override
  String get editar_perfil_sexo => 'SEX';

  @override
  String get editar_perfil_cor => 'SKIN COLOR';

  @override
  String get avaliacoes_titulo => 'EVALUATIONS';

  @override
  String get resultados_erros => 'ERRORS:';

  @override
  String get resultados_omissoes => 'OMISSIONS:';

  @override
  String get resultados_acertos => 'HITS:';

  @override
  String get resultados_toque => 'TOUCH:';

  @override
  String get avaliar_nao_clique_aparecer =>
      'DO NOT CLICK WHEN THE NUMBER 6 APPEARS';

  @override
  String get avaliar_nao_clique_ouvir =>
      'DON\'T CLICK WHEN YOU HEAR THE NUMBER 6';

  @override
  String get avaliar_prepare_se => 'Get ready, now it\'s for real!';

  @override
  String get avaliar_treino => 'Training';

  @override
  String get avaliar_audio => 'Engine Audio';

  @override
  String get avaliar_visual => 'Visual Engine';

  @override
  String get sobre_titulo => 'About';

  @override
  String get sobre_descricao =>
      'The application aims to help neuropsychology, physical education and psychomotricity professionals regarding the assessment of inhibitory control through the GoNoGo paradigm.\nIt was proposed by the Student Group of Programming and Innovative Projects of the IFCE, Canindé campus.\nIn case of problems with the use of the application contact ';

  @override
  String get sobre_pesquisadores => 'Researchers';

  @override
  String get sobre_desenvolvedores => 'Developers';

  @override
  String get sobre_gerente => 'Project Manager';
}
