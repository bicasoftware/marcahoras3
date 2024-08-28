import 'package:flutter/material.dart';

import '../resources/colors.dart';
import '../widgets.dart';

class ShToggleOptions extends StatefulWidget {
  final List<String> items;
  final String selectedItem;
  final ValueChanged<String> onChanged;
  final String label;

  const ShToggleOptions({
    required this.items,
    required this.selectedItem,
    required this.onChanged,
    required this.label,
    super.key,
  });

  @override
  State<ShToggleOptions> createState() => _ShToggleOptionsState();
}

class _ShToggleOptionsState extends State<ShToggleOptions> {
  late List<bool> _selectedItems;

  int get _itemIndex => widget.items.indexOf(widget.selectedItem);

  void _fillSelectedItems(int index) {
    _selectedItems = List<bool>.filled(
      widget.items.length,
      false,
      growable: false,
    )..[index] = true;
  }

  @override
  void initState() {
    super.initState();
    final index = _itemIndex;
    _fillSelectedItems(index);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return IndicatorTile(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
            child: Text(
              widget.label,
              textAlign: TextAlign.left,
              style: theme.labelLarge,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, bottom: 16),
            child: ToggleButtons(
              children:
                  widget.items.map((e) => _ToggleItem(value: e)).toList(),
              isSelected: _selectedItems,
              selectedColor: Colors.white,
              selectedBorderColor: AppColors.primary,
              borderColor: AppColors.onBackground,              
              onPressed: (i) {
                setState(() => _fillSelectedItems(i));
                widget.onChanged(widget.items[_itemIndex]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ToggleItem extends StatelessWidget {
  final String value;

  const _ToggleItem({
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final w = (MediaQuery.of(context).size.width - 58) / 4;
    return Container(
      child: Text(
        value,
        textAlign: TextAlign.center,
      ),
      width: w,
    );
  }
}
