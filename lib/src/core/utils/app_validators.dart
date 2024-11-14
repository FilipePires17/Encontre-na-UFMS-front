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

  static String? phoneValidator(String? phone) {
    if (phone != null && !RegExp(r'^\d{10,11}$').hasMatch(phone)) {
      return 'Telefone inválido, verifique se há o DDD';
    }
    return null;
  }

  static String? hourValidator(String? time) {
    if (time == null) return null;
    if (!RegExp(r'^\d{2}:\d{2}$').hasMatch(time)) {
      return 'Hora inválida';
    }
    final timeSplit = time.split(':');
    if (int.parse(timeSplit[0]) > 23 || int.parse(timeSplit[1]) > 59) {
      return 'Hora inválida';
    }
    return null;
  }
}
