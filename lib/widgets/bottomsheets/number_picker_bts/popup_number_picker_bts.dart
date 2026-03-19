import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../../../utils.dart';
import '../../../widgets.dart';
import 'number_field_def.dart';

Future<T?> showPopupNumberPickerBts<T>({
  required BuildContext context,
  required String titleMsg,
  required List<NumberFieldDef> fields,
  required T Function(List<String> values) formatValue,

  String? okLabel,
  String? cancelLabel,
}) async {
  final GlobalKey<_PopupNumberFieldBtsState> _sheetKey = GlobalKey();

  return await BottomSheetHelper.showModalBts(
    context: context,
    dismissible: true,
    showDragHandle: true,
    title: findText(titleMsg),
    body: Container(
      padding: .only(left: 24, right: 24),      
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 16,
        children: [
          _PopupNumberFieldBts(
            key: _sheetKey,
            fields: fields,
            formatValue: formatValue,
          ),
          ShFormButton.save(
            () {
              if (_sheetKey.currentState?.validForm() ?? false) {
                final result = _sheetKey.currentState?.getResult();
                Navigator.of(context).pop(result);
              }
            },
          ),
        ],
      ),
    ),
  );
}

class _PopupNumberFieldBts<T> extends StatefulWidget {
  final List<NumberFieldDef> fields;
  final T Function(List<String> values) formatValue;

  const _PopupNumberFieldBts({
    super.key,
    required this.fields,
    required this.formatValue,
  });

  @override
  _PopupNumberFieldBtsState createState() => _PopupNumberFieldBtsState();
}

class _PopupNumberFieldBtsState extends State<_PopupNumberFieldBts> {
  late List<String?> _selectedValues;
  final _key = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    _selectedValues = widget.fields.map((it) {
      return it.initialValue.toString().padLeft(it.maxLength, '0');
    }).toList();
  }

  bool validForm() => _key.currentState?.validate() ?? false;

  T? getResult<T>() {
    return widget.formatValue(
      _selectedValues.map((v) => v ?? '').toList(),
    );
  }

  List<DropdownMenuItem<String>> _buildItems(NumberFieldDef f) {
    final items = <DropdownMenuItem<String>>[];
    int i = f.min;
    while (i <= f.max) {
      final val = i.toString().padLeft(f.maxLength, '0');
      items.add(
        DropdownMenuItem<String>(
          value: val,
          child: Center(child: ShFormLabel.subtitle(val)),
        ),
      );
      i += f.step;
    }

    return items;
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Form(
      key: _key,
      child: Material(
        color: colors.surfaceContainerLow,
        child: Container(
          padding: .all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: context.colors.primaryFixed,
              width: 2,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            spacing: 8,
            children: widget.fields.mapIndexed((i, f) {
              return Expanded(
                child: Column(
                  spacing: 8,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: context.colors.surface,
                        border: Border.all(
                          color: context.colors.primary.withAlpha(20),
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: _selectedValues[i],
                          isExpanded: true,
                          items: _buildItems(f),
                          onChanged: (v) {
                            setState(() {
                              _selectedValues[i] = v;
                            });
                          },
                        ),
                      ),
                    ),
                    ShFormLabel.subtitle(f.label),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
