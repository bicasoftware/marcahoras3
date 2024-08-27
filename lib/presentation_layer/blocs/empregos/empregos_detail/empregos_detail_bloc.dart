import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marcahoras3/utils/bloc/state_status.dart';

import '../../../../domain_layer/models.dart';
import '../../../../domain_layer/usecases.dart';
import 'empregos_detail_state.dart';

class EmpregosDetailBloc extends Cubit<EmpregosDetailState> {
  final EmpregoInsertUseCase _insertUseCase;

  EmpregosDetailBloc({required EmpregoInsertUseCase insertUseCase})
      : _insertUseCase = insertUseCase,
        super(
          EmpregosDetailState(
            emprego: Empregos(),
            status: StateSuccessStatus(),
          ),
        );

  void reset() {
    emit(
      state.copyWith(emprego: Empregos()),
    );
  }

  void setDescricao(String descricao) {
    emit(
      state.copyWith(descricao: descricao),
    );
  }

  void setAdmissao(DateTime admissao) {
    emit(
      state.copyWith(admissao: admissao),
    );
  }

  void setEntrada(TimeOfDay entrada) {
    emit(
      state.copyWith(entrada: entrada),
    );
  }

  void setSaida(TimeOfDay saida) {
    emit(
      state.copyWith(saida: saida),
    );
  }

  void setPorcNormal(int porc) {
    emit(
      state.copyWith(porcNormal: porc),
    );
  }

  void setPorcFeriados(int porc) {
    emit(
      state.copyWith(porcFeriado: porc),
    );
  }

  void setCargaHoraria(int carga) {
    emit(
      state.copyWith(cargaHoraria: carga),
    );
  }

  void toggleBancoHoras() {
    emit(
      state.copyWith(bancoHoras: !state.bancoHoras),
    );
  }

  /// Insert new [Emprego] model
  Future<Empregos?> addEmprego(Empregos emprego) async {
    try {
      emit(
        state.copyWith(
          status: StateLoadingStatus(),
        ),
      );

      final newEmprego = await _insertUseCase(emprego);

      emit(
        state.copyWith(
          emprego: Empregos(),
          status: StateSuccessStatus(),
        ),
      );

      return newEmprego;
    } on Exception catch (e) {
      emit(
        state.copyWith(
          status: StateErrorStatus(
            errorMsg: e.toString(),
          ),
        ),
      );
    }

    return null;
  }
}
