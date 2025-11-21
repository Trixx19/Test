class ExceptionsRegister implements Exception {
  static const Map<String, String> errors = {
    "email-already-in-use": 'E-mail já cadastrado!',
    "invalid-email": 'Este email é inválido!',
    "too-many-requests": 'Muitos pedidos.\nTente mais tarde!',
    "operation-not-allowed": 'Operação não permitida!',
  };
  final String key;
  ExceptionsRegister(this.key);

  @override
  String toString() {
    return errors[key] ?? 'Ocorreu um erro no processo de cadastro!';
  }
}

class ExceptionsLogin implements Exception {
  static const Map<String, String> errors = {
    "user-not-found": 'E-mail não encontrado.',
    'wrong-password': 'A senha está incorreta.',
    'user-disabled':
        'A conta do usuário foi desabilitada por um administrador!',
    'operation-not-allowed': "Erro no servidor, tente novamente mais tarde.",
    'invalid-email': "Este email é inválido!",
  };
  final String key;
  ExceptionsLogin(this.key);

  @override
  String toString() {
    return errors[key] ?? 'Ocorreu um erro no processo de login!';
  }
}

class ExceptionsRecoverPassword implements Exception {
  static const Map<String, String> errors = {
    "user-not-found": 'E-mail não encontrado!',
    "missing-email": "Este email está desativado!",
    "invalid-email": "Este email é inválido!",
  };
  final String key;
  ExceptionsRecoverPassword(this.key);

  @override
  String toString() {
    return errors[key] ??
        'Ocorreu um erro no processo de recuperação de senha!';
  }
}

class ExceptionResetEmailPassword implements Exception {
  static const Map<String, String> errors = {
    "user-token-expired":
        " The user's credential is no longer valid. The user must sign in again.",
  };
  final String key;
  ExceptionResetEmailPassword(this.key);
  @override
  String toString() {
    return errors[key] ??
        'Ocorreu um erro no processo de recuperação de senha!';
  }
}
