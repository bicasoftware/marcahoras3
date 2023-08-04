import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marcahoras3/utils/bloc/state_status.dart';
import 'package:marcahoras3/utils/extensions.dart';

import '../../../domain_layer/models.dart';
import 'home_state.dart';

/// Class that holds presentation data to be shown in the first screen the app renders
class HomeBloc extends Cubit<HomeState> {
  HomeBloc()
      : super(
          HomeState(
            status: LoadingStatus(),
          ),
        );

  Future<void> load() async {
    try {
      emit(
        state.copyWith(
          empregos: [],
          status: LoadingStatus(),
        ),
      );

      final empregos = await Future.delayed(
        const Duration(seconds: 2),
        () => [
          for (int i = 0; i < 5; i++)
            Empregos(
              descricao: "Emprego $i",
              inicio: DateTime.now(),
              entrada: '08:00'.toTimeOfDay(),
              saida: '16:00'.toTimeOfDay(),
              extra: 50,
              extraFeriado: 100,
              cargaHoraria: 220,
            ),
        ],
      );

      emit(
        state.copyWith(
          empregos: empregos,
          status: SuccessStatus(state: state),
        ),
      );
    } on Exception catch (e) {
      emit(
        state.copyWith(
          status: ErrorStatus(errorMsg: e.toString()),
        ),
      );
    }
  }
}
