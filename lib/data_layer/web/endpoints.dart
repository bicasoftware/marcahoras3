class EndPoints {
  const EndPoints();

  static const String handshake = 'handshake';

  /// Auth
  static const String _auth = 'auth';
  static const String register = '$_auth/register';
  static const String login = '$_auth/login';

  /// Empregos
  static const String empregos = 'empregos';
  static const String deleteEmpregos = '$empregos/{ID}';

  /// Salários
  static const String salarios = 'salarios';
  static const String deleteSalario = '$salarios/{ID}';

  /// Horas
  static const String horas = 'horas';
  static const String deleteHoras = '$horas/{ID}';
  
  /// Diferenciais
  static const String diferenciais = 'diferenciais';
  static const String diferenciaisPatchDel = '$diferenciais/{ID}';
  static const String diferenciaisMany = '$diferenciais/many';

  /// Hora Fixo
  static const String horafixo = 'hora-fixo';
  static const String horafixoPatchDel = '$horafixo/{ID}';
}
  
