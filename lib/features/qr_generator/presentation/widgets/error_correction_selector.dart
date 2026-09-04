import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ErrorCorrectionSelector extends StatelessWidget {
  const ErrorCorrectionSelector({
    super.key,
    required this.selectedLevel,
    required this.onChanged,
  });

  final int selectedLevel;
  final ValueChanged<int> onChanged;

  static const List<(String, int)> _levels = <(String, int)>[
    ('L (~7%)', QrErrorCorrectLevel.L),
    ('M (~15%)', QrErrorCorrectLevel.M),
    ('Q (~25%)', QrErrorCorrectLevel.Q),
    ('H (~30%)', QrErrorCorrectLevel.H),
  ];

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<int>(
      value: selectedLevel,
      decoration: const InputDecoration(
        labelText: 'Error correction level',
        border: OutlineInputBorder(),
      ),
      items: _levels
          .map(
            (level) => DropdownMenuItem<int>(
              value: level.$2,
              child: Text(level.$1),
            ),
          )
          .toList(),
      onChanged: (value) {
        if (value != null) {
          onChanged(value);
        }
      },
    );
  }
}
