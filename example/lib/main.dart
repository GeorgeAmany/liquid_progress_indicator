import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

void main() {
  runApp(const LiquidProgressIndicatorExampleApp());
}

class LiquidProgressIndicatorExampleApp extends StatelessWidget {
  const LiquidProgressIndicatorExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'liquid_progress_indicator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF6750A4)),
        useMaterial3: true,
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
  /// Drives the feed’s Instagram column (0–100).
  double _instagramReach = 72;

  /// Standalone pill progress (0.0–1.0).
  double _singleProgress = 0.62;

  static final Map<String, SocialPlatformConfig> _platformUi = {
    'instagram': SocialPlatformConfig(
      label: 'Instagram',
      icon: Icon(Icons.camera_alt, color: Colors.white, size: 22),
      gradient: LinearGradient(
        colors: [
          Color(0xFFF58529),
          Color(0xFFDD2A7B),
          Color(0xFF8134AF),
        ],
      ),
    ),
    'tiktok': SocialPlatformConfig(
      label: 'TikTok',
      icon: Icon(Icons.music_note, color: Colors.white, size: 22),
      gradient: LinearGradient(
        colors: [Color(0xFF00F2EA), Color(0xFFFF0050)],
      ),
    ),
    'facebook': SocialPlatformConfig(
      label: 'Facebook',
      icon: Icon(Icons.facebook, color: Colors.white, size: 22),
      gradient: LinearGradient(
        colors: [Color(0xFF1877F2), Color(0xFF0C63D4)],
      ),
    ),
    'snapchat': SocialPlatformConfig(
      label: 'Snapchat',
      icon: Icon(Icons.circle, color: Colors.white, size: 22),
      gradient: LinearGradient(
        colors: [Color(0xFFFFFC00), Color(0xFFFF9000)],
      ),
    ),
  };

  Map<String, int> get _reachMap => {
        'instagram': _instagramReach.round().clamp(0, 100),
        'tiktok': 45,
        'facebook': 88,
        'snapchat': 0,
      };

  @override
  Widget build(BuildContext context) {
    final feedItems = buildSocialReachItems(
      reachByPlatformKey: _reachMap,
      configByPlatformKey: _platformUi,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('liquid_progress_indicator example'),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
        children: [
          Text(
            'Package demo',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text(
            'Use sliders to see live updates. Snapchat has reach 0 and stays hidden.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
          ),
          const SizedBox(height: 24),
          _SectionTitle(context, 'SocialMediaFeed + buildSocialReachItems'),
          const SizedBox(height: 8),
          Card(
            margin: EdgeInsets.zero,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: SocialMediaFeed(items: feedItems),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Instagram reach (feed)',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          Slider(
            value: _instagramReach,
            min: 0,
            max: 100,
            divisions: 100,
            label: '${_instagramReach.round()}%',
            onChanged: (v) => setState(() => _instagramReach = v),
          ),
          const SizedBox(height: 32),
          _SectionTitle(context, 'SocialMediaPill (single)'),
          const SizedBox(height: 8),
          Card(
            margin: EdgeInsets.zero,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: SocialMediaPill(
                  progress: _singleProgress,
                  label: 'Hydration',
                  icon: const Icon(Icons.water_drop, color: Colors.white),
                  gradient: const LinearGradient(
                    colors: [Color(0xFF4FC3F7), Color(0xFF0288D1)],
                  ),
                  style: const SocialMediaPillStyle(
                    width: 88,
                    height: 64,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Progress 0.0–1.0',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          Slider(
            value: _singleProgress,
            min: 0,
            max: 1,
            divisions: 100,
            label: '${(_singleProgress * 100).round()}%',
            onChanged: (v) => setState(() => _singleProgress = v),
          ),
          const SizedBox(height: 24),
          Text(
            'See the package README on pub.dev for copy-paste snippets and API table.',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.outline,
                ),
          ),
        ],
      ),
    );
  }
}

Widget _SectionTitle(BuildContext context, String text) {
  return Text(
    text,
    style: Theme.of(context).textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w600,
        ),
  );
}
