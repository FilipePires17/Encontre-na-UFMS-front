class AppValidators {
  static String? emailValidator(String? email) {
    return checkField(email) ?? isValidEmailFormat(email!);
  }

  static String? passwordValidator(String? password) {
    return checkField(password) ?? hasRightAmountOfChar(password!);
  }

  static String? confirmPasswordValidator(
      String? password, String? passwordConfirmation) {
    if (password == passwordConfirmation && passwordConfirmation != null) {
      return null;
    }
    return 'As senhas não são iguais';
  }

  static String? isValidEmailFormat(String email) {
    if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email)) {
      return 'E-mail inválido';
    }
    return null;
  }

  static String? checkField(input) {
    if (input == null || input.isEmpty) {
      return 'Campo obrigatório';
    }
    return null;
  }

  static String? hasRightAmountOfChar(String input) {
    if (input.length < 6) {
      return 'A senha deve ter pelo menos 6 caracteres';
    }
    return null;
  }
}
