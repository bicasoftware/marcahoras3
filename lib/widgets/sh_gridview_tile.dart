import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../utils.dart';

class ShGridviewTile extends StatefulWidget {
  final List<int> items;
  final int initialItem;
  final int axisCount;
  final void Function(int item) onSelected;
  final String Function(int item) formatItem;

  const ShGridviewTile({
    required this.items,
    required this.initialItem,
    required this.onSelected,
    required this.axisCount,
    required this.formatItem,
  });

  @override
  State<ShGridviewTile> createState() => _ShGridviewTileState();
}

class _ShGridviewTileState extends State<ShGridviewTile> {
  late int _selectedItem;

  @override
  void initState() {
    _selectedItem = widget.initialItem;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: widget.axisCount,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 3.1,
      children: widget.items.mapIndexed(
        (int i, int item) {
          return GestureDetector(
            onTap: () {
              _selectedItem = i;
              widget.onSelected(item);
            },
            child: Container(
              width: 100,
              margin: EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: item == _selectedItem
                    ? context.colors.primary.withAlpha(20)
                    : context.colors.surface,
                border: Border.all(
                  color: context.colors.primary.withAlpha(20),
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  widget.formatItem(item),
                  textAlign: TextAlign.center,
                  style: context.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
        },
      ).toList(),
    );
  }
}
