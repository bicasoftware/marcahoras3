import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain_layer/models.dart';
import '../../../../presentation_layer/blocs.dart';

class EmpregosDropdown extends StatelessWidget {
  const EmpregosDropdown();

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<HomeBloc>();
    final colors = Theme.of(context).colorScheme;

    return Padding(
      padding: .symmetric(horizontal: 8),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<Empregos>(
          isExpanded: true,
          dropdownColor: colors.primary,
          iconEnabledColor: colors.onPrimary,
          iconDisabledColor: colors.onPrimary,
          value: bloc.state.currentEmprego,
          focusColor: colors.onPrimary,
          items: bloc.state.empregos
              .map(
                (e) => DropdownMenuItem<Empregos>(
                  value: e,
                  
                  child: Container(
                    margin: .only(right: 8),
                    child: Text(
                      e.descricao,
                      overflow: .fade,
                      maxLines: 1,
                      softWrap: false,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: colors.onPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              )
              .toList(),

          onChanged: (e) async {
            if (e != bloc.state.currentEmprego) {
              bloc.setEmpregoPos(e!);
            }
          },
        ),
      ),
    );
  }
}
