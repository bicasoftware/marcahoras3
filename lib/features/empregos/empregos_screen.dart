import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marcahoras3/domain_layer/models/empregos.dart';
import 'package:marcahoras3/presentation_layer/blocs/home/home_bloc.dart';

class EmpregosScreen extends StatelessWidget {
  const EmpregosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<HomeBloc>();
    final empregos = bloc.state.empregos;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              empregos.length.toString(),
            ),
            ...empregos.map(
              (Empregos emprego) => ListTile(
                title: Text(emprego.descricao),
              ),
            )
          ],
        ),
      ),
    );
  }
}
