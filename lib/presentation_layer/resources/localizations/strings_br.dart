import 'strings.dart';

class BrStrings implements StringsContract {
  const BrStrings();

  @override
  String get appName => 'MarcaHora';
  @override
  String get appDescription => 'Organizador de Horas Extras';
  @override
  String get continuar => 'Continuar';
  @override
  String get empregos => 'Empregos';
  @override
  String get horas => 'Horas';
  @override
  String get jaTenhoCadastro => 'Já Tem uma conta? Clique para entrar.';
  @override
  String get naoTenhoCadastro => 'Não Tem uma conta? Clique para criar.';
  @override
  String get tentar => 'Tentar novamente';
  @override
  String get entradas => 'Entradas';
  @override
  String get relatorios => 'Relatórios';
  @override
  String get horaNormal => 'Normal';
  @override
  String get horaFeriado => 'Feriado/Domingo';
  @override
  String get tipoHora => 'Tipo de Hora';
  @override
  String get verTodas => 'Ver Horas';
  @override
  String get email => 'Email';
  @override
  String get password => 'Senha';
  @override
  String get repeatPassword => 'Digite a senha novamente:';
  @override
  String get typeEmail => 'Digite seu email:';
  @override
  String get typePass => 'Digite sua senha:';
  @override
  String get typeConfirmPass => 'Confirme sua senha:';
  @override
  String get emailInvalid => 'Email adicionado é inválido!';
  @override
  String get passwordMustMatch => 'As senhas devem ser iguais!';
  @override
  String get passwordMustNotBeEmpty => 'As senhas não podem estar em branco!';
  @override
  String get valueCantBeEmpty => 'O texto não pode estar vazio!';
  @override
  String get valueAtLeastNCharacter =>
      'O texto precisa ter ao menos {N} letras!';

  @override
  List<String> get weekDays => [
        'seg',
        'ter',
        'qua',
        'qui',
        'sex',
        'sab',
        'dom',
      ];
}
