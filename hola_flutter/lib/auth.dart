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
}
