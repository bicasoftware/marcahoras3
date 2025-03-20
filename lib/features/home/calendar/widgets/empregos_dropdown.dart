import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain_layer/models.dart';
import '../../../../presentation_layer/blocs.dart';
import '../../../../resources.dart';
import '../../../../utils.dart';

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
    final theme = Theme.of(context).textTheme;

    return DropdownButtonHideUnderline(
      child: DropdownButton<Object>(
        dropdownColor: AppColors.inversePrimary,
        icon: PopupMenuButton(
          color: AppColors.inversePrimary,
          icon: Icon(Icons.more_vert, color: AppColors.onPrimary),
          itemBuilder: (context) {
            return <PopupMenuItem>[
              PopupMenuItem(
                onTap: onEdit,
                child: Text(
                  Localiza.find('editar'),
                  textAlign: TextAlign.justify,
                  style: theme.bodyLarge?.copyWith(
                    color: AppColors.onPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              PopupMenuItem(
                onTap: onDelete,
                child: Text(
                  Localiza.find('apagar'),
                  textAlign: TextAlign.justify,
                  style: theme.bodyLarge?.copyWith(
                    color: AppColors.onPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ];
          },
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
          ),
        ),
        value: bloc.state.currentEmprego,
        focusColor: AppColors.onPrimary,
        items:
            bloc.state.empregos
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
                  child: Chip(
                    label: Text(
                      "+ ${Localiza.find("novo")}",
                      textAlign: TextAlign.end,
                      style: theme.bodyMedium!.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                  ),
                ),
              ),
        onChanged: (e) async {
          if (e != null) {
            await awaitableTask(
              context: context,
              actualTask: () async => bloc.setEmpregoPos(e as Empregos),
            );
          } else {
            onAdd();
          }
        },
      ),
    );
  }
}
