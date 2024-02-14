import 'package:flutter/material.dart';
import 'package:marcahoras3/presentation_layer/shared_widgets/tipo_hora_segment.dart';

class AddHoraBts extends StatelessWidget {
  const AddHoraBts({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text('linha 1'),
            TipoHoraSegment(
              initialValue: 'n',
              onTypeChanged: (s) => '',
            ),
          ],
        ),
      ),
    );
  }
}
