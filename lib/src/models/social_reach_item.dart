import 'package:flutter/material.dart';

/// A single labeled "reach" item (typically a percent value).
///
/// Used by [SocialMediaFeed] and [SocialMediaReachSection] to render one pill.
class SocialReachItem {
  /// Creates a [SocialReachItem].
  ///
  /// The [reach] value is expected to be a percent in the range `0..100`.
  const SocialReachItem({
    required this.label,
    required this.icon,
    required this.gradient,
    required this.reach,
  });

  /// Text displayed (and spoken) for the pill.
  final String label;

  /// Widget rendered as the pill icon (e.g. [Icon] or an SVG widget).
  final Widget icon;

  /// Gradient painted inside the pill wave.
  final LinearGradient gradient;

  /// Percent value used to compute the wave fill. Items with `reach <= 0`
  /// are omitted by the row widgets.
  final int reach;
}
