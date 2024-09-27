import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marcahoras3/presentation_layer/blocs.dart';

import '../../../../domain_layer/models.dart';
import '../../../../resources.dart';

class EmpregosDropdown extends StatelessWidget {
  const EmpregosDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<HomeBloc>();
    final theme = Theme.of(context).textTheme;

    return DropdownButtonHideUnderline(
      child: DropdownButton<Empregos>(
        dropdownColor: AppColors.inversePrimary,
        iconEnabledColor: AppColors.onPrimary,
        value: bloc.state.currentEmprego,
        focusColor: AppColors.onPrimary,        
        items: bloc.state.empregos
            .map(
              (e) => DropdownMenuItem<Empregos>(
                value: e,
                child: Text(
                  e.descricao,
                  style: theme.bodyMedium?.copyWith(
                    color: AppColors.onPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
            .toList(),
        onChanged: (e) {
          if (e != null) bloc.setEmpregoPos(e);
        },
      ),
    );
  }
}
