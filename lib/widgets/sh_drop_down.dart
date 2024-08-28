import 'package:flutter/material.dart';
import 'package:marcahoras3/widgets.dart';

class ShDropDownButton extends StatefulWidget {
  final int value;
  final List<int> options;
  final void Function(int v) onChanged;
  final String label;
  final Icon? icon;

  const ShDropDownButton({
    super.key,
    required this.label,
    required this.value,
    required this.options,
    required this.onChanged,
    this.icon,
  });

  @override
  State<ShDropDownButton> createState() => _ShDropDownButtonState();
}

class _ShDropDownButtonState extends State<ShDropDownButton> {
  late final List<DropdownMenuItem<int>> _items;
  int _selected = 0;

  @override
  void initState() {
    super.initState();
    _selected = widget.value;
    _items = widget.options
        .map(
          (int e) => DropdownMenuItem<int>(
            value: e,
            child: Text(e.toString()),
          ),
        )
        .toList();
  }

  void onItemSelected(int option) {
    setState(() => _selected = option);

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
        subtitle: DropdownButtonHideUnderline(
          child: DropdownButton<int>(
            items: _items,
            value: _selected,
            onChanged: (int? v) {
              if (v != null) onItemSelected(v);
            },
            
          ),
        ),
      ),      
    );
  }
}
