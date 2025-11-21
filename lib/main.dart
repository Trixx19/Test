import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:gonogo/firebase_options.dart';
import 'package:gonogo/views/tela_criancas_avaliadas.dart';
import 'package:gonogo/views/tela_editar_perfil.dart';
import 'package:gonogo/views/tela_recuperar_senha.dart';
import 'package:gonogo/views/tela_sobre.dart';
import 'views/tela_criancas_cadastradas.dart';
import 'views/tela_home.dart';
import 'views/tela_login.dart';
import 'views/tela_cadastro_usuario.dart';
import 'views/tela_menu.dart';
import 'views/tela_add_crianca.dart';
import 'models/utils/rotas-app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final tema = ThemeData();
  MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
          statusBarColor: Colors.black,
          statusBarBrightness: Brightness.light,
          systemNavigationBarColor: Colors.black,
          systemNavigationBarIconBrightness: Brightness.light),
    );
    return MaterialApp(
      theme: ThemeData(
        // APP BAR
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'Raleway',
            fontSize: 25,
            color: Color(0xff1E70AD),
          ),
        ),
        // FLOATING BUTTON
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          elevation: 0,
          focusElevation: 0,
          hoverElevation: 0,
          disabledElevation: 0,
          highlightElevation: 0,
          splashColor: Colors.transparent,
          foregroundColor: Colors.white,
          backgroundColor: Color(0xff48CC48),
        ),
        canvasColor: const Color.fromARGB(255, 231, 229, 255),
        // TEXT
        textTheme: const TextTheme(
          headlineLarge: TextStyle(
            color: Color(0xff1E70AD),
            fontSize: 20,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.bold,
          ),
          headlineMedium: TextStyle(
            color: Color(0xff48CC48),
            fontSize: 25,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.bold,
          ),
          headlineSmall: TextStyle(
            color: Color(0xff1E70AD),
            fontSize: 25,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.bold,
          ),
        ),
        // INPUT DECORATION
        inputDecorationTheme: InputDecorationTheme(
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.red,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          labelStyle: const TextStyle(
            fontFamily: 'Montserrat',
            color: Color(0xff1E70AD),
            fontSize: 20,
          ),
          border: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color(0xff1E70AD),
            ),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        // TEXT BUTTON
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            textStyle: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        // ELEVATED BUTTON
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            textStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'Raleway',
              fontSize: 25,
              color: Color(0xff1E70AD),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
      ),
      debugShowCheckedModeBanner: false, //Tirar o 'Debug'
      //As rotas estão definidas em ultilitarios rotas-app
      routes: {
        RotasApp.home: (context) => const TelaHome(),
        RotasApp.login: (context) => const TelaLogin(),
        RotasApp.cadastro: (context) => const TelaCadastroUsuario(),
        RotasApp.menu: (context) => const TelaMenu(),
        RotasApp.addCrianca: ((context) => const TelaAddCrianca1()),
        RotasApp.criancasCadastradas: ((context) =>
            const TelaCriancasCadastradas()),
        RotasApp.criancasAvaliadas: (context) => const TelaCriancasAvaliadas(),
        // RotasApp.AVALIACOES: (context) => const TelaAvaliacoes(),
        RotasApp.recuperarSenha: (context) => const TelaRecuperarSenha(),
        RotasApp.editarPerfil: (context) => const TelaEditarPerfil(),
        RotasApp.sobre: (context) => const TelaSobre(),
      },
    );
  }
}
