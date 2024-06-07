import 'strings.dart';

class EnStrings implements StringsContract {
  const EnStrings();

  @override
  String get appDescription => "Overtime Organizer";

  @override
  String get appName => "Marcaii";

  @override
  String get continuar => "Continue";

  @override
  String get email => "E-mail";

  @override
  String get emailInvalid => "Input E-mail is not valid";

  @override
  String get entradas => "Enter";

  @override
  String get horaFeriado => "Holiday overtime";

  @override
  String get horaNormal => "Regular days overtime";

  @override
  String get jaTenhoCadastro => "I Already have a login";

  @override
  String get naoTenhoCadastro => "I don't have a login, tap here";

  @override
  String get password => "Password";

  @override
  String get passwordMustMatch => "Both passwords must match";

  @override
  String get passwordMustNotBeEmpty => "Password field must be filled";

  @override
  String get relatorios => "Reports";

  @override
  String get repeatPassword => "Repeat password";

  @override
  String get tentar => "Try";

  @override
  String get tipoHora => "Overtime type";

  @override
  String get typeConfirmPass => "Type password confirmation";

  @override
  String get typeEmail => "Type e-mail";

  @override
  String get typePass => "Type password";

  @override
  String get valueAtLeastNCharacter =>
      "The text must be at least {N} characters";

  @override
  String get valueCantBeEmpty => "Input value can't be empty";

  @override
  String get verTodas => "see all";

  @override
  List<String> get weekDays => [
        "SUN",
        "MON",
        "TUE",
        "WEN",
        "THU",
        "FRY",
        "SAT",
      ];
}