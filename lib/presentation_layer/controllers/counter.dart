// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:collection';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'counter.g.dart';

@riverpod
String nome(NomeRef ref) => 'teste 123';

@riverpod
HomeState homeState() => HomeState(nome: "Clébin");

class HomeState {
  final String nome;
  final UnmodifiableListView<String> empregos;

  HomeState({
    required this.nome,
    Iterable<String> empregos = const [],
  }) : empregos = UnmodifiableListView(empregos);

  HomeState copyWith({
    String? nome,
    Iterable<String>? empregos,
  }) {
    return HomeState(
      nome: nome ?? this.nome,
      empregos: empregos ?? this.empregos,
    );
  }

  HomeState setNome(String nome) => copyWith(nome: nome);
  HomeState addEmprego(String nome) => copyWith(empregos: [...empregos, nome]);
}
