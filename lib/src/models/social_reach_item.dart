import 'package:flutter/material.dart';

/// One platform or metric for [SocialMediaFeed] / [buildSocialReachItems].
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

  /// Whole percent (typically 0–100). Displayed as fill height; values are clamped when drawn.
  final int reach;
}
