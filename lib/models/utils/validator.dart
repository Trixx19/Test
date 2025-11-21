class Validator {
  String? validarNome(String? nome) {
    if (nome == null || nome.trim().isEmpty) {
      return "O Nome deve ter mais de 2 caracteres";
    }

    if (nome.length < 3) {
      return "O Nome deve ter mais de 2 caracteres";
    }

    String pattern = r'^[a-zA-Z\u00C0-\u017F\s]+$';
    RegExp regExp = RegExp(pattern);

    if (!regExp.hasMatch(nome)) {
      return "Nome inválido. Use apenas letras e espaços.";
    }

    return null;
  }

  String? validarCampoObrigatorio(String? valor) {
    if (valor == null || valor.trim().isEmpty || valor == " ") {
      return "Este campo é obrigatório";
    }
    return null;
  }

  String? validarDataNascimento(String? valor) {
    if (valor == null || valor.trim().isEmpty) {
      return "Este campo é obrigatório";
    }

    RegExp regexData = RegExp(r'^\d{2}/\d{2}/\d{4}$');
    if (!regexData.hasMatch(valor)) {
      return "Formato deve ser dd/MM/aaaa";
    }

    try {
      List<String> partes = valor.split('/');
      int dia = int.parse(partes[0]);
      int mes = int.parse(partes[1]);
      int ano = int.parse(partes[2]);

      DateTime dataNascimento;
      try {
        if (mes < 1 || mes > 12 || dia < 1 || dia > 31 || ano < 1900) {
          return "Data inválida";
        }
        dataNascimento = DateTime(ano, mes, dia);
        if (dataNascimento.day != dia ||
            dataNascimento.month != mes ||
            dataNascimento.year != ano) {
          return "Data inválida (ex: 30/02)";
        }
      } catch (e) {
        return "Data inválida";
      }

      final hoje = DateTime.now();
      final hojeMeiaNoite = DateTime(hoje.year, hoje.month, hoje.day);

      if (dataNascimento.isAfter(hojeMeiaNoite)) {
        return "Data futura não permitida";
      }

      int idade = hoje.year - dataNascimento.year;
      if (hoje.month < dataNascimento.month ||
          (hoje.month == dataNascimento.month &&
              hoje.day < dataNascimento.day)) {
        idade--;
      }
      const int idadeMinima = 0;
      const int idadeMaxima = 12;

      if (idade < idadeMinima || idade > idadeMaxima) {
        DateTime dataMinimaNasc =
            DateTime(hoje.year - (idadeMaxima + 1), hoje.month, hoje.day)
                .add(const Duration(days: 1));

        int anoMinimoPermitido = dataMinimaNasc.year;
        int anoMaximoPermitido = hoje.year;

        return "Idade fora da faixa ($idadeMinima-$idadeMaxima anos). Ano: $anoMinimoPermitido a $anoMaximoPermitido.";
      }
    } catch (e) {
      return "Data inválida";
    }

    return null;
  }

  String? validarEmail(String? email) {
    if (email == null || email.trim().isEmpty) {
      return "Este campo é obrigatório";
    }
    String pattern =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    RegExp regExp = RegExp(pattern);
    if (!regExp.hasMatch(email)) {
      return "Formato de e-mail inválido";
    }
    return null;
  }

  String? validarSenha(String? senha) {
    if (senha == null || senha.isEmpty) {
      return "Este campo é obrigatório";
    }
    if (senha.length < 8) {
      return "A senha deve ter pelo menos 8 caracteres";
    }
    if (!senha.contains(RegExp(r'[A-Z]'))) {
      return "Deve conter pelo menos uma letra maiúscula";
    }
    if (!senha.contains(RegExp(r'[0-9]'))) {
      return "Deve conter pelo menos um número";
    }
    if (!senha.contains(RegExp(r'[!@#\$%&*]'))) {
      return "Deve conter pelo menos um caractere especial Ex: !@#\$%&*";
    }
    return null;
  }

  String? validarConfirmarSenha(String? confirmarSenha, String senha) {
    if (confirmarSenha == null || confirmarSenha.isEmpty) {
      return "Este campo é obrigatório";
    }
    if (confirmarSenha != senha) {
      return "As senhas não conferem";
    }
    return null;
  }

  String? validarNovaSenhaOpcional(String? senha) {
    if (senha == null || senha.isEmpty) {
      return null;
    }
    return validarSenha(senha);
  }

  String? validarConfirmarNovaSenha(String? confirmarSenha, String novaSenha) {
    if (novaSenha.isEmpty &&
        (confirmarSenha == null || confirmarSenha.isEmpty)) {
      return null;
    }
    if (novaSenha.isNotEmpty &&
        (confirmarSenha == null || confirmarSenha.isEmpty)) {
      return "Confirme a nova senha";
    }

    if (confirmarSenha != novaSenha) {
      return "As senhas não conferem";
    }
    return null;
  }
}
