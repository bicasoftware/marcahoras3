import 'package:flutter/material.dart';

import '../domain_layer/models.dart';
import '../resources.dart';
import '../utils.dart';

class HoraTypeToggleButton extends StatefulWidget {
  final HorasType horasType;
  final Diferenciais? diferencial;
  final void Function(HorasType type) onSelectionChanged;

  const HoraTypeToggleButton({
    required this.horasType,
    required this.onSelectionChanged,
    this.diferencial,
  });

  @override
  State<HoraTypeToggleButton> createState() => _HoraTypeToggleButtonState();
}

class _HoraTypeToggleButtonState extends State<HoraTypeToggleButton> {
  int _pos = 0;

  List<String> _labels = [
    Localiza.find('normais'),
    Localiza.find('feriado'),
  ];

  List<HorasType> _horasTypeList = [
    HorasType.normal,
    HorasType.feriado,
  ];

  @override
  void initState() {
    if (widget.diferencial != null) {
      _labels.add(
        Localiza.find('diferencial'),
      );

      _horasTypeList.add(
        HorasType.diferencial,
      );
    }
    _pos = _horasTypeList.indexOf(widget.horasType);

    super.initState();
  }

  Color? _getColor(int pos) {
    if (_pos == pos) {
      switch (pos) {
        case 0:
          return ExtraColors.porcNormalColor;
        case 1:
          return ExtraColors.porcFeriadosColor;
        case 2:
          return widget.diferencial?.color ?? ExtraColors.porcDiferenciadaColor;
        default:
          return null;
      }
    }

    return null;
  }

  void _onTap(int index) {
    setState(() {
      _pos = index;
    });

    widget.onSelectionChanged(
      _horasTypeList[index],
    );
  }

  BorderRadius _getBorderRadius(int index) {
    switch (index) {
      case 0:
        return const BorderRadius.only(
          topLeft: Radius.circular(8),
          bottomLeft: Radius.circular(8),
        );

      case 1:
        return widget.diferencial != null
            ? BorderRadius.zero
            : const BorderRadius.only(
                topRight: Radius.circular(8),
                bottomRight: Radius.circular(8),
              );

      case 2:
        return const BorderRadius.only(
          topRight: Radius.circular(8),
          bottomRight: Radius.circular(8),
        );

      default:
        return BorderRadius.zero;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Row(
      children: List.generate(_labels.length, (index) {
        return Expanded(
          child: Material(
            elevation: .1,
            borderRadius: _getBorderRadius(index),            
            child: Ink(
              height: 40,
              decoration: BoxDecoration(
                color: _getColor(index) ?? context.colors.surface,
                border: Border.all(color: colors.primaryFixed, width: 1),
                borderRadius: _getBorderRadius(index),
              ),
              child: InkWell(
                onTap: () => _onTap(index),
                borderRadius: _getBorderRadius(index),

                child: Center(
                  child: Text(
                    _labels[index],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: index == _pos
                          ? context.colors.onPrimary
                          : context.colors.onSurface,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
