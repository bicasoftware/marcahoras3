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
  String get feriado => "Holiday";

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

  @override
  List<String> get months => [
        'Janeiro',
        'Fevereiro',
        'Março',
        'Abril',
        'Maio',
        'Junho',
        'Julho',
        'Agosto',
        'Setembro',
        'Outubro',
        'Novembro',
        'Desembro',
      ];

  @override
  String get empregos => "Jobs";

  @override
  String get horas => "Overtime";

  @override
  String get defaultErro => "Error";

  @override
  String get fechar => "Close";

  @override
  String get carregando => "Wait a moment...";

  @override
  String get adicionarEmprego => "Click on + button";

  @override
  String get empregosEmpty => "No Occupation Added";

  @override
  String get editarEmprego => "Edit Occupation";

  @override
  String get editarSalario => "Edit Salary";

  @override
  String get novoEmprego => "New Occupation";

  @override
  String get descricaoEmprego => "Occupation Name";

  @override
  String get emprego => "Occupation";

  @override
  String get bancoHoras => "Unpaid Overtime";

  @override
  String get salario => "Salary";

  @override
  String get valorSalario => "Salary value";

  @override
  String get salvar => "Done!";

  @override
  String get cargaHoraria => "Monthly worked hours";

  @override
  String get cargaHorariaAbrev => "Wkd. Hours";

  @override
  String get admissao => "Starting Date";

  @override
  String get ativo => "Active";
  @override
  String get inativo => "Inactive";

  @override
  String get porcNormal => "% Normal";

  @override
  String get porcFeriado => "% Holidays";

  @override
  String get editar => "Editar";

  @override
  String get recebiAumento => "Recebi um Aumento";

  @override
  String get alterarValor => "Alterar Valor";

  @override
  String get vigencia => "Vigencia";
  @override
  String get addAumento => "Add new raise";
  @override
  String get cancelar => "Cancel";
  @override
  String get confirmar => "Confirm";
  @override
  String get calendario => "Calendário";

  @override
  String get ate => "To";

  @override
  String get das => "From";

  @override
  String get data => "Date";

  @override
  String get editHoraReplace => "Overtime at Day: {DATA}";

  @override
  String get novahora => "Add Overtime";

  @override
  String get pagas => "Paid";

  @override
  String get horasTrabalhadas => "Worked Hours";

  @override
  String get valorReceber => "Value to be paid";

  @override
  String get feriados => "Holidays";

  @override
  String get normais => "Regular";

  @override
  String get porcentagem => "Percentage";

  @override
  String get valorHora => "Overtime value";
  
  @override
  String get horasExtras => "Overtime";
}
