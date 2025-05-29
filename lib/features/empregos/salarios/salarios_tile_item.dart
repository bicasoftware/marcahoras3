import 'package:flutter/material.dart';

import '../../../resources.dart';
import '../../../utils/localiza/localiza.dart';

class SalariosTileItem extends StatelessWidget {
  final String vigencia;
  final String valor;

  const SalariosTileItem({
    required this.vigencia,
    required this.valor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 0,
            bottom: 0,
            child: Container(
              width: 2,
              decoration: BoxDecoration(
                color: AppColors.inversePrimary.withAlpha(80),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(4),
                  bottomLeft: Radius.circular(4),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 12),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: <Widget>[
                          _LabelText(Localiza.find('valor')),
                          const Spacer(),
                          _LabelText(Localiza.find('vigencia')),
                          const SizedBox(width: 12),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          _ValueText(valor),
                          const Spacer(),
                          _ValueText(vigencia),
                          const SizedBox(width: 12),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.arrow_right_rounded,
                    color: Colors.black12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LabelText extends StatelessWidget {
  final String label;

  const _LabelText(String label) : label = label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return Text(
      label,
      style: theme.labelMedium?.copyWith(fontWeight: FontWeight.bold),
      textAlign: TextAlign.start,
    );
  }
}

class _ValueText extends StatelessWidget {
  final String label;

  const _ValueText(String label) : label = label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return Text(label, style: theme.labelMedium);
  }
}
