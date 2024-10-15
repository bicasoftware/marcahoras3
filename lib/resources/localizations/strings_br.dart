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
  String get feriado => 'Feriado';
  @override
  String get valueAtLeastNCharacter =>
      'O texto precisa ter ao menos {N} letras!';

  @override
  List<String> get weekDays => [
        'dom',
        'seg',
        'ter',
        'qua',
        'qui',
        'sex',
        'sab',
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
        'Dezembro',
      ];

  @override
  String get defaultErro => "Erro";

  @override
  String get fechar => "Fechar";

  @override
  String get carregando => "Um momento...";

  @override
  String get empregosEmpty => "Nenhum emprego adicionado.";
  @override
  String get adicionarEmprego => "Adicionar";

  @override
  String get editarEmprego => "Editar Emprego";

  @override
  String get editarSalario => "Editar Salário";

  @override
  String get novoEmprego => "Novo Emprego";

  @override
  String get descricaoEmprego => "Descrição";

  @override
  String get emprego => "Emprego";

  @override
  String get bancoHoras => "Banco de Horas";

  @override
  String get salario => "Salário";

  @override
  String get valorSalario => "Valor Salário";

  @override
  String get salvar => "Salvar";

  @override
  String get cargaHoraria => "Carga Horária Mensal";

  @override
  String get admissao => "Admissão";

  @override
  String get ativo => "Ativo";

  @override
  String get inativo => "Inativo";

  @override
  String get porcNormal => "Normal";

  @override
  String get porcFeriado => "Feriado";

  @override
  String get editar => "Editar";

  @override
  String get recebiAumento => "Recebi um Aumento";

  @override
  String get alterarValor => "Alterar Valor";

  @override
  String get vigencia => "Vigencia";

  @override
  String get addAumento => "Adicionar Aumento";

  @override
  String get cancelar => "Cancelar";

  @override
  String get confirmar => "Confirmar";

  @override
  String get calendario => "Calendário";

  @override
  String get ate => "Até";

  @override
  String get das => "Das";

  @override
  String get data => "Data";

  @override
  String get editHoraReplace => "Hora Extra Dia: {DATA}";

  @override  
  String get novahora => "Nova Hora Extra";
}
