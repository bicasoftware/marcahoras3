import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain_layer/models.dart';
import '../../../../domain_layer/usecases.dart';
import '../../../../utils/utils.dart';
import 'empregos_detail_state.dart';

class EmpregosDetailBloc extends Cubit<EmpregosDetailState> {
  final EmpregoInsertUseCase _insertUseCase;
  final SalarioCreateUseCase _salariosCreateUseCase;

  EmpregosDetailBloc({
    required EmpregoInsertUseCase insertUseCase,
    required SalarioCreateUseCase salariosCreateUseCase,
  })  : _insertUseCase = insertUseCase,
        _salariosCreateUseCase = salariosCreateUseCase,
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

  void setAsEdit(Empregos emprego) {
    emit(
      state.copyWith(
        emprego: emprego,
        isEditing: true,
      ),
    );
  }

  bool validate() {
    return [
      state.descricao?.isNotEmpty ?? false,
      (state.admissao != null && state.admissao!.isBefore(DateTime.now())),
      state.entrada != null,
      state.saida != null,
      state.porcFeriado != null,
      state.porcNormal != null,
      state.ativo != null,
      (state.salario != 0.0) // TODO - implementar check para lista de empregos
    ].every((it) => it);
  }

  void setDescricao(String descricao) {
    emit(
      state.copyWith(descricao: descricao),
    );
  }

  void setSalario(double salario) {
    emit(state.copyWith(salario: salario));
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
  Future<Empregos?> save() async {
    try {
      emit(
        state.copyWith(
          status: StateLoadingStatus(),
        ),
      );

      final newEmprego = await _insertUseCase(state.emprego);
      final newSal = Salarios(
        ativo: true,
        empregoId: newEmprego.id!,
        valor: state.salario,
        vigencia: getVigencia(state.admissao!),
      );

      final firstSalario = await _salariosCreateUseCase(newSal);

      emit(
        state.copyWith(
          emprego: Empregos(),
          status: StateSuccessStatus(),
        ),
      );

      return newEmprego.copyWith(
        salarios: [firstSalario],
      );
    } on Exception catch (e) {
      print(e.toString());
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
}
