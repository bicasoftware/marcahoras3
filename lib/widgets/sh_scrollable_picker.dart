import 'package:flutter/material.dart';

import '../utils.dart';

class ShScrollablePicker<T> extends StatefulWidget {
  final List<T> items;
  final T selectedItem;
  final String Function(T item) valueFormatter;
  final void Function(int pos) onItemSelected;

  const ShScrollablePicker({
    required this.items,
    required this.selectedItem,
    required this.onItemSelected,
    required this.valueFormatter,
    super.key,
  });

  @override
  State<ShScrollablePicker> createState() => _ShScrollablePickerState<T>();
}

class _ShScrollablePickerState<T> extends State<ShScrollablePicker> {
  late T _selectedItem = widget.selectedItem;
  late T _lastSelectedItem = widget.selectedItem;

  late final _controller = FixedExtentScrollController(
    initialItem: widget.items.indexOf(widget.selectedItem),
  );

  bool _isSelectedItem(int pos) {
    return widget.items.indexOf(_selectedItem) == pos;
  }

  void setSelectedItem(int pos) {
    setState(() => _selectedItem = widget.items[pos]);
    widget.onItemSelected(pos);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListWheelScrollView.useDelegate(
      itemExtent: 32,
      useMagnifier: true,
      diameterRatio: 2,
      magnification: 1.1,
      onSelectedItemChanged: (pos) {
        if (_lastSelectedItem != pos) {
          setSelectedItem(pos);
        }
      },
      physics: FixedExtentScrollPhysics(),
      overAndUnderCenterOpacity: 0.3,
      controller: _controller,
      childDelegate: ListWheelChildBuilderDelegate(
        childCount: widget.items.length,
        builder: (_, int i) {
          return _PickerItem<T>(
            value: widget.items[i],
            isSelected: _isSelectedItem(i),
            valueFormatter: widget.valueFormatter,
          );
        },
      ),
    );
  }
}

class _PickerItem<T> extends StatelessWidget {
  final T value;
  final bool isSelected;
  final String Function(T item) valueFormatter;

  const _PickerItem({
    required this.value,
    required this.isSelected,
    required this.valueFormatter,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: .all(2),
      child: Text(
        valueFormatter(value),
        style: context.textTheme.titleSmall?.copyWith(
          color: isSelected
              ? context.colors.onSurface
              : context.colors.onSurface,
          fontSize: isSelected ? 25 : 20,
        ),
      ),
    );
  }
}
