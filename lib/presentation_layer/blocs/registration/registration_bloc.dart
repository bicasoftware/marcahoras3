import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data_layer/web/web_exception.dart';
import '../../../domain_layer/usecases.dart';
import '../../../utils/utils.dart';
import 'registration_state.dart';

class RegistrationBloc extends Cubit<RegistrationState> {
  final RegisterUserUsecase _registerUserUseCase;
  final LoginUserUsecase _loginUserUseCase;
  final SetVaultDataUsecase _setVaultDataUseCase;
  final ResetVaultUseCase _resetVault;
  final CleanDataUseCase _cleanDataUseCase;

  RegistrationBloc({
    required RegisterUserUsecase registerUserUseCase,
    required LoginUserUsecase loginUserUseCase,
    required SetVaultDataUsecase setVaultDataUseCase,
    required ResetVaultUseCase resetVault,
    required CleanDataUseCase cleanDataUseCase,
  })  : _registerUserUseCase = registerUserUseCase,
        _loginUserUseCase = loginUserUseCase,
        _setVaultDataUseCase = setVaultDataUseCase,
        _resetVault = resetVault,
        _cleanDataUseCase = cleanDataUseCase,
        super(
          RegistrationState(
            status: StateSuccessStatus(),
          ),
        );

  Future<void> register(String email, String password) async {
    try {
      emit(
        state.copyWith(
          status: StateLoadingStatus(),
        ),
      );

      final authData = await _registerUserUseCase(
        email: email,
        password: password,
      );

      await _setVaultDataUseCase(
        accessToken: authData.accessToken,
        refreshToken: authData.refreshToken,
      );

      emit(
        state.copyWith(
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

      rethrow;
    }
  }

  Future<bool> loginIn(String email, String password) async {
    try {
      emit(
        state.copyWith(
          status: StateLoadingStatus(),
        ),
      );

      final authData = await _loginUserUseCase(
        email: email,
        password: password,
      );

      await _setVaultDataUseCase(
        accessToken: authData.accessToken,
        refreshToken: authData.refreshToken,
      );

      emit(
        state.copyWith(
          status: StateSuccessStatus(),
        ),
      );

      return true;
    } on Exception catch (e) {
      emit(
        state.copyWith(
          status: StateErrorStatus(
            errorMsg: e is WebException ? e.errorDetail : e.toString(),
          ),
        ),
      );

      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      emit(
        state.copyWith(
          status: StateLoadingStatus(),
        ),
      );

      await _resetVault();
      await _cleanDataUseCase();

      emit(
        state.copyWith(
          status: StateSuccessStatus(),
        ),
      );
    } on Exception catch (e) {
      emit(
        state.copyWith(
          status: StateErrorStatus(
            errorMsg: e is WebException ? e.errorDetail : e.toString(),
          ),
        ),
      );

      rethrow;
    }
  }
}
