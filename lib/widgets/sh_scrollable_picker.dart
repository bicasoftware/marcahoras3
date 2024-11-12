import 'package:flutter/material.dart';

import '../resources.dart';

class ShScrollablePicker<T> extends StatefulWidget {
  final List<T> items;
  final T selectedItem;
  final void Function(int pos) onItemSelected;

  const ShScrollablePicker({
    required this.items,
    required this.selectedItem,
    required this.onItemSelected,
    super.key,
  });

  @override
  State<ShScrollablePicker> createState() => _ShScrollablePickerState();
}

class _ShScrollablePickerState<T> extends State<ShScrollablePicker> {
  late T _selectedItem = widget.selectedItem;

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
    _selectedItem = widget.selectedItem;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListWheelScrollView.useDelegate(
      itemExtent: 32,
      useMagnifier: true,
      diameterRatio: 2,
      magnification: 1.1,
      onSelectedItemChanged: setSelectedItem,
      physics: FixedExtentScrollPhysics(),
      overAndUnderCenterOpacity: 0.5,
      controller: _controller,
      childDelegate: ListWheelChildBuilderDelegate(
        childCount: widget.items.length,
        builder: (c, i) {
          return _PickerItem<T>(
            value: widget.items[i],
            isSelected: _isSelectedItem(i),
          );
        },
      ),
    );
  }
}

class _PickerItem<T> extends StatelessWidget {
  final T value;
  final bool isSelected;

  const _PickerItem({
    required this.value,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return Container(
      margin: EdgeInsets.all(2),
      child: Center(
        child: Text(
          "$value",
          textAlign: TextAlign.center,
          style: theme.titleSmall?.copyWith(
            // fontWeight: FontWeight.bold,
            color: isSelected ? AppColors.secondary : AppColors.onSurface,
          ),
        ),
      ),
    );
  }
}
