import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain_layer/models.dart';
import '../../../../domain_layer/usecases.dart';
import '../../../../utils/utils.dart';
import 'empregos_detail_state.dart';

class EmpregosDetailBloc extends Cubit<EmpregosDetailState> {
  final EmpregoInsertUseCase _insertUseCase;
  final EmpregoUpdateUseCase _updateUseCase;
  final SalarioCreateUseCase _salariosCreateUseCase;
  final SalarioUpdateUseCase _salariosUpdateUseCase;
  final SalarioDeleteUseCase _salariosDeleteUseCase;

  EmpregosDetailBloc({
    required EmpregoInsertUseCase insertUseCase,
    required EmpregoUpdateUseCase updateUseCase,
    required SalarioCreateUseCase salariosCreateUseCase,
    required SalarioUpdateUseCase salariosUpdateUseCase,
    required SalarioDeleteUseCase salariosDeleteUseCase,
  })  : _insertUseCase = insertUseCase,
        _updateUseCase = updateUseCase,
        _salariosUpdateUseCase = salariosUpdateUseCase,
        _salariosCreateUseCase = salariosCreateUseCase,
        _salariosDeleteUseCase = salariosDeleteUseCase,
        super(
          EmpregosDetailState(
            emprego: Empregos(),
            status: StateSuccessStatus(),
          ),
        );

  void reset() {
    emit(
      state.copyWith(
        emprego: Empregos(),
        isEditing: false,
      ),
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

  Future<void> save() async {
    return state.isEditing ? await update() : await insert();
  }

  /// Insert a new Emprego, Insert a new [Salarios] and returns an [Emprego] model
  Future<void> insert() async {
    try {
      emit(
        state.emitLoading(),
      );

      /// Calls [Empregos] Post endpoint
      final newEmprego = await _insertUseCase(state.emprego);

      /// When first creating a new [Emprego], it is required it to have a [Salario]
      /// so we also call the [Salarios] endpoint and insert a new [Salarios]
      final firstSalario = await _salariosCreateUseCase(
        Salarios(
          ativo: true,
          empregoId: newEmprego.id!,
          valor: state.salario,
          vigencia: getVigencia(state.admissao!),
        ),
      );

      final updatedEmprego = newEmprego.copyWith(salarios: [firstSalario]);

      /// Finally we emit a new state
      emit(
        state.copyWith(
          emprego: updatedEmprego,
          status: StateSuccessStatus(),
        ),
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

  /// Updates an Emprego and returns a [Emprego] model
  Future<void> update() async {
    try {
      emit(state.emitLoading());

      /// Call [Empregos] Patch endpoint
      final updatedEmprego = await _updateUseCase(state.emprego);

      /// Finally emits a new state
      emit(
        state.copyWith(
          emprego: updatedEmprego,
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

  /// Updates a [Salarios] instance
  Future<void> updateSalario(Salarios salario) async {
    try {
      emit(
        state.emitLoading(),
      );

      /// Calls the Patch [Salarios] endpoint which return the updated data
      final newSalario = await _salariosUpdateUseCase(salario);

      /// Find in the current [Salarios] list the related [Salarios] index
      final index =
          state.emprego.salarios.indexWhere((s) => s.id == salario.id);

      /// Generates a new list from the old [Salarios] list
      final salariosList = [...state.emprego.salarios];

      /// Updates the new list with the data returned from server
      salariosList[index] = newSalario;

      /// Finally, emits the new state with the new generated list
      emit(
        state.copyWith(
          status: StateSuccessStatus(),
          emprego: state.emprego.copyWith(salarios: salariosList),
        ),
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

  /// Creates a new [Salarios] model
  Future<void> insertSalario({
    required double valor,
    required DateTime vigencia,
    required String empregoId,
  }) async {
    try {
      emit(
        state.emitLoading(),
      );

      /// Calls the Patch [Salarios] endpoint which return the updated data
      final newSalario = await _salariosCreateUseCase(
        Salarios(
          empregoId: empregoId,
          ativo: true,
          valor: valor,
          vigencia: vigencia,
        ),
      );

      /// Generates a new list from the old [Salarios] list
      final salariosList = [...state.emprego.salarios];

      /// Updates the new list with the data returned from server
      salariosList.add(newSalario);

      /// Finally, emits the new state with the new generated list
      emit(
        state.copyWith(
          status: StateSuccessStatus(),
          emprego: state.emprego.copyWith(salarios: salariosList),
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

  /// Creates delete the [Salarios] model by its id
  Future<void> deleteSalario({
    required Salarios salario,
  }) async {
    try {
      emit(
        state.emitLoading(),
      );

      /// Calls the Delete [Salarios] endpoint which return only 200 response code
      await _salariosDeleteUseCase(salario.id!);

      /// Generates a new list from the old [Salarios] list
      final salariosList = [...state.emprego.salarios];
      salariosList.removeWhere((s) => s.id == salario.id);

      /// Finally, emits the new state with the new generated list
      emit(
        state.copyWith(
          status: StateSuccessStatus(),
          emprego: state.emprego.copyWith(salarios: salariosList),
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
}
