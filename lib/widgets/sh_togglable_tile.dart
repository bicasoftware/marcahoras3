import 'package:flutter/material.dart';

import '../utils.dart';
import '../widgets.dart';

class ShTogglableTile extends StatefulWidget {
  final int value;
  final List<int> options;
  final void Function(int v) onChanged;
  final String label;
  final Icon? icon;
  final String Function(int i) formatValue;

  const ShTogglableTile({
    super.key,
    required this.label,
    required this.value,
    required this.options,
    required this.onChanged,
    required this.formatValue,
    this.icon,
  });

  @override
  State<ShTogglableTile> createState() => _ShTogglableTileState();
}

class _ShTogglableTileState extends State<ShTogglableTile> {
  var _items = <bool>[];
  late int _selected;

  @override
  void initState() {
    super.initState();
    _selected = widget.value;
    _items = widget.options.map((it) => it == _selected).toList();
  }

  void onItemSelected(int option) {
    setState(() {
      _items = _items.map((it) => false).toList();
      _items[option] = true;
    });
    widget.onChanged(option);
  }

  @override
  Widget build(BuildContext context) {
    return IndicatorTile(
      child: ListTile(
        leading: widget.icon,
        title: Text(
          widget.label,
          textAlign: TextAlign.left,
          style: context.textTheme.labelLarge,
        ),
        subtitle: Row(
          children: [
            Expanded(
              child: ToggleButtons(
                children: widget.options
                    .map(
                      (h) => Expanded(
                        child: Expanded(child: Text(widget.formatValue(h))),
                      ),
                    )
                    .toList(),
                isSelected: _items,
                constraints: const BoxConstraints(
                  minHeight: 32.0,
                  minWidth: 56.0,
                ),
                onPressed: onItemSelected,
                color: context.colors.secondary,
                fillColor: context.colors.onSurface.withAlpha(40),
                selectedColor: context.colors.onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
