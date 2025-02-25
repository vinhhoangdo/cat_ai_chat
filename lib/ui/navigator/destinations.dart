import 'package:flutter/material.dart';

class Destination {
  final IconData icon;
  final String label;

  const Destination({
    required this.icon,
    required this.label,
  });
}

const destinations = [
  Destination(icon: Icons.home_filled, label: 'Home'),
  Destination(icon: Icons.notifications, label: 'Notifications'),
  Destination(icon: Icons.settings, label: 'Settings'),
];
