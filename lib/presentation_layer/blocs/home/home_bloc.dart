import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain_layer/models.dart';
import '../../../domain_layer/usecases.dart';
import '../../../utils/bloc/state_status.dart';

import 'home_state.dart';

/// Class that holds presentation data to be shown in the first screen the app renders
class HomeBloc extends Cubit<HomeState> {
  final EmpregoDataLoadUseCase _loadAllUseCase;
  final EmpregoInsertUseCase _insertUseCase;
  final EmpregoDeleteUseCase _deleteUseCase;

  HomeBloc(
    EmpregoDataLoadUseCase loadUseCase,
    EmpregoInsertUseCase insertUseCase,
    EmpregoDeleteUseCase deleteUseCase,
  )   : _loadAllUseCase = loadUseCase,
        _insertUseCase = insertUseCase,
        _deleteUseCase = deleteUseCase,
        super(
          HomeState(
            status: StateLoadingStatus(),
          ),
        );

  Future<void> load() async {
    try {
      emit(
        state.copyWith(
          status: StateLoadingStatus(),
        ),
      );

      final result = await _loadAllUseCase();

      emit(
        state.copyWith(
          empregos: result,
          status: StateSuccessStatus(state: state),
        ),
      );
    } on Exception catch (e) {
      emit(
        state.copyWith(
          status: StateErrorStatus(errorMsg: e.toString()),
        ),
      );
    }
  }

  Future<void> addEmprego(Empregos emprego) async {
    try {
      emit(
        state.copyWith(
          status: StateLoadingStatus(),
        ),
      );

      final newEmprego = await _insertUseCase(emprego);

      emit(
        state.copyWith(
          empregos: [
            ...state.empregos,
            newEmprego,
          ],
          status: StateSuccessStatus(state: state),
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
    }
  }

  Future<void> deleteEmprego(int empregoId) async {
    try {
      emit(
        state.copyWith(
          status: StateLoadingStatus(),
        ),
      );

      await _deleteUseCase(empregoId);

      final fixedEmpregos = [...state.empregos]..removeWhere(
          (Empregos e) => e.id == empregoId,
        );

      emit(
        state.copyWith(
          empregos: fixedEmpregos,
          status: StateSuccessStatus(state: state),
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
    }
  }
}
