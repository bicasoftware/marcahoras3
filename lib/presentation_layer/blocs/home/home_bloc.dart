import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain_layer/models.dart';
import '../../../domain_layer/usecases.dart';
import '../../../features/relatorio/report_page_generator.dart';
import '../../../utils/utils.dart';
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
       super(HomeState(status: StateLoadingStatus(), month: month, year: year));

  Future<void> load() async {
    try {
      emit(state.copyWith(status: StateLoadingStatus()));

      final (from, to) = getFormatedDateRange(state.year, state.month);
      final empregos = await _loadEmpregos(from, to);

      empregos.forEachIndexed((i, e) async {
        final calendarPage = await _calendarPageGeneratorUseCase(
          horas: e.horas,
          month: state.month,
          year: state.year,
          admissao: e.admissao!,
        );

        final reportPage =
            await ReportPageGenerator(
              year: state.year,
              month: state.month,
              bancoHoras: e.bancoHoras,
              cargaHoraria: e.cargaHoraria,
              porcNormal: e.porcNormal,
              porcDiff: e.porcFeriado,
              salario: state.getSalarioByVigencia(state.year, state.month),
              horas: e.horas,
            ).generate();

        empregos[i] = empregos[i].copyWith(
          calendarPages: [calendarPage],
          reportPages: [reportPage],
        );
      });

      emit(
        state.copyWith(
          empregos: empregos,
          status: StateSuccessStatus(),
          empregoPos: empregos.length == 0 ? -1 : 0,
        ),
      );
    } on Exception catch (e) {
      emit(state.copyWith(status: StateErrorStatus(errorMsg: e.toString())));

      rethrow;
    }
  }

  Future<void> deleteEmprego(Empregos emprego) async {
    try {
      emit(state.copyWith(status: StateLoadingStatus()));

      /// Deletes [Emprego] from server
      await _empregoDeleteUseCase(emprego.id!);

      /// Creates a new list of [Empregos] and remove the deleted emprego
      final empregosList = [...state.empregos];
      empregosList.remove(emprego);

      /// Finally emits a new state with the new [Salarios] list
      emit(
        state.copyWith(status: StateSuccessStatus(), empregos: empregosList),
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
    ///
    final (int year, int month) =
        e.admissao!.isBefore(now)
            ? (now.year, now.month)
            : (e.admissao!.year, e.admissao!.month);

    await _updateCalendar(year, month, e, index);
  }

  void toggleDarkMode() => emit(state.copyWith(isDarkMode: !state.isDarkMode));

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

    if (state.currentEmprego == null) return;
    final currentEmprego = emprego ?? state.currentEmprego!;

    /// If the user tryes to go to a month before the date when they started working
    /// exit the function, so nothing changes
    if (!_validNewVigencia(year, month, currentEmprego.admissao!)) return;

    try {
      final pageIndex = currentEmprego.calendarPages.indexWhere(
        (it) => it.month == month && it.year == year,
      );

      final reportIndex = currentEmprego.reportPages.indexWhere(
        (it) => it.month == month && it.year == year,
      );

      final (initDate, endDate) = getFormatedDateRange(year, month);

      final List<Horas> horas = await _horasLoadByRangeUseCase(
        currentEmprego.id!,
        initDate,
        endDate,
      );

      final CalendarPageModel? calendarPage =
          pageIndex == -1
              ? await _calendarPageGeneratorUseCase(
                horas: horas,
                month: month,
                year: year,
                admissao: currentEmprego.admissao!,
              )
              : null;

      final ReportModel? reportPage =
          reportIndex == -1
              ? await ReportPageGenerator(
                year: year,
                month: month,
                bancoHoras: currentEmprego.bancoHoras,
                cargaHoraria: currentEmprego.cargaHoraria,
                porcNormal: currentEmprego.porcNormal,
                porcDiff: currentEmprego.porcFeriado,
                salario: state.getSalarioByVigencia(year, month),
                horas: horas,
              ).generate()
              : null;

      final calendarPages =
          calendarPage != null
              ? [...currentEmprego.calendarPages, calendarPage]
              : [...currentEmprego.calendarPages];

      final reportPages =
          reportPage != null
              ? [...currentEmprego.reportPages, reportPage]
              : [...currentEmprego.reportPages];

      final empregosList = [...state.empregos];
      empregosList[empregoPos ?? state.empregoPos] = currentEmprego.copyWith(
        horas: [...currentEmprego.horas, ...horas],
        calendarPages: calendarPages,
        reportPages: reportPages,
      );

      emit(
        state.copyWith(
          status: StateSuccessStatus(),
          year: year,
          month: month,
          empregos: empregosList,
          empregoPos: empregoPos ?? state.empregoPos,
        ),
      );
    } on Exception catch (e) {
      emit(state.copyWith(status: StateErrorStatus(errorMsg: e.toString())));

      rethrow;
    }

    // if (pageIndex == -1 || reportIndex == -1) {
    //   try {
    //     emit(state.copyWith(status: StateLoadingStatus()));
    //     // TODO
    //     final (initDate, endDate) = getFormatedDateRange(year, month);

    //     final List<Horas> horas = await _horasLoadByRangeUseCase(
    //       currentEmprego.id!,
    //       initDate,
    //       endDate,
    //     );

    //     final calendarPage = await _calendarPageGeneratorUseCase(
    //       horas: horas,
    //       month: month,
    //       year: year,
    //       admissao: currentEmprego.admissao!,
    //     );

    //     /// Generates all overtime information needed to be presented in
    //     /// [RelatorioScreen] and in the pdf generation routine
    //     final reportPage = await ReportPageGenerator(
    //       year: year,
    //       month: month,
    //       bancoHoras: currentEmprego.bancoHoras,
    //       cargaHoraria: currentEmprego.cargaHoraria,
    //       porcNormal: currentEmprego.porcNormal,
    //       porcDiff: currentEmprego.porcFeriado,
    //       salario: state.getSalarioByVigencia(year, month),
    //       horas: horas,
    //     ).generate();

    //     final allHoras = <Horas>[...currentEmprego.horas, ...horas];
    //     final pages = [...currentEmprego.calendarPages, calendarPage];
    //     final reportPages = [...currentEmprego.reportPages, reportPage];

    //     final empregosList = [...state.empregos];
    //     empregosList[empregoPos ?? state.empregoPos] = currentEmprego.copyWith(
    //       horas: allHoras,
    //       calendarPages: pages,
    //       reportPages: reportPages,
    //     );

    //     emit(
    //       state.copyWith(
    //         status: StateSuccessStatus(),
    //         year: year,
    //         month: month,
    //         empregos: empregosList,
    //         empregoPos: empregoPos ?? state.empregoPos,
    //       ),
    //     );
    //   } on Exception catch (e) {
    //     emit(
    //       state.copyWith(
    //         status: StateErrorStatus(errorMsg: e.toString()),
    //       ),
    //     );

    //     rethrow;
    //   }
    // } else {
    //   emit(
    //     state.copyWith(
    //       status: StateSuccessStatus(),
    //       year: year,
    //       month: month,
    //       empregoPos: empregoPos ?? state.empregoPos,
    //     ),
    //   );
    // }
  }

  Future<void> insertHora(Horas hora) async {
    if (state.currentEmprego == null) return;

    try {
      emit(state.copyWith(status: StateLoadingStatus()));

      /// Insert the new [Horas] model
      final newHora = await _horasCreateUsecase(hora);

      /// Generates a new list based in the current [Emprego] on state
      final horasList = state.currentEmprego!.horas.iAdd(newHora);

      final newPageItems = state.currentPage().items.iCopy().iUpdateWhere(
        where: (h) => h.date?.isSameDay(newHora.data) ?? false,
        newItem: CalendarItemComplete(
          horas: newHora,
          date: newHora.data,
          isToday: newHora.data.isSameDay(DateTime.now()),
        ),
      );

      ///Generates a copy of the current [CalendarPage]
      final currentPage = state.currentPage().copyWith(
        items: newPageItems,
        horas: horasList,
      );

      final calendarPages = state.currentEmprego!.calendarPages
          .iCopy()
          .iUpdateItem(currentPage, state.currentPage());

      /// Generates a new reportPage
      final reportPage =
          await ReportPageGenerator(
            year: state.year,
            month: state.month,
            bancoHoras: state.currentEmprego!.bancoHoras,
            cargaHoraria: state.currentEmprego!.cargaHoraria,
            porcNormal: state.currentEmprego!.porcNormal,
            porcDiff: state.currentEmprego!.porcFeriado,
            salario: state.getSalarioByVigencia(state.year, state.month),
            horas: horasList,
          ).generate();

      /// Clone the [ReportModel]s,
      /// remove the previous page
      /// Adds the new page to the model
      final reports = state.currentEmprego!.reportPages.iCopy();
      reports.removeWhere(
        (r) => r.year == state.year && r.month == state.month,
      );

      reports.add(reportPage);

      final updatedEmprego = state.currentEmprego!.copyWith(
        horas: horasList,
        calendarPages: calendarPages,
        reportPages: reports,
      );

      final empregosList = state.empregos.iCopy().iUpdateAt(
        updatedEmprego,
        state.empregoPos,
      );

      emit(
        state.copyWith(status: StateSuccessStatus(), empregos: empregosList),
      );
    } on Exception catch (e) {
      emit(state.copyWith(status: StateErrorStatus(errorMsg: e.toString())));

      rethrow;
    }
  }

  Future<void> updateHora(Horas hora) async {
    assert(state.currentEmprego != null);
    assert(hora.id != null);
    assert(hora.empregoId.isNotEmpty);

    try {
      emit(state.copyWith(status: StateLoadingStatus()));

      /// Update the previous [Horas] model
      final updatedHora = await _horasUpdateUseCase(hora);

      /// Generates a new list based in the current [Emprego] on state
      final horasList = state.currentEmprego!.horas.iCopy().iUpdateWhere(
        newItem: updatedHora,
        where: (Horas h) => h.id == hora.id!,
      );

      final newPageItems = state.currentPage().items.iCopy().iUpdateWhere(
        where: (h) => h.date?.isSameDay(updatedHora.data) ?? false,
        newItem: CalendarItemComplete(
          horas: updatedHora,
          date: updatedHora.data,
          isToday: updatedHora.data.isSameDay(DateTime.now()),
        ),
      );

      ///Generates a copy of the current [CalendarPage]
      final currentPage = state.currentPage().copyWith(
        items: newPageItems,
        horas: horasList,
      );

      final calendarPages = state.currentEmprego!.calendarPages
          .iCopy()
          .iUpdateItem(currentPage, state.currentPage());

      /// Generates a new reportPage
      final reportPage =
          await ReportPageGenerator(
            year: state.year,
            month: state.month,
            bancoHoras: state.currentEmprego!.bancoHoras,
            cargaHoraria: state.currentEmprego!.cargaHoraria,
            porcNormal: state.currentEmprego!.porcNormal,
            porcDiff: state.currentEmprego!.porcFeriado,
            salario: state.getSalarioByVigencia(state.year, state.month),
            horas: horasList,
          ).generate();

      /// Clone the [ReportModel]s,
      /// remove the previous page
      /// Adds the new page to the model
      final reports = state.currentEmprego!.reportPages.iCopy();
      reports.removeWhere(
        (r) => r.year == state.year && r.month == state.month,
      );

      reports.add(reportPage);

      final updatedEmprego = state.currentEmprego!.copyWith(
        horas: horasList,
        calendarPages: calendarPages,
        reportPages: reports,
      );

      final empregosList = state.empregos.iCopy().iUpdateAt(
        updatedEmprego,
        state.empregoPos,
      );

      emit(
        state.copyWith(status: StateSuccessStatus(), empregos: empregosList),
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

      /// Creates a new list without the delete [Horas] on state
      final horasList = state.currentEmprego!.horas.iCopy().iDelete(hora);

      final newPageItems = state.currentPage().items.iCopy().iUpdateWhere(
        where: (h) => h.date?.isSameDay(hora.data) ?? false,
        newItem: CalendarItemDateOnly(
          hora.data,
          hora.data.isSameDay(DateTime.now()),
        ),
      );

      ///Generates a copy of the current [CalendarPage]
      final currentPage = state.currentPage().copyWith(
        items: newPageItems,
        horas: horasList,
      );

      final calendarPages = state.currentEmprego!.calendarPages
          .iCopy()
          .iUpdateItem(currentPage, state.currentPage());

      /// Generates a new reportPage
      final reportPage =
          await ReportPageGenerator(
            year: state.year,
            month: state.month,
            bancoHoras: state.currentEmprego!.bancoHoras,
            cargaHoraria: state.currentEmprego!.cargaHoraria,
            porcNormal: state.currentEmprego!.porcNormal,
            porcDiff: state.currentEmprego!.porcFeriado,
            salario: state.getSalarioByVigencia(state.year, state.month),
            horas: horasList,
          ).generate();

      /// Clone the [ReportModel]s,
      /// remove the previous page
      /// Adds the new page to the model
      final reports = state.currentEmprego!.reportPages.iCopy();
      reports.removeWhere(
        (r) => r.year == state.year && r.month == state.month,
      );

      reports.add(reportPage);

      final updatedEmprego = state.currentEmprego!.copyWith(
        horas: horasList,
        calendarPages: calendarPages,
        reportPages: reports,
      );

      final empregosList = state.empregos.iCopy().iUpdateAt(
        updatedEmprego,
        state.empregoPos,
      );

      emit(
        state.copyWith(status: StateSuccessStatus(), empregos: empregosList),
      );
    } on Exception catch (e) {
      emit(state.copyWith(status: StateErrorStatus(errorMsg: e.toString())));

      rethrow;
    }
  }

  bool _validNewVigencia(int year, int month, DateTime admissao) {
    final newDate = DateTime(year, month, admissao.day);
    return newDate.isSameDayOrAfter(admissao);
  }
}
