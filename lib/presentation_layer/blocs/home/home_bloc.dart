import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marcahoras3/domain_layer/usecases/vault/load_vault_data_usecase.dart';
import 'package:marcahoras3/utils/utils.dart';

import '../../../domain_layer/models.dart';
import '../../../domain_layer/usecases.dart';
import 'home_state.dart';

/// Class that holds presentation data to be shown in the first screen the app renders
class HomeBloc extends Cubit<HomeState> {
  final EmpregoDataLoadUseCase _loadAllUseCase;
  final EmpregoInsertUseCase _insertUseCase;
  final EmpregoDeleteUseCase _deleteUseCase;
  final LoadVaultDataUseCase _vaultUseCase;

  // TODO - implementar usecases de register e login
  // TODO - salvar token no secure storage
  final RegisterUserUseCase _registerUserUseCase;
  final LoginUserUseCase _loginUserUseCase;

  HomeBloc(
    EmpregoDataLoadUseCase loadUseCase,
    EmpregoInsertUseCase insertUseCase,
    EmpregoDeleteUseCase deleteUseCase,
    LoadVaultDataUseCase vaultUseCase,
  )   : _loadAllUseCase = loadUseCase,
        _insertUseCase = insertUseCase,
        _deleteUseCase = deleteUseCase,
        _vaultUseCase = vaultUseCase,
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

      final empregoData = await _loadAllUseCase();
      final vaultData = await _vaultUseCase();

      emit(
        state.copyWith(
          empregos: empregoData,
          selectedEmprego: empregoData.isNotEmpty ? empregoData.first : null,
          status: StateSuccessStatus(),
          vault: vaultData,
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

  void setSelectedEmprego(Empregos emprego) {
    emit(
      state.copyWith(
        selectedEmprego: emprego,
      ),
    );
  }

  Future<void> register(String email, String password) {}

  Future<void> loginIn(String email, String password) {}
}
