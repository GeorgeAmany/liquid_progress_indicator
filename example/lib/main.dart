import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

import 'agency_branding.dart';

void main() => runApp(const LiquidProgressIndicatorExampleApp());

class LiquidProgressIndicatorExampleApp extends StatelessWidget {
  const LiquidProgressIndicatorExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'liquid_progress_indicator example',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF00897B),
          brightness: Brightness.light,
        ),
        sliderTheme: SliderThemeData(
          overlayShape: SliderComponentShape.noOverlay,
          trackHeight: 4,
          thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 14),
          activeTrackColor: const Color(0xFF00695C),
          inactiveTrackColor: const Color(0xFFB2DFDB),
          thumbColor: const Color(0xFF00897B),
        ),
      ),
      home: const DemoPage(),
    );
  }
}

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});

  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  int _instagramReach = 62;
  int _tiktokReach = 38;
  int _facebookReach = 68;
  int _snapchatReach = 30;

  static const SocialMediaPillStyle _pillStyle = SocialMediaPillStyle(
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

  List<SocialReachItem> get _socialItems => [
        SocialReachItem(
          label: 'Instagram',
          reach: _instagramReach.clamp(0, 100),
          icon: AgencyAssets.reachSvg(AgencyAssets.instagramReach),
          gradient: AgencyColors.instagramGradient,
        ),
        SocialReachItem(
          label: 'TikTok',
          reach: _tiktokReach.clamp(0, 100),
          icon: AgencyAssets.reachSvg(AgencyAssets.tiktokReach),
          gradient: AgencyColors.tiktokGradient,
        ),
        SocialReachItem(
          label: 'Facebook',
          reach: _facebookReach.clamp(0, 100),
          icon: AgencyAssets.reachSvg(AgencyAssets.facebookReach),
          gradient: AgencyColors.facebookGradient,
        ),
        SocialReachItem(
          label: 'Snapchat',
          reach: _snapchatReach.clamp(0, 100),
          icon: AgencyAssets.reachSvg(AgencyAssets.snapchatReach),
          gradient: AgencyColors.snapchatGradient,
        ),
      ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final visible = _socialItems.where((e) => e.reach > 0).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
          children: [
            Text(
              'Liquid Progress Indicator',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w800,
                letterSpacing: -0.3,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Social Media Reach',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                for (var i = 0; i < visible.length; i++) ...[
                  if (i > 0) const SizedBox(width: 6),
                  Expanded(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.topCenter,
                      child: SocialMediaPill(
                        progress: (visible[i].reach / 100).clamp(0.0, 1.0),
                        icon: visible[i].icon,
                        gradient: visible[i].gradient,
                        label: visible[i].label,
                        style: _pillStyle,
                      ),
                    ),
                  ),
                ],
              ],
            ),
            const SizedBox(height: 24),
            ExpansionTile(
              tilePadding: EdgeInsets.zero,
              title: Text(
                'Adjust values (for GIF / testing)',
                style: theme.textTheme.titleSmall?.copyWith(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              childrenPadding: const EdgeInsets.only(bottom: 8),
              children: [
                _ReachSlider(
                  label: 'Instagram',
                  value: _instagramReach,
                  onChanged: (v) => setState(() => _instagramReach = v),
                ),
                _ReachSlider(
                  label: 'TikTok',
                  value: _tiktokReach,
                  onChanged: (v) => setState(() => _tiktokReach = v),
                ),
                _ReachSlider(
                  label: 'Facebook',
                  value: _facebookReach,
                  onChanged: (v) => setState(() => _facebookReach = v),
                ),
                _ReachSlider(
                  label: 'Snapchat',
                  value: _snapchatReach,
                  onChanged: (v) => setState(() => _snapchatReach = v),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ReachSlider extends StatelessWidget {
  const _ReachSlider({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final int value;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('$label · $value%'),
        Slider(
          value: value.toDouble(),
          min: 0,
          max: 100,
          divisions: 100,
          label: '$value%',
          onChanged: (v) => onChanged(v.round()),
        ),
      ],
    );
  }
}
