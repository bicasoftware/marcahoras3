import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marcahoras3/presentation_layer/blocs/empregos/empregos_state.dart';
import 'package:marcahoras3/utils/bloc/state_status.dart';

import '../../../domain_layer/models.dart';
import '../../../domain_layer/usecases.dart';

class EmpregosBloc extends Cubit<EmpregosState> {
  final EmpregoDeleteUseCase _deleteUseCase;
  // final EmpregoDataLoadUseCase _loadEmpregos;

  EmpregosBloc({
    required EmpregoDeleteUseCase deleteUseCase,
    required EmpregoDataLoadUseCase empregoDataLoadUseCase,
  })  : _deleteUseCase = deleteUseCase,
        super(
          EmpregosState(
            status: StateLoadingStatus(),
          ),
        );

  /// Deletes a [Emprego] by its ID
  Future<void> deleteEmprego(String empregoId) async {
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
          status: StateSuccessStatus(),
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

  Future<void> addEmprego(Empregos emprego) async {
    try {
      emit(
        state.copyWith(
          empregos: [...state.empregos, emprego],
          status: StateSuccessStatus(),
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
