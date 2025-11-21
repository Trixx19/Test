import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:gonogo/models/utils/exceptions.dart';

class ControllerEvaluator {
  FirebaseAuth auth = FirebaseAuth.instance;
  Future<void> register(Map<String, dynamic> formData) async {
    FirebaseFirestore bd = FirebaseFirestore.instance;
    String identificador = "";
    try {
      await auth
          .createUserWithEmailAndPassword(
            email: formData["email"],
            password: formData["password"],
          )
          .then((value) => identificador = value.user!.uid);
      await bd.collection("Avaliadores").doc(identificador).set({
        "nome": formData["name"],
        "instituicao": formData["institution"],
        "foto_perfil": "",
        "criancas": {}
      });
    } on FirebaseAuthException catch (errors) {
      throw ExceptionsRegister(errors.code.toString());
    }
  }

  Future<void> resetPassword({required String email}) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (errors) {
      throw ExceptionsRecoverPassword(errors.code.toString());
    }
  }

  Future<void> login(Map<String, dynamic> formData) async {
    try {
      await auth.signInWithEmailAndPassword(
          email: formData['email'], password: formData['senha']);
    } on FirebaseAuthException catch (error) {
      throw ExceptionsLogin(error.code.toString());
    }
  }

  Future<int> seeUser() async {
    User? user = auth.currentUser;
    if (user == null) {
      return 0;
    } else {
      return 1;
    }
  }

  Future seeProfile() async {
    String id = await identificacao();
    String email = auth.currentUser!.email.toString();
    FirebaseFirestore db = FirebaseFirestore.instance;
    final dados = await db.collection("Avaliadores").doc(id).get();
    final data = dados.data();
    final informacoes = [email, data];
    return informacoes;
  }

  Future<void> updateUser(String nome, String lastEmail, String newEmail,
      String newPassword) async {
    User user = auth.currentUser!;
    FirebaseFirestore db = FirebaseFirestore.instance;
    try {
      db.collection("Avaliadores").doc(user.uid).update({"nome": nome});
      if (lastEmail != newEmail) {
        await user.verifyBeforeUpdateEmail(newEmail);
      }
      if (newPassword != "******") {
        await user.updatePassword(newPassword);
      }
    } on FirebaseAuthException catch (error) {
      throw ExceptionResetEmailPassword(error.code.toString());
    }
  }

  Future<String> upload(File imagem) async {
    final storage = FirebaseStorage.instance;
    String nome = auth.currentUser!.uid;

    final pastaRaiz = storage.ref();
    Reference arquivo = pastaRaiz.child("Perfil").child("$nome.jpg");
    await arquivo.putFile(imagem);
    String downloadURL = await arquivo.getDownloadURL();
    await _atualizarUrlImagem(downloadURL, nome);

    return downloadURL;
  }

  _atualizarUrlImagem(String url, String id) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    db.collection("Avaliadores").doc(id).update({"foto_perfil": url});
  }

  Future identificacao() async {
    User usuario = auth.currentUser!;
    return (usuario.uid);
  }

  Future<void> logout() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    auth.signOut();
  }
}
