import 'package:flutter/material.dart';

import 'models/social_reach_item.dart';
import 'social_media_pill.dart';

/// A vertical section containing an optional heading, a title, and a row of
/// [SocialMediaPill] widgets.
///
/// Like [SocialMediaFeed], items with `reach <= 0` are omitted. If all items
/// are omitted, this widget returns an empty box.
class SocialMediaReachSection extends StatelessWidget {
  /// Creates a [SocialMediaReachSection].
  const SocialMediaReachSection({
    super.key,
    this.heading,
    this.title = 'Progress',
    required this.items,
    this.padding = EdgeInsets.zero,
    this.headingSpacing = 8,
    this.titleSpacing = 20,
    this.rowSpacing = 6,
    this.pillStyle = SocialMediaPillStyle.socialReach,
    this.headingStyle,
    this.titleStyle,
    this.crossAxisAlignment = CrossAxisAlignment.start,
  });

  /// Optional heading displayed above [title].
  final String? heading;

  /// Title displayed below [heading].
  final String title;

  /// Items to render as pills.
  final List<SocialReachItem> items;

  /// Padding applied to the section content.
  final EdgeInsetsGeometry padding;

  /// Vertical spacing between [heading] and [title].
  final double headingSpacing;

  /// Vertical spacing between [title] and the pill row.
  final double titleSpacing;

  /// Horizontal spacing between pills in the row.
  final double rowSpacing;

  /// Style used for each [SocialMediaPill].
  final SocialMediaPillStyle pillStyle;

  /// Optional style override for the heading text.
  final TextStyle? headingStyle;

  /// Optional style override for the title text.
  final TextStyle? titleStyle;

  /// Cross axis alignment for the section's column.
  final CrossAxisAlignment crossAxisAlignment;

  @override
  /// Builds the section UI.
  Widget build(BuildContext context) {
    final visible = items.where((e) => e.reach > 0).toList();
    if (visible.isEmpty) {
      return const SizedBox.shrink();
    }

    final theme = Theme.of(context);

    return Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: crossAxisAlignment,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (heading != null) ...[
            Text(
              heading!,
              style: headingStyle ??
                  theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.3,
                  ),
            ),
            SizedBox(height: headingSpacing),
          ],
          Text(
            title,
            style: titleStyle ??
                theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
          ),
          SizedBox(height: titleSpacing),
          Row(
            children: [
              for (var i = 0; i < visible.length; i++) ...[
                if (i > 0) SizedBox(width: rowSpacing),
                Expanded(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.topCenter,
                    child: SocialMediaPill(
                      progress: (visible[i].reach / 100).clamp(0.0, 1.0),
                      icon: visible[i].icon,
                      gradient: visible[i].gradient,
                      label: visible[i].label,
                      style: pillStyle,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
