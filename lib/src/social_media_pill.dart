import 'dart:math' as math;

import 'package:flutter/material.dart';

/// Layout and animation parameters for [SocialMediaPill].
class SocialMediaPillStyle {
  /// Creates a [SocialMediaPillStyle].
  const SocialMediaPillStyle({
    this.width = 72,
    this.height = 56,
    this.outerBorderRadius = 12,
    this.innerBorderRadius = 10,
    this.shadowBlur = 8,
    this.shadowOffset = const Offset(0, 4),
    this.shadowColor = const Color(0x4DFFFFFF),
    this.backgroundColor,
    this.iconTop = 8,
    this.iconHorizontalInset = 6,
    this.iconHeight = 22,
    this.percentLeft = 24,
    this.percentBottom = 6,
    this.percentFontSize = 14,
    this.percentTextColor = const Color(0xDE000000),
    this.waveDuration = const Duration(milliseconds: 1600),
    this.percentTweenDuration = const Duration(milliseconds: 800),
    this.centerPercentText = false,
  });

  /// Width of the pill widget in logical pixels.
  final double width;

  /// Height of the pill widget in logical pixels.
  final double height;

  /// Radius for the outer pill border.
  final double outerBorderRadius;

  /// Radius for the inner (animated wave) border.
  final double innerBorderRadius;

  /// Blur applied to the pill drop shadow.
  final double shadowBlur;

  /// Offset applied to the pill drop shadow.
  final Offset shadowOffset;

  /// Color of the pill drop shadow.
  final Color shadowColor;

  /// Optional background fill color. If null, a light gray is used.
  final Color? backgroundColor;

  /// Distance from the pill top to the icon.
  final double iconTop;

  /// Horizontal inset for the icon container.
  final double iconHorizontalInset;

  /// Icon container height.
  final double iconHeight;

  /// Left inset for the percent text when [centerPercentText] is false.
  final double percentLeft;

  /// Distance from the bottom to the percent text.
  final double percentBottom;

  /// Font size for the percent text.
  final double percentFontSize;

  /// Text color for the percent label.
  final Color percentTextColor;

  /// Total duration of the looping wave animation.
  final Duration waveDuration;

  /// Duration used for tweening the displayed percent value.
  final Duration percentTweenDuration;

  /// Whether the percent text is centered at the bottom of the pill.
  final bool centerPercentText;

  /// Returns a copy of this style with the provided fields replaced.
  SocialMediaPillStyle copyWith({
    double? width,
    double? height,
    double? outerBorderRadius,
    double? innerBorderRadius,
    double? shadowBlur,
    Offset? shadowOffset,
    Color? shadowColor,
    Color? backgroundColor,
    double? iconTop,
    double? iconHorizontalInset,
    double? iconHeight,
    double? percentLeft,
    double? percentBottom,
    double? percentFontSize,
    Color? percentTextColor,
    Duration? waveDuration,
    Duration? percentTweenDuration,
    bool? centerPercentText,
  }) {
    return SocialMediaPillStyle(
      width: width ?? this.width,
      height: height ?? this.height,
      outerBorderRadius: outerBorderRadius ?? this.outerBorderRadius,
      innerBorderRadius: innerBorderRadius ?? this.innerBorderRadius,
      shadowBlur: shadowBlur ?? this.shadowBlur,
      shadowOffset: shadowOffset ?? this.shadowOffset,
      shadowColor: shadowColor ?? this.shadowColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      iconTop: iconTop ?? this.iconTop,
      iconHorizontalInset: iconHorizontalInset ?? this.iconHorizontalInset,
      iconHeight: iconHeight ?? this.iconHeight,
      percentLeft: percentLeft ?? this.percentLeft,
      percentBottom: percentBottom ?? this.percentBottom,
      percentFontSize: percentFontSize ?? this.percentFontSize,
      percentTextColor: percentTextColor ?? this.percentTextColor,
      waveDuration: waveDuration ?? this.waveDuration,
      percentTweenDuration: percentTweenDuration ?? this.percentTweenDuration,
      centerPercentText: centerPercentText ?? this.centerPercentText,
    );
  }

  /// Tall preset intended for social reach dashboards.
  static const SocialMediaPillStyle socialReach = SocialMediaPillStyle(
    width: 74,
    height: 124,
    outerBorderRadius: 20,
    innerBorderRadius: 16,
    iconTop: 14,
    iconHorizontalInset: 10,
    iconHeight: 28,
    percentBottom: 12,
    percentFontSize: 15,
    shadowBlur: 12,
    shadowOffset: Offset(0, 6),
    shadowColor: Color(0x1A000000),
    centerPercentText: true,
  );
}

/// A pill-shaped animated progress indicator with a liquid wave fill.
class SocialMediaPill extends StatefulWidget {
  /// Creates a [SocialMediaPill].
  ///
  /// The [progress] value is expected to be in the range `0.0..1.0`.
  const SocialMediaPill({
    super.key,
    required this.progress,
    required this.icon,
    required this.gradient,
    required this.label,
    this.style = const SocialMediaPillStyle(),
  });

  /// Progress value used to compute the wave fill (typically `0.0..1.0`).
  final double progress;

  /// Widget rendered as the pill icon.
  final Widget icon;

  /// Gradient painted inside the wave.
  final LinearGradient gradient;

  /// Accessible label used by semantics and displayed as the percent context.
  final String label;

  /// Style applied to layout and animation.
  final SocialMediaPillStyle style;

  @override
  /// Creates the internal state for the animated wave.
  State<SocialMediaPill> createState() => _SocialMediaPillState();
}

class _SocialMediaPillState extends State<SocialMediaPill>
    with SingleTickerProviderStateMixin {
  late AnimationController _waveCtrl;

  @override
  void initState() {
    super.initState();
    _waveCtrl = AnimationController(
      vsync: this,
      duration: widget.style.waveDuration,
    )..repeat();
  }

  @override
  void didUpdateWidget(covariant SocialMediaPill oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.style.waveDuration != widget.style.waveDuration) {
      _waveCtrl.duration = widget.style.waveDuration;
    }
  }

  @override
  void dispose() {
    _waveCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = widget.style;
    final bg = s.backgroundColor ?? Colors.grey.shade100;
    final p = widget.progress.clamp(0.0, 1.0);

    return Semantics(
      label: widget.label,
      value: '${(p * 100).round()}%',
      child: SizedBox(
        width: s.width,
        height: s.height,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              decoration: BoxDecoration(
                color: bg,
                borderRadius: BorderRadius.circular(s.outerBorderRadius),
                boxShadow: [
                  BoxShadow(
                    color: s.shadowColor,
                    blurRadius: s.shadowBlur,
                    offset: s.shadowOffset,
                  ),
                ],
              ),
            ),
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(s.innerBorderRadius),
                child: AnimatedBuilder(
                  animation: _waveCtrl,
                  builder: (context, child) {
                    return CustomPaint(
                      painter: _WavePainter(
                        progress: p,
                        wavePhase: _waveCtrl.value * 2 * math.pi,
                        gradient: widget.gradient,
                      ),
                    );
                  },
                ),
              ),
            ),
            Positioned.fill(
              child: IgnorePointer(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(s.outerBorderRadius),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.white.withValues(alpha: 0.9),
                        Colors.white.withValues(alpha: 0.0),
                      ],
                      stops: const [0, 0.35],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: s.iconTop,
              left: s.iconHorizontalInset,
              right: s.iconHorizontalInset,
              child: SizedBox(
                height: s.iconHeight,
                child: widget.icon,
              ),
            ),
            if (s.centerPercentText)
              Positioned(
                left: 0,
                right: 0,
                bottom: s.percentBottom,
                child: TweenAnimationBuilder<double>(
                  tween: Tween<double>(begin: 0, end: p),
                  duration: s.percentTweenDuration,
                  curve: Curves.easeOutCubic,
                  builder: (context, value, child) {
                    return Text(
                      '${(value * 100).round()}%',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: s.percentFontSize,
                        fontWeight: FontWeight.bold,
                        color: s.percentTextColor,
                      ),
                    );
                  },
                ),
              )
            else
              Positioned(
                left: s.percentLeft,
                bottom: s.percentBottom,
                child: TweenAnimationBuilder<double>(
                  tween: Tween<double>(begin: 0, end: p),
                  duration: s.percentTweenDuration,
                  curve: Curves.easeOutCubic,
                  builder: (context, value, child) {
                    return Text(
                      '${(value * 100).round()}%',
                      style: TextStyle(
                        fontSize: s.percentFontSize,
                        fontWeight: FontWeight.bold,
                        color: s.percentTextColor,
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _WavePainter extends CustomPainter {
  _WavePainter({
    required this.progress,
    required this.wavePhase,
    required this.gradient,
  });

  final double progress;
  final double wavePhase;
  final LinearGradient gradient;

  @override
  void paint(Canvas canvas, Size size) {
    final amplitude = size.height * 0.035;
    final wavelength = size.width / 1.8;
    final baseY = size.height * (1 - progress);

    final shader = gradient.createShader(
      Rect.fromLTWH(0, 0, size.width, size.height),
    );

    final paint = Paint()
      ..style = PaintingStyle.fill
      ..shader = shader;

    final path = Path()..moveTo(0, size.height);

    for (double x = 0; x <= size.width; x++) {
      final dx = x / wavelength * 2 * math.pi;
      final y = baseY + math.sin(dx + wavePhase) * amplitude;
      path.lineTo(x, y);
    }

    path.lineTo(size.width, size.height);
    path.close();

    canvas.drawPath(path, paint);

    final paint2 = Paint()
      ..shader = shader
      ..colorFilter =
          const ColorFilter.mode(Colors.black26, BlendMode.srcATop);

    final path2 = Path()..moveTo(0, size.height);

    for (double x = 0; x <= size.width; x++) {
      final dx = x / wavelength * 2 * math.pi;
      final y =
          baseY + math.sin(dx + wavePhase + math.pi / 3) * amplitude * 0.6;
      path2.lineTo(x, y);
    }

    path2.lineTo(size.width, size.height);
    path2.close();

    canvas.drawPath(path2, paint2);
  }

  @override
  bool shouldRepaint(covariant _WavePainter old) =>
      old.progress != progress ||
      old.wavePhase != wavePhase ||
      old.gradient != gradient;
}
