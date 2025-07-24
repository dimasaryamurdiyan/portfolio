// Widget to display individual skill chips.
import 'package:flutter/material.dart';

class SkillChip extends StatelessWidget {
  final String skill;

  const SkillChip({super.key, required this.skill});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Chip(
      label: Text(skill),
      backgroundColor: theme.colorScheme.surface,
      labelStyle: TextStyle(color: theme.colorScheme.onSurface),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    );
  }
}