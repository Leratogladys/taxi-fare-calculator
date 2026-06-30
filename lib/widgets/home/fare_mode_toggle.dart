import 'package:flutter/material.dart';
import '../mode_switcher.dart';

enum FareMode { normal, reverse }

class FareModeToggle extends StatelessWidget {
  final FareMode mode;
  final void Function(FareMode) onChanged;

  const FareModeToggle({
    super.key,
    required this.mode,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ModeSwitcher(
      options: const ['Calculate', 'Reverse'],
      selectedIndex: mode == FareMode.normal ? 0 : 1,
      onChanged: (i) => onChanged(i == 0 ? FareMode.normal : FareMode.reverse),
    );
  }
}
