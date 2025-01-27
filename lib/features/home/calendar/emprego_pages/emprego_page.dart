import 'package:flutter/material.dart';
import 'package:marcahoras3/widgets.dart';

import '../../../../domain_layer/models.dart';
import '../../../../resources.dart';

class EmpregoPage extends StatelessWidget {
  final Empregos emprego;

  const EmpregoPage({
    required this.emprego,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: AppColors.inversePrimary,
        border: Border.all(
          color: AppColors.surface,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(emprego.descricao),
              const Spacer(),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.edit),              
              ),
            ],
          ),
          // IconLabel(label: "Teste", icon: Icon(Icons.monetization_on))
        ],
      ),
    );
  }
}
