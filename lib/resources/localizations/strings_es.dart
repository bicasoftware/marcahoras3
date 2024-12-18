import 'strings.dart';

class EsStrings implements StringsContract {
  const EsStrings();

  @override
  String get appName => 'MarcaHora';
  @override
  String get appDescription => 'Organizador de Horas Extras';
  @override
  String get continuar => 'Continuar';
  @override
  String get empregos => 'Empleos';
  @override
  String get horas => 'Horas';
  @override
  String get jaTenhoCadastro => '¿Ya tienes una cuenta? Haz clic para iniciar sesión.';
  @override
  String get naoTenhoCadastro => '¿No tienes una cuenta? Haz clic para crear una.';
  @override
  String get tentar => 'Intentar de nuevo';
  @override
  String get entradas => 'Entradas';
  @override
  String get relatorios => 'Informes';
  @override
  String get horaNormal => 'Normal';
  @override
  String get horaFeriado => 'Feriado/Domingo';
  @override
  String get tipoHora => 'Tipo de Hora';
  @override
  String get verTodas => 'Ver Horas';
  @override
  String get email => 'Correo electrónico';
  @override
  String get password => 'Contraseña';
  @override
  String get repeatPassword => 'Repite la contraseña:';
  @override
  String get typeEmail => 'Ingresa tu correo electrónico:';
  @override
  String get typePass => 'Ingresa tu contraseña:';
  @override
  String get typeConfirmPass => 'Confirma tu contraseña:';
  @override
  String get emailInvalid => '¡El correo electrónico ingresado no es válido!';
  @override
  String get passwordMustMatch => '¡Las contraseñas deben coincidir!';
  @override
  String get passwordMustNotBeEmpty => '¡Las contraseñas no pueden estar vacías!';
  @override
  String get valueCantBeEmpty => '¡El texto no puede estar vacío!';
  @override
  String get feriado => 'Feriado';
  @override
  String get valueAtLeastNCharacter =>
      '¡El texto debe tener al menos {N} letras!';

  @override
  List<String> get weekDays => [
        'dom',
        'lun',
        'mar',
        'mié',
        'jue',
        'vie',
        'sáb',
      ];

  @override
  List<String> get months => [
        'Enero',
        'Febrero',
        'Marzo',
        'Abril',
        'Mayo',
        'Junio',
        'Julio',
        'Agosto',
        'Septiembre',
        'Octubre',
        'Noviembre',
        'Diciembre',
      ];

  @override
  String get defaultErro => "Error";

  @override
  String get fechar => "Cerrar";

  @override
  String get carregando => "Un momento...";

  @override
  String get empregosEmpty => "No se agregaron empleos.";
  @override
  String get adicionarEmprego => "Agregar";

  @override
  String get editarEmprego => "Editar Empleo";

  @override
  String get editarSalario => "Editar Salario";

  @override
  String get novoEmprego => "Nuevo Empleo";

  @override
  String get descricaoEmprego => "Descripción";

  @override
  String get emprego => "Empleo";

  @override
  String get bancoHoras => "Banco de Horas";

  @override
  String get salario => "Salario";

  @override
  String get valorSalario => "Valor Salario";

  @override
  String get salvar => "Guardar";

  @override
  String get cargaHoraria => "Carga Horaria Mensual";

  @override
  String get cargaHorariaAbrev => "C. Horaria";

  @override
  String get admissao => "Admisión";

  @override
  String get ativo => "Activo";

  @override
  String get inativo => "Inactivo";

  @override
  String get porcNormal => "Extra Normal";

  @override
  String get porcFeriado => "Extra Feriado";

  @override
  String get editar => "Editar";

  @override
  String get recebiAumento => "Recibí un Aumento";

  @override
  String get alterarValor => "Cambiar Valor";

  @override
  String get vigencia => "Vigencia";

  @override
  String get addAumento => "Agregar Aumento";

  @override
  String get cancelar => "Cancelar";

  @override
  String get confirmar => "Confirmar";

  @override
  String get calendario => "Calendario";

  @override
  String get ate => "Hasta";

  @override
  String get das => "De las";

  @override
  String get data => "Fecha";

  @override
  String get editHoraReplace => "Hora Extra Día: {DATA}";

  @override
  String get novahora => "Nueva Hora Extra";

  @override
  String get pagas => "Pagadas";

  @override
  String get horasTrabalhadas => "Horas Trabajadas";

  @override
  String get valorReceber => "Valor a recibir";

  @override
  String get feriados => "Feriados";

  @override
  String get normais => "Normales";

  @override
  String get porcentagem => "Porcentaje";

  @override
  String get valorHora => "Valor Hora";

  @override
  String get horasExtras => "Horas Extras";

  @override
  String get back => "Volver";

  @override
  String get next => "Adelante";

  @override
  String get welcomeTitle => '¡Bienvenido a $appName!';

  @override
  String get welcomeMessage => 'Aquí puedes registrar y organizar tus horas extras.';

  @override
  String get welcomeJobDescription => 'Primero dime... ¿En qué trabajas?';

  @override
  String get welcomeJobDescriptionMessage => 'Proporciona una breve descripción de tu puesto actual.';

  @override
  String get welcomeCargaHoraria => '¿Cuál es tu carga horaria mensual?';

  @override
  String get welcomeCargaHorariaMessage => 'Elige una de las opciones:';

  @override
  String get welcomeSalario => '¿Cuánto ganas actualmente?';

  @override
  String get welcomeSalarioMessage => 'Ingresa el valor, usando solo números.';

  @override
  String get welcomeAdmissao => '¿Qué día empezaste a trabajar?';

  @override
  String get welcomeAdmissaoMessage => 'Por favor, selecciona una fecha en el calendario:';

  @override
  String get welcomePorcNormal => '¿Qué porcentaje extra recibes durante los días laborales?';

  @override
  String get welcomePorcNormalMessage => 'Por ley, el mínimo posible es 50%. Por favor, indica el valor en %.';

  @override
  String get welcomePorcFeriado => '¿Qué porcentaje extra recibes durante Feriados y Domingos?';

  @override
  String get welcomePorcFeriadoMessage => 'Por ley, el mínimo posible es 50%. Por favor, indica el valor en %.';
}
