import 'package:flutter/material.dart';

import 'models/social_reach_item.dart';

/// Visual configuration for a single reach key used by
/// [buildSocialReachItems].
class SocialPlatformConfig {
  /// Creates a [SocialPlatformConfig] for a given key.
  const SocialPlatformConfig({
    required this.label,
    required this.icon,
    required this.gradient,
  });

  /// Text label used to build [SocialReachItem] objects.
  final String label;

  /// Widget rendered as the pill icon.
  final Widget icon;

  /// Gradient used to fill the pill wave.
  final LinearGradient gradient;
}

/// Builds a list of [SocialReachItem] from two maps:
/// `reachByPlatformKey` (percent ints) and `configByPlatformKey`
/// ([SocialPlatformConfig] per key).
///
/// Keys present in `reachByPlatformKey` but missing in `configByPlatformKey`
/// are ignored.
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

