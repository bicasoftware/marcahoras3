import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data_layer/web/web_exception.dart';
import '../../../domain_layer/usecases.dart';
import '../../../utils.dart';
import 'registration_state.dart';

class RegistrationBloc extends Cubit<RegistrationState> {
  final RegisterUserUsecase _registerUserUseCase;
  final LoginUserUsecase _loginUserUseCase;

  RegistrationBloc({
    required RegisterUserUsecase registerUserUseCase,
    required LoginUserUsecase loginUserUseCase,
  }) : _registerUserUseCase = registerUserUseCase,
       _loginUserUseCase = loginUserUseCase,
       super(
         RegistrationState(status: StateSuccessStatus(), errorMsg: ''),
       );

  final _niceDelay = Duration(seconds: 3);

  Future<void> register(String email, String password) async {
    try {
      emit(
        state.copyWith(
          status: StateLoadingStatus(),
        ),
      );

      await Future.delayed(_niceDelay);

      final authData = await _registerUserUseCase(
        email: email,
        password: password,
      );

      await VaultManager.refreshVault(
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
            errorMsg: e is WebException ? e.message : e.toString(),
          ),
        ),
      );

      rethrow;
    }
  }

  Future<void> loginIn(String email, String password) async {
    try {
      emit(
        state.copyWith(
          status: StateLoadingStatus(),
        ),
      );

      await Future.delayed(_niceDelay);

      final authData = await _loginUserUseCase(
        email: email,
        password: password,
      );

      await VaultManager.refreshVault(
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
            errorMsg: e is WebException ? e.message : e.toString(),
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

      await Future.delayed(_niceDelay);
      await VaultManager.clearVault();

      emit(
        state.copyWith(
          status: StateSuccessStatus(),
        ),
      );
    } on Exception catch (e) {
      emit(
        state.copyWith(
          status: StateErrorStatus(
            errorMsg: e is WebException ? e.message : e.toString(),
          ),
        ),
      );

      rethrow;
    }
  }
}
