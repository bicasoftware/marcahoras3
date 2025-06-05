import 'package:flutter/material.dart';

class ShColorPicker extends StatefulWidget {
  final Color initialColor;
  final Function(Color) onColorSelected;

  const ShColorPicker({
    Key? key,
    required this.initialColor,
    required this.onColorSelected,
  }) : super(key: key);

  @override
  _ShColorPickerState createState() => _ShColorPickerState();
}

class _ShColorPickerState extends State<ShColorPicker> {
  late Color _currentColor;

  final List<Color> _colorOptions = [
    Colors.red,
    Colors.pink,
    Colors.purple,
    Colors.deepPurple,
    Colors.indigo,
    Colors.blue,
    Colors.lightBlue,
    Colors.cyan,
    Colors.teal,
    Colors.green,
    Colors.lightGreen,
    Colors.lime,
    Colors.yellow,
    Colors.amber,
    Colors.orange,
    Colors.deepOrange,
    Colors.brown,
    Colors.grey,
    Colors.blueGrey,
    Colors.black,
    Colors.white,
    Colors.redAccent,
    Colors.greenAccent,
    Colors.blueAccent,
    Colors.purpleAccent,
  ];

  @override
  void initState() {
    super.initState();
    _currentColor = widget.initialColor;
  }

  void _showColorPicker() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: GridView.builder(
              shrinkWrap: true,
              itemCount: _colorOptions.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                final color = _colorOptions[index];
                return GestureDetector(
                  onTap: () {
                    setState(() => _currentColor = color);
                    widget.onColorSelected(color);
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black26),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        padding: EdgeInsets.zero,
      ),
      onPressed: _showColorPicker,
      child: Container(
        width: 64,
        height: 64,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.black26),
        ),
        child: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: _currentColor,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}
