import 'package:flutter/material.dart';
import 'package:marcahoras3/widgets.dart';

class ShTogglableTile extends StatefulWidget {
  final int value;
  final List<int> options;
  final void Function(int v) onChanged;
  final String label;
  final Icon? icon;

  const ShTogglableTile({
    super.key,
    required this.label,
    required this.value,
    required this.options,
    required this.onChanged,
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
    final theme = Theme.of(context).textTheme;
    return IndicatorTile(
      child: ListTile(
        leading: widget.icon,
        title: Text(
          widget.label,
          textAlign: TextAlign.left,
          style: theme.labelLarge,
        ),
        subtitle: ToggleButtons(
          children: widget.options.map((h) => Text(h.toString())).toList(),
          isSelected: _items,
          constraints: const BoxConstraints(minHeight: 32.0, minWidth: 56.0),
          onPressed: onItemSelected,
        ),
      ),
    );
  }
}
