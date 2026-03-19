class UserRepository {
  static String? name;
  static String? surname;
  static String? email;
  static String? password;
  static String? sex;

  static bool isRegistered() {
    return email != null && password != null;
  }

  static void register({required String name_, required String surname_, required String email_, required String password_, required String sex_}) {
    name = name_;
    surname = surname_;
    email = email_;
    password = password_;
    sex = sex_;
  }

  static bool validate(String email_, String password_) {
    if (!isRegistered()) return false;
    return email == email_ && password == password_;
  }

  static void clear() {
    name = null;
    surname = null;
    email = null;
    password = null;
    sex = null;
  }

  // Validaciones reutilizables
  static bool isNameValid(String value) {
    final v = value.trim();
    if (v.isEmpty) return false;
    final reg = RegExp(r'^[A-Za-zÀ-ÖØ-öø-ÿÑñ\s]+$');
    return reg.hasMatch(v);
  }

  static bool isEmailValid(String value) {
    final v = value.trim();
    return v.contains('@'); // requisito mínimo solicitado
  }

  static bool isPasswordValid(String value) {
    // Mínimo 8, al menos una mayúscula, un número y un símbolo
    final hasUpper = value.contains(RegExp(r'[A-Z]'));
    final hasDigit = value.contains(RegExp(r'\d'));
    final hasSymbol = value.contains(RegExp(r'[^A-Za-z0-9]'));
    final longEnough = value.length >= 8;
    return hasUpper && hasDigit && hasSymbol && longEnough;
  }
}
