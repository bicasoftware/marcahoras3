import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain_layer/models.dart';
import '../../../domain_layer/usecases.dart';
import '../../../utils.dart';
import 'empregos_state.dart';

class EmpregosBloc extends Cubit<EmpregosState> {
  final EmpregoInsertUseCase _insertUseCase;
  final EmpregoUpdateUseCase _updateUseCase;
  final SalarioCreateUseCase _salariosCreateUseCase;
  final SalarioUpdateUseCase _salariosUpdateUseCase;
  final SalarioDeleteUseCase _salariosDeleteUseCase;
  final DiferencialSaveUseCase _diferencialSaveUseCase;
  final DiferencialDeleteUseCase _diferencialDeleteUseCase;
  final DiferencialUpdateUseCase _diferencialUpdateUseCase;
  final HoraFixoDeleteUseCase _horaFixoDeleteUseCase;
  final HoraFixoSaveUseCase _horaFixoSaveUseCase;
  final HoraFixoUpdateUseCase _horaFixoUpdateUseCase;

  EmpregosBloc({
    required EmpregoInsertUseCase insertUseCase,
    required EmpregoUpdateUseCase updateUseCase,
    required SalarioCreateUseCase salariosCreateUseCase,
    required SalarioUpdateUseCase salariosUpdateUseCase,
    required SalarioDeleteUseCase salariosDeleteUseCase,
    required DiferencialDeleteUseCase diferencialDeleteUseCase,
    required DiferencialSaveUseCase diferencialSaveUseCase,
    required DiferencialUpdateUseCase diferencialUpdateUseCase,
    required HoraFixoDeleteUseCase horaFixoDeleteUseCase,
    required HoraFixoSaveUseCase horaFixoSaveUseCase,
    required HoraFixoUpdateUseCase horaFixoUpdateUseCase,
  }) : _insertUseCase = insertUseCase,
       _updateUseCase = updateUseCase,
       _salariosUpdateUseCase = salariosUpdateUseCase,
       _salariosCreateUseCase = salariosCreateUseCase,
       _salariosDeleteUseCase = salariosDeleteUseCase,
       _horaFixoDeleteUseCase = horaFixoDeleteUseCase,
       _horaFixoSaveUseCase = horaFixoSaveUseCase,
       _horaFixoUpdateUseCase = horaFixoUpdateUseCase,

       _diferencialSaveUseCase = diferencialSaveUseCase,

       _diferencialDeleteUseCase = diferencialDeleteUseCase,
       _diferencialUpdateUseCase = diferencialUpdateUseCase,
       super(
         EmpregosState(
           emprego: Empregos(),
           status: StateSuccessStatus(),
           useValorFixo: false,
         ),
       );

  void load([Empregos? emprego]) {
    emit(
      state.copyWith(
        emprego: emprego ?? Empregos(),
        isEditing: emprego != null,
        useValorFixo: emprego?.horaFixoList.isNotEmpty ?? false,
        valorFixo: emprego?.getCurrentValorFixo() ?? (0, 0),
      ),
    );
  }

  bool validate() {
    bool validPercent = state.useValorFixo
        ? state.valorFixo.$1 > 0 && state.valorFixo.$2 > 0
        : state.porcFeriado != null && state.porcNormal != null;

    final result = [
      state.descricao?.isNotEmpty ?? false,
      state.admissao != null,
      state.entrada != null,
      state.saida != null,
      validPercent,
      state.ativo != null,
      ((state.salario != 0.0) || state.emprego.salarios.isNotEmpty),
    ].every((it) => it);

    return result;
  }

  void setDescricao(String descricao) {
    emit(state.copyWith(descricao: descricao));
  }

  void setSalario(double salario) {
    emit(state.copyWith(salario: salario));
  }

  void setAdmissao(DateTime admissao) {
    emit(state.copyWith(admissao: admissao));
  }

  void setEntrada(TimeOfDay entrada) {
    emit(state.copyWith(entrada: entrada));
  }

  void setSaida(TimeOfDay saida) {
    emit(state.copyWith(saida: saida));
  }

  void setPorcNormal(int porc) {
    emit(state.copyWith(porcNormal: porc));
  }

  void setPorcFeriados(int porc) {
    emit(state.copyWith(porcFeriado: porc));
  }

  void setCargaHoraria(int carga) {
    emit(state.copyWith(cargaHoraria: carga));
  }

  void toggleBancoHoras() {
    emit(state.copyWith(bancoHoras: !state.bancoHoras));
  }

  void toggleValorFixo(bool value) {
    emit(state.copyWith(useValorFixo: value));
  }

  void setValorFixo(double v1, double v2) {
    emit(state.copyWith(valorFixo: (v1, v2)));
  }

  Future<void> save() async {
    return state.isEditing ? await update() : await insert();
  }

  /// Insert a new Emprego, Insert a new [Salarios] and returns an [Emprego] model
  Future<void> insert() async {
    try {
      emit(state.emitLoading());
      final vigencia = getVigencia(state.admissao!);

      /// Calls [Empregos] Post endpoint
      final newEmprego = await _insertUseCase(state.emprego);

      /// When first creating a new [Emprego], it is required it to have a [Salario]
      /// so we also call the [Salarios] endpoint and insert a new [Salarios]
      final firstSalario = await _salariosCreateUseCase(
        Salarios(
          ativo: true,
          empregoId: newEmprego.id!,
          valor: state.salario,
          vigencia: vigencia,
          createdAt: DateTime.now(),
        ),
      );

      /// Cria nova entrada para valor extra fixado
      final valorFixado = state.useValorFixo
          ? await _horaFixoSaveUseCase(
              HoraFixo(
                idEmprego: newEmprego.id!,
                valorNormal: state.valorFixo.$1,
                valorFeriado: state.valorFixo.$2,
                vigencia: vigencia,
              ),
            )
          : null;

      final updatedEmprego = newEmprego.copyWith(
        salarios: [firstSalario],
        horaFixoList: valorFixado != null ? [valorFixado] : [],
      );

      /// Finally we emit a new state
      emit(
        state.copyWith(emprego: updatedEmprego, status: StateSuccessStatus()),
      );
    } on Exception catch (e) {
      emit(state.copyWith(status: StateErrorStatus(errorMsg: e.toString())));

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
        state.copyWith(emprego: updatedEmprego, status: StateSuccessStatus()),
      );
    } on Exception catch (e) {
      emit(state.copyWith(status: StateErrorStatus(errorMsg: e.toString())));

      rethrow;
    }
  }

  /// Updates a [Salarios] instance
  Future<void> updateSalario(Salarios salario) async {
    try {
      emit(state.emitLoading());

      /// Calls the Patch [Salarios] endpoint which return the updated data
      final newSalario = await _salariosUpdateUseCase(salario);

      /// Find in the current [Salarios] list the related [Salarios] index
      final index = state.emprego.salarios.indexWhere(
        (s) => s.id == salario.id,
      );

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
      emit(state.copyWith(status: StateErrorStatus(errorMsg: e.toString())));

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
      emit(state.emitLoading());

      /// Calls the Patch [Salarios] endpoint which return the updated data
      final newSalario = await _salariosCreateUseCase(
        Salarios(
          empregoId: empregoId,
          ativo: true,
          valor: valor,
          vigencia: vigencia,
          createdAt: DateTime.now(),
        ),
      );

      /// Generates a new list from the old [Salarios] list
      final salariosList = [...state.emprego.salarios, newSalario];

      /// Finally, emits the new state with the new generated list
      emit(
        state.copyWith(
          status: StateSuccessStatus(),
          emprego: state.emprego.copyWith(salarios: salariosList),
        ),
      );
    } on Exception catch (e) {
      emit(state.copyWith(status: StateErrorStatus(errorMsg: e.toString())));

      rethrow;
    }
  }

  /// Creates delete the [Salarios] model by its id
  Future<void> deleteSalario({required Salarios salario}) async {
    return _prepareState(() async {
      /// Calls the Delete [Salarios] endpoint which return only 200 response code
      await _salariosDeleteUseCase(salario.id!);

      /// Generates a new list from the old [Salarios] list
      final salariosList = [...state.emprego.salarios];
      salariosList.removeWhere((s) => s.id == salario.id);

      /// Finally, emits the new state with the new generated list
      return state.copyWith(
        status: StateSuccessStatus(),
        emprego: state.emprego.copyWith(salarios: salariosList),
      );
    });    
  }

  /// CRUD for [HoraFixo]
  ///
  ///

  /// Creates a new [HoraFixo] model
  Future<void> insertHoraFixo({
    required ValorFixo valorFixo,
    required DateTime vigencia,
    required String empregoId,
  }) async {
    return _prepareState(() async {
      /// Calls the [HoraFixoSaveUseCase]
      final newHoraFixo = await _horaFixoSaveUseCase(
        HoraFixo(
          idEmprego: empregoId,
          valorNormal: valorFixo.$1,
          valorFeriado: valorFixo.$2,
          vigencia: vigencia,
        ),
      );

      /// Generates a new list from the old [HoraFixo] list
      final horaFixoList = [
        ...state.emprego.horaFixoList,
        ?newHoraFixo,
      ];

      /// Returns the new [EmpregosState]
      return state.copyWith(
        status: StateSuccessStatus(),
        emprego: state.emprego.copyWith(horaFixoList: horaFixoList),
      );
    });
  }

  /// Updates a [HoraFixo] instance
  Future<void> updateHoraFixo(HoraFixo horaFixo) async {
    return _prepareState(() async {
      /// Calls the [HoraFixoUpdateUseCase]
      final newhoraFixo = await _horaFixoUpdateUseCase(horaFixo);

      /// Generates a new list from the old [HoraFixo] list
      final horaFixoList = state.emprego.horaFixoList.iCopy();

      /// Updates the new list with the data returned from the usecase
      if (newhoraFixo != null) {
        horaFixoList.iUpdateWhere(
          newItem: newhoraFixo,
          where: (s) => s.id == horaFixo.id,
        );
      }

      /// Returns the new [EmpregosState]
      return state.copyWith(
        status: StateSuccessStatus(),
        emprego: state.emprego.copyWith(horaFixoList: horaFixoList),
      );
    });
  }

  /// Creates delete the [HoraFixo] model by its id
  Future<void> deleteHoraFixo(HoraFixo horaFixo) async {
    return _prepareState(() async {
      /// Calls the Delete [HoraFixoDeleteUsecase]
      final deleted = await _horaFixoDeleteUseCase(horaFixo.id!);

      /// Generates a new list from the old [HoraFixo] list
      final horaFixoList = state.emprego.horaFixoList.iCopy();

      if (deleted) {
        horaFixoList.removeWhere((s) => s.id == horaFixo.id!);
      }

      /// Return the new [EmpregosState]
      return state.copyWith(
        status: StateSuccessStatus(),
        emprego: state.emprego.copyWith(horaFixoList: horaFixoList),
      );
    });
  }

  /// CRUD for [Diferenciais]
  ///
  ///

  /// Creates a new [Diferenciais] model
  Future<void> insertDiferencial({
    required int porc,
    required int weekDay,
    required String empregoId,
  }) async {
    return _prepareState(() async {
      /// Calls the [DiferencialSaveUseCase]
      final newDif = await _diferencialSaveUseCase(
        Diferenciais(
          idEmprego: empregoId,
          percentage: porc,
          weekday: weekDay,
        ),
      );

      /// Creates a new List<[Diferenciais]> with the new value
      final difList = [...state.emprego.diferenciaisList, ?newDif];

      return state.copyWith(
        status: StateSuccessStatus(),
        emprego: state.emprego.copyWith(diferenciaisList: difList),
      );
    });
  }

  /// Updates a [Diferenciais] instance
  Future<void> updateDiferenciais(Diferenciais diferencial) async {
    return _prepareState(() async {
      /// Updates the [Diferenciais] model
      final updatedDif = await _diferencialUpdateUseCase(diferencial);

      final difList = state.emprego.diferenciaisList.iCopy();

      if (updatedDif != null) {
        /// Creates a new List<[Diferenciais]> with the updated value
        difList.iUpdateWhere(
          newItem: updatedDif,
          where: (d) => d.id == diferencial.id,
        );
      }

      /// Emit the new state
      return state.copyWith(
        status: StateSuccessStatus(),
        emprego: state.emprego.copyWith(diferenciaisList: difList),
      );
    });
  }

  /// Delete the [Diferenciais] model
  Future<void> deleteDiferenciais(Diferenciais diferenciais) async {
    return _prepareState(() async {
      /// Calls the Delete [DiferenciaisDeleteUsecase]
      final deleted = await _diferencialDeleteUseCase(diferenciais.id!);

      final difList = await state.emprego.diferenciaisList.iCopy();

      /// Creates a new list with the removed item
      if (deleted) {
        difList.removeWhere((s) => s.id == diferenciais.id!);
      }

      return state.copyWith(
        status: StateSuccessStatus(),
        emprego: state.emprego.copyWith(diferenciaisList: difList),
      );
    });
  }

  Future<void> _prepareState(
    Future<EmpregosState> Function() prepareNewState,
  ) async {
    try {
      emit(state.emitLoading());

      emit(
        await prepareNewState(),
      );
    } on Exception catch (e) {
      emit(state.copyWith(status: StateErrorStatus(errorMsg: e.toString())));

      rethrow;
    }
  }
}
