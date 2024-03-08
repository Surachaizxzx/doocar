// ignore: file_names
mixin AuthToken {
  static String? token;

  static bool isLoggedIn() {
    return token != null;
  }
}
