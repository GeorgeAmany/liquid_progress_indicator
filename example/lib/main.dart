import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

import 'sample_data.dart';

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
  static final Map<String, SocialPlatformConfig> _configByKey = {
    'instagram': SocialPlatformConfig(
      label: 'Instagram',
      icon: SampleAssets.svg(SampleAssets.instagramReach),
      gradient: SampleGradients.instagram,
    ),
    'tiktok': SocialPlatformConfig(
      label: 'TikTok',
      icon: SampleAssets.svg(SampleAssets.tiktokReach),
      gradient: SampleGradients.tiktok,
    ),
    'facebook': SocialPlatformConfig(
      label: 'Facebook',
      icon: SampleAssets.svg(SampleAssets.facebookReach),
      gradient: SampleGradients.facebook,
    ),
    'snapchat': SocialPlatformConfig(
      label: 'Snapchat',
      icon: SampleAssets.svg(SampleAssets.snapchatReach),
      gradient: SampleGradients.snapchat,
    ),
  };

  int _instagramReach = 98;
  int _tiktokReach = 32;
  int _facebookReach = 85;
  int _snapchatReach = 27;

  List<SocialReachItem> get _reachItems => buildSocialReachItems(
    reachByPlatformKey: {
      'instagram': _instagramReach.clamp(0, 100),
      'tiktok': _tiktokReach.clamp(0, 100),
      'facebook': _facebookReach.clamp(0, 100),
      'snapchat': _snapchatReach.clamp(0, 100),
    },
    configByPlatformKey: _configByKey,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
          children: [
            SocialMediaReachSection(
              heading: 'Liquid Progress Indicator',
              title: 'Social Media Reach',
              items: _reachItems,
            ),
            const SizedBox(height: 24),
            ExpansionTile(
              tilePadding: EdgeInsets.zero,
              title: Text(
                'Adjust values',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
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
