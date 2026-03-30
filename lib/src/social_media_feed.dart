import 'package:flutter/material.dart';

import 'models/social_reach_item.dart';
import 'social_media_pill.dart';

/// A centered row of [SocialMediaPill] widgets.
///
/// Each item is rendered with `progress = reach / 100`. Items with
/// `reach <= 0` are omitted.
class SocialMediaFeed extends StatelessWidget {
  /// Creates a [SocialMediaFeed].
  const SocialMediaFeed({
    super.key,
    required this.items,
    this.padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    this.spacing = 8,
    this.pillStyle = const SocialMediaPillStyle(),
    this.alignment = MainAxisAlignment.center,
  });

  /// Items to render as pills.
  final List<SocialReachItem> items;

  /// Padding around the entire row.
  final EdgeInsetsGeometry padding;

  /// Horizontal spacing between pills.
  final double spacing;

  /// Style used for each [SocialMediaPill].
  final SocialMediaPillStyle pillStyle;

  /// Alignment applied to the row main axis.
  final MainAxisAlignment alignment;

  @override
  /// Builds a horizontal row of visible pills.
  Widget build(BuildContext context) {
    final visible = items.where((e) => e.reach > 0).toList();
    if (visible.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: padding,
      child: Center(
        child: Row(
          mainAxisAlignment: alignment,
          children: [
            for (var i = 0; i < visible.length; i++) ...[
              if (i > 0) SizedBox(width: spacing),
              SocialMediaPill(
                progress: (visible[i].reach / 100).clamp(0.0, 1.0),
                icon: visible[i].icon,
                gradient: visible[i].gradient,
                label: visible[i].label,
                style: pillStyle,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
