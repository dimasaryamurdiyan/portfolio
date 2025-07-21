// Widget to display individual skill chips.
import 'package:flutter/material.dart';

class SkillChip extends StatelessWidget {
  final String skill;

  const SkillChip({super.key, required this.skill});

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(skill),
      backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
      labelStyle: TextStyle(color: Theme.of(context).colorScheme.onTertiaryContainer),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    );
  }
}