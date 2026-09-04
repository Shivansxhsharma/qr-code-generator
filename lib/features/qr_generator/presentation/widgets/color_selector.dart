import 'package:flutter/material.dart';

class ColorSelector extends StatelessWidget {
  const ColorSelector({
    super.key,
    required this.title,
    required this.selectedColor,
    required this.onColorSelected,
  });

  final String title;
  final Color selectedColor;
  final ValueChanged<Color> onColorSelected;

  static const List<Color> _palette = <Color>[
    Colors.black,
    Colors.white,
    Colors.indigo,
    Colors.blue,
    Colors.red,
    Colors.green,
    Colors.orange,
    Colors.purple,
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleSmall),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _palette
              .map(
                (color) => InkWell(
                  onTap: () => onColorSelected(color),
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: color == selectedColor
                            ? Theme.of(context).colorScheme.primary
                            : Colors.grey.shade400,
                        width: color == selectedColor ? 3 : 1,
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
