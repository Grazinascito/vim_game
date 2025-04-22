// lib/features/game/presentation/widgets/target_sequence_display.dart
import 'package:flutter/material.dart';

class TargetSequenceDisplay extends StatelessWidget {
  final List<String> sequence;
  final int currentIndex;
  final Color defaultColor = Colors.grey[600]!;
  final Color currentTargetColor = Colors.cyanAccent;

  TargetSequenceDisplay({
    required this.sequence,
    required this.currentIndex,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (sequence.isEmpty) {
      return const Text(
        'Select a mode to start!',
        style: TextStyle(color: Colors.grey),
      );
    }

    return Wrap(
      // não queremos uma lista com scroll(rolagem)...
      //TODO: na verdade, eu não quero que quebre a linha, quero que os elementos que não couberem, fiquem hidden.
      spacing: 8.0,
      runSpacing: 4.0,
      alignment: WrapAlignment.center,
      children: List<Widget>.generate(sequence.length, (index) {
        final bool isCurrentTarget = index == currentIndex;
        final String target = sequence[index];

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: isCurrentTarget
                ? currentTargetColor.withOpacity(0.3)
                : Colors.grey[800],
            borderRadius: BorderRadius.circular(4.0),
            border: Border.all(
              color: isCurrentTarget ? currentTargetColor : Colors.transparent,
              width: 1.5,
            ),
          ),
          child: Text(
            _mapTargetToDisplay(target),
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: isCurrentTarget ? FontWeight.bold : FontWeight.normal,
              color: isCurrentTarget ? currentTargetColor : defaultColor,
            ),
          ),
        );
      }),
    );
  }

  String _mapTargetToDisplay(String target) {
    switch (target) {
      case ':':
        return ':';
      case ' ':
        return '␣';
      default:
        return target;
    }
  }
}
