import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Skill {
  final String name;
  final IconData icon;
  final Color color;

  const Skill({
    required this.name,
    required this.icon,
    required this.color,
  });
}

final List<Skill> skills = [
  Skill(
    name: 'Flutter',
    icon: FontAwesomeIcons.mobile,
    color: const Color(0xFF02569B),
  ),
  Skill(
    name: 'Dart',
    icon: FontAwesomeIcons.code,
    color: const Color(0xFF0175C2),
  ),
  Skill(
    name: 'Firebase',
    icon: FontAwesomeIcons.fire,
    color: const Color(0xFFFFCA28),
  ),
  Skill(
    name: 'REST APIs',
    icon: FontAwesomeIcons.server,
    color: const Color(0xFF00D9FF),
  ),
  Skill(
    name: 'Node.js',
    icon: FontAwesomeIcons.nodeJs,
    color: const Color(0xFF339933),
  ),
  Skill(
    name: 'MongoDB',
    icon: FontAwesomeIcons.database,
    color: const Color(0xFF47A248),
  ),
  Skill(
    name: 'UI/UX Design',
    icon: FontAwesomeIcons.paintbrush,
    color: const Color(0xFFFF6B9D),
  ),
  Skill(
    name: 'State Management',
    icon: FontAwesomeIcons.layerGroup,
    color: const Color(0xFF6C63FF),
  ),
  Skill(
    name: 'Git & GitHub',
    icon: FontAwesomeIcons.github,
    color: const Color(0xFFFFFFFF),
  ),
  Skill(
    name: 'Figma',
    icon: FontAwesomeIcons.figma,
    color: const Color(0xFFF24E1E),
  ),
  Skill(
    name: 'Agile/Scrum',
    icon: FontAwesomeIcons.peopleGroup,
    color: const Color(0xFF00FF94),
  ),
  Skill(
    name: 'CI/CD',
    icon: FontAwesomeIcons.gear,
    color: const Color(0xFFFF9800),
  ),
];
