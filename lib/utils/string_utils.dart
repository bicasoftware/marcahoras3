extension StringsHelper on String {
  String toCamelCase() {
    final splitString = this.split(' ');
    String result = '';

    splitString.forEach((s) {
      result += "${s[0].toUpperCase()}${s.substring(1, s.length)} ";
    });

    return result;
  }
}
