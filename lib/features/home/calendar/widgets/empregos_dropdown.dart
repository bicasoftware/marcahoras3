import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marcahoras3/presentation_layer/blocs.dart';
import 'package:marcahoras3/utils/utils.dart';

import '../../../../domain_layer/models.dart';
import '../../../../resources.dart';

class EmpregosDropdown extends StatelessWidget {
  final VoidCallback onAdd, onEdit;

  const EmpregosDropdown({
    required this.onAdd,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<HomeBloc>();
    final theme = Theme.of(context).textTheme;
    final strings = context.strings();

    return DropdownButtonHideUnderline(
      child: DropdownButton<Object>(
        dropdownColor: AppColors.inversePrimary,
        icon: TextButton(
          child: Text(
            strings.editar,
            style: theme.bodyMedium!.copyWith(
              color: Colors.white70,
            ),
          ),
          onPressed: onEdit,
        ),
        value: bloc.state.currentEmprego,
        focusColor: AppColors.onPrimary,
        items: bloc.state.empregos
            .map(
              (e) => DropdownMenuItem<Object>(
                value: e,
                child: Text(
                  e.descricao,
                  textAlign: TextAlign.justify,
                  style: theme.bodyLarge?.copyWith(
                    color: AppColors.onPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
            .toList()
          ..add(
            DropdownMenuItem<Object>(
              value: null,
              child: Text(
                "Novo",
                textAlign: TextAlign.justify,
                style: theme.bodyLarge?.copyWith(
                  color: AppColors.onPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        onChanged: (e) async {
          if (e != null) {
            await awaitableTask(
                context: context,
                actualTask: () async => bloc.setEmpregoPos(e as Empregos));
          } else {
            onAdd();
          }
        },
      ),
    );
  }
}
