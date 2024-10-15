import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain_layer/models.dart';
import '../../../domain_layer/usecases.dart';
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
  })  : _loadEmpregos = empregoDataLoadUseCase,
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
          ),
        );

  Future<void> load() async {
    try {
      emit(
        state.copyWith(
          status: StateLoadingStatus(),
        ),
      );

      final (from, to) = getFormatedDateRange(state.year, state.month);
      final empregos = await _loadEmpregos(from, to);

      empregos.forEachIndexed((i, e) async {
        final calendarPage = await _calendarPageGeneratorUseCase(
          e.horas,
          state.month,
          state.year,
        );

        empregos[i] = empregos[i].copyWith(calendarPages: [calendarPage]);
      });

      emit(
        state.copyWith(
          empregos: empregos,
          status: StateSuccessStatus(),
          empregoPos: empregos.length == 0 ? -1 : 0,
        ),
      );
    } on Exception catch (e) {
      emit(
        state.copyWith(
          status: StateErrorStatus(errorMsg: e.toString()),
        ),
      );

      rethrow;
    }
  }

  Future<void> deleteEmprego(Empregos emprego) async {
    try {
      emit(
        state.copyWith(
          status: StateLoadingStatus(),
        ),
      );

      /// Deletes [Emprego] from server
      await _empregoDeleteUseCase(emprego.id!);

      /// Creates a new list of [Empregos] and remove the deleted emprego
      final empregosList = [...state.empregos];
      empregosList.remove(emprego);

      /// Finally emits a new state with the new [Salarios] list
      emit(
        state.copyWith(
          status: StateSuccessStatus(),
          empregos: empregosList,
        ),
      );
    } on Exception catch (e) {
      emit(
        state.copyWith(
          status: StateErrorStatus(
            errorMsg: e.toString(),
          ),
        ),
      );

      rethrow;
    }
  }

  /// Method called when a user is deemed invalid
  /// It should clean every possible data existing in the app
  /// databases, Blocs, files, whatever is required for it to be a full new session.
  Future<void> clean() async {
    try {
      emit(
        state.copyWith(
          status: StateLoadingStatus(),
        ),
      );

      emit(
        state.copyWith(
          empregos: [],
          status: StateSuccessStatus(),
        ),
      );
    } on Exception catch (e) {
      emit(
        state.copyWith(
          status: StateErrorStatus(errorMsg: e.toString()),
        ),
      );

      rethrow;
    }
  }

  void setEmpregoPos(Empregos e) {
    final index = state.empregos.indexOf(e);
    emit(state.copyWith(empregoPos: index));
  }

  void setNavigationbarPosition(int pos) {
    emit(state.copyWith(navigatorPos: pos));
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

  Future<void> _updateCalendar(int year, int month) async {
    if (state.currentEmprego == null) return;
    if (state.hasPage(year, month) == -1) {
      try {
        emit(state.copyWith(status: StateLoadingStatus()));

        final (initDate, endDate) = getFormatedDateRange(year, month);

        final List<Horas> horas = await _horasLoadByRangeUseCase(
          state.currentEmprego!.id!,
          initDate,
          endDate,
        );

        final calendarPage = await _calendarPageGeneratorUseCase(
          horas,
          month,
          year,
        );

        final allHoras = <Horas>[...state.currentEmprego!.horas, ...horas];
        final pages = [...state.currentEmprego!.calendarPages, calendarPage];

        final empregosList = [...state.empregos];
        empregosList[state.empregoPos] = state.currentEmprego!
            .copyWith(horas: allHoras, calendarPages: pages);

        emit(
          state.copyWith(
            status: StateSuccessStatus(),
            year: year,
            month: month,
            empregos: empregosList,
          ),
        );
      } on Exception catch (e) {
        emit(
          state.copyWith(
            status: StateErrorStatus(errorMsg: e.toString()),
          ),
        );

        rethrow;
      }
    } else {
      emit(
        state.copyWith(
          status: StateSuccessStatus(),
          year: year,
          month: month,
        ),
      );
    }
  }

  Future<void> insertHora(Horas hora) async {
    if (state.currentEmprego == null) return;

    try {
      emit(
        state.copyWith(
          status: StateLoadingStatus(),
        ),
      );

      /// Insert the new [Horas] model
      final newHora = await _horasCreateUsecase(hora);

      /// Generates a new list based in the current [Emprego] on state
      final horasList = state.currentEmprego!.horas.iAdd(newHora);

      final newPageItems = state.currentPage().items.iCopy().iUpdateWhere(
            where: (h) => h.date?.isSameDay(newHora.data) ?? false,
            newItem: CalendarItemComplete(
              horas: newHora,
              date: newHora.data,
              isToday: newHora.data.isSameDay(
                DateTime.now(),
              ),
            ),
          );

      ///Generates a copy of the current [CalendarPage]
      final currentPage =
          state.currentPage().copyWith(items: newPageItems, horas: horasList);

      final calendarPages = state.currentEmprego!.calendarPages
          .iCopy()
          .iUpdateItem(currentPage, state.currentPage());

      final updatedEmprego = state.currentEmprego!.copyWith(
        horas: horasList,
        calendarPages: calendarPages,
      );

      final empregosList =
          state.empregos.iCopy().iUpdateAt(updatedEmprego, state.empregoPos);

      emit(
        state.copyWith(
          status: StateSuccessStatus(),
          empregos: empregosList,
        ),
      );
    } on Exception catch (e) {
      emit(
        state.copyWith(
          status: StateErrorStatus(
            errorMsg: e.toString(),
          ),
        ),
      );

      rethrow;
    }
  }

  Future<void> deleteHora(Horas hora) async {}

  Future<void> updateHora(Horas hora) async {}
}
