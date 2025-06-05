import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain_layer/models.dart';
import '../../../domain_layer/usecases.dart';
import '../../../features/relatorio/report_page_generator.dart';
import '../../../utils.dart';
import 'home_state.dart';

/// Class that holds presentation data to be shown in the first screen the app renders
class HomeBloc extends Cubit<HomeState> {
  EmpregoDataLoadUseCase _loadEmpregos;
  EmpregoDeleteUseCase _empregoDeleteUseCase;
  HorasLoadByRangeUseCase _horasLoadByRangeUseCase;
  HorasCreateUseCase _horasCreateUsecase;
  HorasUpdateUseCase _horasUpdateUseCase;
  HorasDeleteUseCase _horasDeleteUseCase;

  CalendarPageGeneratorUseCase _calendarPageGeneratorUseCase;

  HomeBloc({
    required EmpregoDataLoadUseCase empregoDataLoadUseCase,
    required EmpregoDeleteUseCase empregoDeleteUseCase,
    required HorasLoadByRangeUseCase horasLoadByRangeUseCase,
    required HorasCreateUseCase horasCreateUsecase,
    required HorasUpdateUseCase horasUpdateUseCase,
    required HorasDeleteUseCase horasDeleteUseCase,
    required int year,
    required int month,
  }) : _loadEmpregos = empregoDataLoadUseCase,
       _empregoDeleteUseCase = empregoDeleteUseCase,
       _calendarPageGeneratorUseCase = CalendarPageGeneratorUseCase(),
       _horasLoadByRangeUseCase = horasLoadByRangeUseCase,
       _horasCreateUsecase = horasCreateUsecase,
       _horasUpdateUseCase = horasUpdateUseCase,
       _horasDeleteUseCase = horasDeleteUseCase,
       super(
         HomeState(
           status: StateLoadingStatus(),
           month: month,
           year: year,
           calendarPage: CalendarPageModel(month: month, year: year),
           reportPage: ReportModel(year: year, month: month),
         ),
       );

  Future<(CalendarPageModel calendarPage, ReportModel reportPage)> _buildPages({
    required Empregos emprego,
    required int mes,
    required int ano,
    required List<Horas> horas,
  }) async {

    final salario = emprego.getSalarioByVigencia(ano, mes);

    final calendarPage = await _calendarPageGeneratorUseCase(
      horas: horas,
      month: mes,
      year: ano,
      admissao: emprego.admissao!,
      bancoHoras: emprego.bancoHoras,
    );

    final reportPage = await ReportPageGenerator(
      year: ano,
      month: mes,
      bancoHoras: emprego.bancoHoras,
      cargaHoraria: emprego.cargaHoraria,
      porcNormal: emprego.porcNormal,
      porcFeriado: emprego.porcFeriado,
      salario: salario,
      horas: horas,
      valorFixo: emprego.getValorFixoByVigencia(ano, mes),
      diferenciais: emprego.diferenciaisList,
    ).generate();

    return (calendarPage, reportPage);
  }

  Future<List<Horas>> _listHoras({
    required int year,
    required int month,
    required String empregoId,
  }) async {
    final (initDate, endDate) = getFormatedDateRange(year, month);
    return await _horasLoadByRangeUseCase(empregoId, initDate, endDate);
  }

  Future<void> load() async {
    try {
      emit(state.copyWith(status: StateLoadingStatus()));

      final (from, to) = getFormatedDateRange(state.year, state.month);
      final empregos = await _loadEmpregos(from, to);

      CalendarPageModel? calendarPage;
      ReportModel? reportPage;

      if (empregos.isNotEmpty) {
        final emprego = empregos[0];
        final (c, r) = await _buildPages(
          emprego: emprego,
          mes: state.month,
          ano: state.year,
          horas: emprego.horas,
        );

        calendarPage = c;
        reportPage = r;
      }

      emit(
        state.copyWith(
          empregos: empregos,
          status: StateSuccessStatus(),
          empregoPos: 0,
          calendarPage: calendarPage,
          reportPage: reportPage,
        ),
      );
    } on Exception catch (e) {
      emit(state.copyWith(status: StateErrorStatus(errorMsg: e.toString())));

      rethrow;
    }
  }

  Future<void> deleteCurrentEmprego() async {
    try {
      emit(state.copyWith(status: StateLoadingStatus()));
      final emprego = state.currentEmprego;

      /// Deletes [Emprego] from server
      await _empregoDeleteUseCase(emprego.id!);

      /// Creates a new list of [Empregos] and remove the deleted emprego
      final empregosList = [...state.empregos];
      empregosList.remove(emprego);

      final e = empregosList.first;
      final (calendarPage, reportPage) = await _buildPages(
        emprego: e,
        mes: state.month,
        ano: state.year,
        horas: e.horas,
      );

      /// Finally emits a new state with the new [Salarios] list
      emit(
        state.copyWith(
          status: StateSuccessStatus(),
          empregos: empregosList,
          empregoPos: empregosList.isNotEmpty ? 0 : -1,
          calendarPage: calendarPage,
          reportPage: reportPage,
        ),
      );
    } on Exception catch (e) {
      emit(state.copyWith(status: StateErrorStatus(errorMsg: e.toString())));

      rethrow;
    }
  }

  /// Method called when a user is deemed invalid
  /// It should clean every possible data existing in the app
  /// databases, Blocs, files, whatever is required for it to be a full new session.
  Future<void> clean() async {
    try {
      emit(state.copyWith(status: StateLoadingStatus()));

      emit(state.copyWith(empregos: [], status: StateSuccessStatus()));
    } on Exception catch (e) {
      emit(state.copyWith(status: StateErrorStatus(errorMsg: e.toString())));

      rethrow;
    }
  }

  void setEmpregoPos(Empregos e) async {
    final index = state.empregos.indexOf(e);    
    final now = DateTime.now();

    /// Se a data de admissão for antes da data atual
    final (int year, int month) = e.admissao!.isBefore(now)
        ? (now.year, now.month)
        : (e.admissao!.year, e.admissao!.month);

    await _updateCalendar(year, month, e, index);
  }

  void incMonth() async {
    state.month == 12
        ? await _updateCalendar(state.year + 1, 1)
        : await _updateCalendar(state.year, state.month + 1);
  }

  void decMonth() async {
    state.month == 1
        ? await _updateCalendar(state.year - 1, 12)
        : await _updateCalendar(state.year, state.month - 1);
  }

  void setMonth(int month) async {
    await _updateCalendar(state.year, month + 1);
  }

  void setYear(int newYear) async {
    await _updateCalendar(newYear, state.month);
  }

  Future<void> _updateCalendar(
    int year,
    int month, [
    Empregos? emprego,
    int? empregoPos,
  ]) async {
    emit(state.copyWith(status: StateLoadingStatus()));

    final currentEmprego = emprego ?? state.currentEmprego;

    /// If the user tryes to go to a month before the date when they started working
    /// exit the function, so nothing changes
    if (!_validNewVigencia(year, month, currentEmprego.admissao!)) return;

    try {
      final horasList = await _listHoras(
        year: year,
        month: month,
        empregoId: currentEmprego.id!,
      );

      final (calendarPage, reportPage) = await _buildPages(
        emprego: currentEmprego,
        ano: year,
        mes: month,
        horas: horasList,
      );

      final empregosList = [...state.empregos];
      empregosList[empregoPos ?? state.empregoPos] = currentEmprego.copyWith(
        horas: [...currentEmprego.horas, ...horasList],
      );

      emit(
        state.copyWith(
          status: StateSuccessStatus(),
          year: year,
          month: month,
          empregos: empregosList,
          empregoPos: empregoPos ?? state.empregoPos,
          calendarPage: calendarPage,
          reportPage: reportPage,
        ),
      );
    } on Exception catch (e) {
      emit(state.copyWith(status: StateErrorStatus(errorMsg: e.toString())));

      rethrow;
    }
  }

  Future<void> insertHora(Horas hora) async {
    try {
      emit(state.copyWith(status: StateLoadingStatus()));

      /// Insert the new [Horas] model
      await _horasCreateUsecase(hora);

      final horasList = await _listHoras(
        year: state.year,
        month: state.month,
        empregoId: state.currentEmprego.id!,
      );

      final (calendarPage, reportPage) = await _buildPages(
        emprego: state.currentEmprego,
        mes: state.month,
        ano: state.year,
        horas: horasList,
      );

      final updatedEmprego = state.currentEmprego.copyWith(horas: horasList);

      final empregosList = state.empregos.iCopy().iUpdateAt(
        updatedEmprego,
        state.empregoPos,
      );

      emit(
        state.copyWith(
          status: StateSuccessStatus(),
          empregos: empregosList,
          reportPage: reportPage,
          calendarPage: calendarPage,
        ),
      );
    } on Exception catch (e) {
      emit(state.copyWith(status: StateErrorStatus(errorMsg: e.toString())));

      rethrow;
    }
  }

  Future<void> updateHora(Horas hora) async {
    if (hora.id == null) return;

    try {
      emit(state.copyWith(status: StateLoadingStatus()));

      /// Update the previous [Horas] model
      await _horasUpdateUseCase(hora);

      final horasList = await _listHoras(
        year: state.year,
        month: state.month,
        empregoId: state.currentEmprego.id!,
      );

      final (calendarPage, reportPage) = await _buildPages(
        emprego: state.currentEmprego,
        mes: state.month,
        ano: state.year,
        horas: horasList,
      );

      final updatedEmprego = state.currentEmprego.copyWith(horas: horasList);

      final empregosList = state.empregos.iUpdateAt(
        updatedEmprego,
        state.empregoPos,
      );

      emit(
        state.copyWith(
          status: StateSuccessStatus(),
          empregos: empregosList,
          reportPage: reportPage,
          calendarPage: calendarPage,
        ),
      );
    } on Exception catch (e) {
      emit(state.copyWith(status: StateErrorStatus(errorMsg: e.toString())));

      rethrow;
    }
  }

  Future<void> deleteHora(Horas hora) async {
    try {
      emit(state.copyWith(status: StateLoadingStatus()));

      /// Update the previous [Horas] model
      await _horasDeleteUseCase(hora);

      final horasList = await _listHoras(
        year: state.year,
        month: state.month,
        empregoId: state.currentEmprego.id!,
      );

      final (calendarPage, reportPage) = await _buildPages(
        emprego: state.currentEmprego,
        mes: state.month,
        ano: state.year,
        horas: horasList,
      );

      final updatedEmprego = state.currentEmprego.copyWith(horas: horasList);

      final empregosList = state.empregos.iCopy().iUpdateAt(
        updatedEmprego,
        state.empregoPos,
      );

      emit(
        state.copyWith(
          status: StateSuccessStatus(),
          empregos: empregosList,
          calendarPage: calendarPage,
          reportPage: reportPage,
        ),
      );
    } on Exception catch (e) {
      emit(state.copyWith(status: StateErrorStatus(errorMsg: e.toString())));

      rethrow;
    }
  }

  Future<void> burnHora(Horas hora) async {
    return await updateHora(hora.copyWith(horaStatus: HoraStatus.burned));
  }

  bool _validNewVigencia(int year, int month, DateTime admissao) {
    final newDate = DateTime(year, month, admissao.day);
    return newDate.isSameDayOrAfter(admissao);
  }
}
