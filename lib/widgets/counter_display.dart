import 'package:flutter/material.dart';
import 'package:lab_1/styles/styles.dart';

class CounterDisplay extends StatelessWidget {
  const CounterDisplay({
    required this.value,
    super.key,
  });

  final int value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Лічильник', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 6),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 220),
          child: Text(
            '$value',
            key: ValueKey(value),
            style: counterTextStyle,
          ),
        ),
      ],
    );
  }
}
