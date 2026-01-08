import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain_layer/models.dart';
import '../../../../presentation_layer/blocs.dart';

class EmpregosDropdown extends StatelessWidget {
  final VoidCallback onAdd, onEdit, onDelete;

  const EmpregosDropdown({
    required this.onAdd,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<HomeBloc>();
    final colors = Theme.of(context).colorScheme;

    return DropdownButtonHideUnderline(
      child: DropdownButton<Empregos>(
        dropdownColor: colors.primary,
        value: bloc.state.currentEmprego,
        focusColor: colors.onPrimary,
        items: bloc.state.empregos
            .map(
              (e) => DropdownMenuItem<Empregos>(
                value: e,
                child: Text(
                  e.descricao,
                  textAlign: TextAlign.justify,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: colors.onPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
            .toList(),

        onChanged: (e) async {
          if (e != null) {
            bloc.setEmpregoPos(e);
          } else {
            onAdd();
          }
        },
      ),
    );
  }
}
