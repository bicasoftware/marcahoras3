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

  CalendarPageGeneratorUseCase _calendarPageGeneratorUseCase;

  HomeBloc({
    required EmpregoDataLoadUseCase empregoDataLoadUseCase,
    required EmpregoDeleteUseCase empregoDeleteUseCase,
    required HorasLoadByRangeUseCase horasLoadByRangeUseCase,
    required int year,
    required int month,
  })  : _loadEmpregos = empregoDataLoadUseCase,
        _empregoDeleteUseCase = empregoDeleteUseCase,
        _calendarPageGeneratorUseCase = CalendarPageGeneratorUseCase(),
        _horasLoadByRangeUseCase = horasLoadByRangeUseCase,
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
    if (state.currentEmprego == null) return;

    final int newYear;
    final int newMonth;

    if (state.month == 12) {
      newYear = state.year + 1;
      newMonth = 1;
    } else {
      newYear = state.year;
      newMonth = state.month + 1;
    }

    if (state.hasPage(newYear, newMonth) == -1) {
      try {
        emit(state.copyWith(status: StateLoadingStatus()));

        final (initDate, endDate) = getFormatedDateRange(newYear, newMonth);

        final List<Horas> horas = await _horasLoadByRangeUseCase(
          state.currentEmprego!.id!,
          initDate,
          endDate,
        );

        final calendarPage = await _calendarPageGeneratorUseCase(
          horas,
          newMonth,
          newYear,
        );

        final allHoras = <Horas>[...state.currentEmprego!.horas, ...horas];
        final pages = [...state.currentEmprego!.calendarPages, calendarPage];

        final empregosList = [...state.empregos];
        empregosList[state.empregoPos] = state.currentEmprego!
            .copyWith(horas: allHoras, calendarPages: pages);

        emit(
          state.copyWith(
            status: StateSuccessStatus(),
            year: newYear,
            month: newMonth,
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
          year: newYear,
          month: newMonth,
        ),
      );
    }
  }

  void decMonth() async {
    if (state.currentEmprego == null) return;
    final int newMonth;
    final int newYear;

    if (state.month == 1) {
      newYear = (state.year - 1);
      newMonth = 12;
    } else {
      newYear = state.year;
      newMonth = state.month - 1;
    }

    if (state.hasPage(newYear, newMonth) == -1) {
      try {
        emit(state.copyWith(status: StateLoadingStatus()));

        final (initDate, endDate) = getFormatedDateRange(newYear, newMonth);

        final List<Horas> horas = await _horasLoadByRangeUseCase(
          state.currentEmprego!.id!,
          initDate,
          endDate,
        );

        final calendarPage = await _calendarPageGeneratorUseCase(
          horas,
          newMonth,
          newYear,
        );

        final allHoras = <Horas>[...state.currentEmprego!.horas, ...horas];
        final pages = [...state.currentEmprego!.calendarPages, calendarPage];

        final empregosList = [...state.empregos];
        empregosList[state.empregoPos] = state.currentEmprego!
            .copyWith(horas: allHoras, calendarPages: pages);

        emit(
          state.copyWith(
            status: StateSuccessStatus(),
            year: newYear,
            month: newMonth,
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
          year: newYear,
          month: newMonth,
        ),
      );
    }
  }

  void setMonth(int newMonth) => emit(state.copyWith(month: newMonth));
  void setYear(int newYear) => emit(state.copyWith(year: newYear));
}
