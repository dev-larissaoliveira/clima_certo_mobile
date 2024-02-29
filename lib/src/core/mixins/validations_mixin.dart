mixin ValidationsMixin {
  String? isNotEmpty(String? value, [String? message]) {
    if (value!.isEmpty) {
      return message ?? "Este campo é obrigatório";
    }

    return null;
  }

  String? isValidEmail(String? value, [String? message]) {
    final RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!emailRegex.hasMatch(value!))
      return message ?? "Formato de e-mail inválido";

    return null;
  }

  String? combine(List<String? Function()> validators) {
    for (final func in validators) {
      final validation = func();

      if (validation != null) return validation;
    }

    return null;
  }

  String? hasEightChars(String? value, [String? message]) {
    if (value!.length < 8)
      return message ?? "Você deve inserir pelo menos 8 caracteres.";

    return null;
  }

  String? passwordsMatch(String? password, String? confirmPassword,
      [String? message]) {
    if (password != confirmPassword)
      return message ?? "As senhas não coincidem";

    return null;
  }
}
