import 'package:flutter/material.dart';

class SocialReachItem {
  const SocialReachItem({
    required this.label,
    required this.icon,
    required this.gradient,
    required this.reach,
  });

  final String label;
  final Widget icon;
  final LinearGradient gradient;
  final int reach;
}
