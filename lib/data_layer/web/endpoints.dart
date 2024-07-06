class EndPoints {
  const EndPoints();

  static const String handshake = 'handshake';

  static const String _auth = 'auth/';
  static const String register = '$_auth/register';
  static const String login = '$_auth/login';

  static const String empregos = 'empregos';
  static const String deleteEmpregos = 'empregos/{ID}';

  static const String salarios = 'salarios';
  static const String deleteSalario = '$salarios/{ID}';

  static const String horas = 'horas';
  static const String deleteHoras = '$horas/{ID}';
}
