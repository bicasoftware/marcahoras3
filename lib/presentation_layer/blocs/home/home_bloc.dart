import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marcahoras3/utils/utils.dart';

import '../../../domain_layer/models.dart';
import '../../../domain_layer/usecases.dart';
import 'home_state.dart';

/// Class that holds presentation data to be shown in the first screen the app renders
class HomeBloc extends Cubit<HomeState> {
  final RegisterUserUsecase _registerUserUseCase;
  final LoginUserUsecase _loginUserUseCase;

  final EmpregoDataLoadUseCase _loadEmpregos;
  final EmpregoInsertUseCase _insertUseCase;
  final EmpregoDeleteUseCase _deleteUseCase;
  final LoadVaultDataUseCase _loadVaultDataUseCase;
  final SetVaultDataUsecase _setVaultDataUseCase;

  HomeBloc({
    required EmpregoDataLoadUseCase empregoLoadUseCase,
    required EmpregoInsertUseCase empregoInsertUseCase,
    required EmpregoDeleteUseCase empregoDeleteUseCase,
    required LoadVaultDataUseCase loadVaultDataUseCase,
    required RegisterUserUsecase registerUserUsecase,
    required LoginUserUsecase loginUserUsecase,
    required SetVaultDataUsecase setVaultDataUseCase,
  })  : _loadEmpregos = empregoLoadUseCase,
        _insertUseCase = empregoInsertUseCase,
        _deleteUseCase = empregoDeleteUseCase,
        _loadVaultDataUseCase = loadVaultDataUseCase,
        _loginUserUseCase = loginUserUsecase,
        _registerUserUseCase = registerUserUsecase,
        _setVaultDataUseCase = setVaultDataUseCase,
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

      final vaultData = await _loadVaultDataUseCase();
      var empregos = <Empregos>[];
      if (vaultData.hasToken) {
        empregos = await _loadEmpregos();
      }

      emit(
        state.copyWith(
          empregos: empregos,
          selectedEmprego: empregos.isNotEmpty ? empregos.first : null,
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

  Future<void> register(String email, String password) async {
    try {
      emit(
        state.copyWith(
          status: StateLoadingStatus(),
          empregos: [],
          selectedEmprego: null,
        ),
      );

      final authData = await _registerUserUseCase(
        email: email,
        password: password,
      );

      final vault = await _setVaultDataUseCase(
        accessToken: authData.accessToken,
        refreshToken: authData.refreshToken,
      );

      emit(
        state.copyWith(
          status: StateSuccessStatus(),
          empregos: [],
          vault: vault,
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

  Future<void> loginIn(String email, String password) async {
    try {
      emit(
        state.copyWith(
          status: StateLoadingStatus(),
          empregos: [],
          selectedEmprego: null,
        ),
      );

      final authData = await _loginUserUseCase(
        email: email,
        password: password,
      );

      final vault = await _setVaultDataUseCase(
        accessToken: authData.accessToken,
        refreshToken: authData.refreshToken,
      );

      final empregos = await _loadEmpregos();

      emit(
        state.copyWith(
          status: StateSuccessStatus(),
          empregos: empregos,
          vault: vault,
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
