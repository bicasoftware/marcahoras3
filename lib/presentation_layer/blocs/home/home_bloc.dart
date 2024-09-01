import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/utils.dart';
import '../../../domain_layer/usecases.dart';
import 'home_state.dart';

/// Class that holds presentation data to be shown in the first screen the app renders
class HomeBloc extends Cubit<HomeState> {
  EmpregoDataLoadUseCase _loadEmpregos;

  HomeBloc({
    required EmpregoDataLoadUseCase empregoDataLoadUseCase,
  })  : _loadEmpregos = empregoDataLoadUseCase,
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

      final empregos = await _loadEmpregos();

      emit(
        state.copyWith(
          empregos: empregos,
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

  void setTabPos(int pos) => emit(state.copyWith(tabPos: pos));

  void toggleDarkMode() => emit(state.copyWith(isDarkMode: !state.isDarkMode));
}
