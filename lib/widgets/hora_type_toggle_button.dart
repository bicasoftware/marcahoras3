import 'package:flutter/material.dart';
import 'package:marcahoras3/resources/colors.dart';
import 'package:marcahoras3/utils.dart';

import '../domain_layer/models.dart';

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
    _pos = _horasTypeList.indexOf(widget.horasType);
    if (widget.diferencial != null) {
      _labels.add(
        Localiza.find('diferencial'),
      );

      _horasTypeList.add(
        HorasType.diferencial,
      );
    }
    super.initState();
  }

  Color _getColor(int pos) {
    if (_pos == pos) {
      switch (pos) {
        case 0:
          return AppColors.porcNormalColor;
        case 1:
          return AppColors.porcFeriadosColor;
        case 2:
          return widget.diferencial?.color ?? AppColors.porcDiferenciadaColor;
        default:
          return Colors.white;
      }
    }

    return Colors.white;
  }

  Color _getLabelColor(int pos) {
    return pos == _pos ? AppColors.onPrimary : AppColors.onSurface;
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
    if (index == 0) {
      return const BorderRadius.only(
        topLeft: Radius.circular(8),
        bottomLeft: Radius.circular(8),
      );
    } else if (index == 2) {
      return const BorderRadius.only(
        topRight: Radius.circular(8),
        bottomRight: Radius.circular(8),
      );
    }
    return BorderRadius.zero;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(_labels.length, (index) {
        return Expanded(
          child: GestureDetector(
            onTap: () => _onTap(index),
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                color: _getColor(index),
                border: Border.all(color: Colors.black26, width: 1),
                borderRadius: _getBorderRadius(index),
              ),
              alignment: Alignment.center,
              child: Text(
                _labels[index],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: _getLabelColor(index),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
