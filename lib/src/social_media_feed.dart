import 'package:flutter/material.dart';

import 'models/social_reach_item.dart';
import 'social_media_pill.dart';

/// Centered row of [SocialMediaPill]s for items with [SocialReachItem.reach] &gt; 0.
class SocialMediaFeed extends StatelessWidget {
  const SocialMediaFeed({
    super.key,
    required this.items,
    this.padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    this.spacing = 8,
    this.pillStyle = const SocialMediaPillStyle(),
    this.alignment = MainAxisAlignment.center,
  });

  final List<SocialReachItem> items;
  final EdgeInsetsGeometry padding;
  final double spacing;
  final SocialMediaPillStyle pillStyle;
  final MainAxisAlignment alignment;

  @override
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
