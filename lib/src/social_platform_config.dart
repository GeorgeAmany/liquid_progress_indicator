import 'package:flutter/material.dart';

import 'models/social_reach_item.dart';

/// Static label, icon, and gradient for a platform key (used with [buildSocialReachItems]).
class SocialPlatformConfig {
  const SocialPlatformConfig({
    required this.label,
    required this.icon,
    required this.gradient,
  });

  final String label;
  final Widget icon;
  final LinearGradient gradient;
}

/// Merges [reachByPlatformKey] with [configByPlatformKey]. Unknown keys are skipped.
List<SocialReachItem> buildSocialReachItems({
  required Map<String, int> reachByPlatformKey,
  required Map<String, SocialPlatformConfig> configByPlatformKey,
}) {
  final list = <SocialReachItem>[];
  for (final e in reachByPlatformKey.entries) {
    final c = configByPlatformKey[e.key];
    if (c == null) continue;
    list.add(SocialReachItem(
      label: c.label,
      icon: c.icon,
      gradient: c.gradient,
      reach: e.value,
    ));
  }
  return list;
}
