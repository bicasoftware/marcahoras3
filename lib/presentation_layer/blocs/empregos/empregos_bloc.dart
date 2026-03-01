import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data_layer/respositories.dart';
import '../../../domain_layer/models.dart';
import '../../../utils.dart';
import 'empregos_state.dart';

class EmpregosBloc extends Cubit<EmpregosState> {
  final EmpregoRepository empregoRepository;
  final SalariosRepository salariosRepository;
  final DiferenciaisRepository diferenciaisRepository;

  EmpregosBloc({
    required this.empregoRepository,
    required this.diferenciaisRepository,
    required this.salariosRepository,
  }) : super(
         EmpregosState(
           emprego: Empregos.empty(),
           status: StateSuccessStatus(),
           isInsert: true,
         ),
       );

  void load({required Empregos emprego, required bool isInsert}) {
    emit(
      state.copyWith(
        emprego: emprego,
        isInsert: isInsert,
      ),
    );
  }

  bool validate() {
    return [
      state.descricao.isNotEmpty,
      state.admissao != null,
      state.saida.isAfter(state.entrada),
      (state.porcFeriado > 0 && state.porcNormal > 0),
      state.isValidSalario(),
    ].every((it) => it);
  }

  void setDescricao(String descricao) {
    emit(state.copyWith(descricao: descricao));
  }

  void setSalario(double salario) {
    if (state.isInsert) {
      emit(state.setSalario(salario));
    }
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

  void setBancoHoras(bool enabled) {
    emit(state.copyWith(bancoHoras: enabled));
  }

  void setDiaFechamento(int day) {
    emit(state.copyWith(diaFechamento: day));
  }

  void addDiferenciada({
    required int porc,
    required int weekDay,
    required Color color,
  }) {
    emit(state.addDiferenciada(porc: porc, weekDay: weekDay, color: color));
  }

  void deleteDiferenciada(Diferenciais dif) {
    emit(state.deleteDiferenciada(dif));
  }

  void editDiferenciada({
    required Diferenciais original,
    required Diferenciais fresh,
  }) {
    emit(
      state.editDiferenciada(
        original: original, fresh: fresh,
      ),
    );
  }

  void addAumento({required double valor, required String vigencia}) {
    emit(state.addAumento(valor, vigencia));
  }

  void deleteSalario(Salarios salario) => emit(state.deleteSalario(salario));

  void editSalario({
    required Salarios original,
    required Salarios fresh,
  }) {
    emit(state.editSalario(original: original, fresh: fresh));
  }

  Future<void> persist() async {
    try {
      emit(
        state.copyWith(
          status: StateLoadingStatus(),
        ),
      );

      Empregos emprego;
      if (state.isInsert) {
        emprego = await empregoRepository.create(state.emprego);
      } else {
        emprego = await empregoRepository.update(state.emprego);
        await diferenciaisRepository.deleteMany(emprego.id!);
        await salariosRepository.deleteMany(emprego.id!);
      }

      /// Clean and re-add all difs on the database;
      await diferenciaisRepository.insertMany(state.difList);
      await salariosRepository.insertMany(state.salariosList);

      emit(
        state.copyWith(
          status: StateSuccessStatus(),
        ),
      );
    } on Exception catch (e) {
      emit(state.copyWith(status: StateErrorStatus(errorMsg: e.toString())));
      rethrow;
    }
  }
}
