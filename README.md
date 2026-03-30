# liquid_wave_indicator

[![pub package](https://img.shields.io/pub/v/liquid_wave_indicator.svg)](https://pub.dev/packages/liquid_wave_indicator)
[![style: flutter lints](https://img.shields.io/badge/style-flutter__lints-blue.svg)](https://pub.dev/packages/flutter_lints)

Liquid wave fill for percent metrics (0–100 in rows, 0.0–1.0 on a single pill). You provide icons and gradients; only the animation ships with the package.

## Preview

<p align="center">
  <img src="doc/demo.gif" alt="Animated demo: liquid wave pills and sliders" width="300"/>
</p>

## Features

- **`SocialMediaPill`** — one liquid gauge (`progress` 0.0–1.0)
- **`SocialMediaFeed`** / **`SocialMediaReachSection`** — horizontal rows of gauges (section adds optional heading + title)
- **`SocialMediaPillStyle.socialReach`** — tall pill preset for dense rows
- **`buildSocialReachItems`** — merge a `Map<String, int>` (percent values) with a config map
- Semantics: accessibility label + spoken percent

## Installation

```yaml
dependencies:
  liquid_wave_indicator: ^0.2.2
```

```bash
flutter pub get
```

Requires **Flutter** `>=3.16.0` and **Dart** `^3.9.2` (see `pubspec.yaml`).

## Repository layout

| Location | Role |
|----------|------|
| `lib/` | Published package (`SocialMediaPill`, `SocialMediaReachSection`, …) |
| `example/lib/main.dart` | **`buildSocialReachItems`** + **`SocialMediaReachSection`** + sliders |
| `example/lib/sample_data.dart` | Gradients and SVG paths for the example |
| `test/` | Package widget tests |

## Metrics row (section + tall pills)

Optional **`heading`**, section **`title`** (default **`Progress`**), and a full-width row. Override **`title`** for your domain (e.g. `'Weekly goals'`, `'Social Media Reach'`).

```dart
import 'package:flutter/material.dart';
import 'package:liquid_wave_indicator/liquid_wave_indicator.dart';

SocialMediaReachSection(
  heading: 'Dashboard',
  title: 'This week',
  items: [
    SocialReachItem(
      label: 'Workouts',
      reach: 60,
      icon: const Icon(Icons.fitness_center, color: Colors.white),
      gradient: const LinearGradient(
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
        colors: [Color(0xFF2E7D32), Colors.white],
      ),
    ),
    SocialReachItem(
      label: 'Focus',
      reach: 40,
      icon: const Icon(Icons.timer, color: Colors.white),
      gradient: const LinearGradient(
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
        colors: [Color(0xFF1565C0), Colors.white],
      ),
    ),
  ],
);
```

The section hides when every **`reach`** is ≤ 0. Use **`pillStyle`** to change size.

**With maps:**

```dart
final items = buildSocialReachItems(
  reachByPlatformKey: {
    'instagram': 98,
    'tiktok': 32,
    'facebook': 85,
    'snapchat': 27,
  },
  configByPlatformKey: configMap,
);

SocialMediaReachSection(
  heading: 'Liquid Wave Indicator',
  title: 'Social Media Reach',
  items: items,
);
```

## Quick start (centered row)

```dart
import 'package:flutter/material.dart';
import 'package:liquid_wave_indicator/liquid_wave_indicator.dart';

class MetricRowSnippet extends StatelessWidget {
  const MetricRowSnippet({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      SocialReachItem(
        label: 'Hydration',
        reach: 72,
        icon: const Icon(Icons.water_drop, color: Colors.white, size: 22),
        gradient: const LinearGradient(
          colors: [Color(0xFF4FC3F7), Color(0xFF0288D1)],
        ),
      ),
      SocialReachItem(
        label: 'Steps',
        reach: 45,
        icon: const Icon(Icons.directions_walk, color: Colors.white, size: 22),
        gradient: const LinearGradient(
          colors: [Color(0xFF66BB6A), Color(0xFF2E7D32)],
        ),
      ),
    ];

    return SocialMediaFeed(items: items);
  }
}
```

Items with **`reach <= 0`** are omitted.

## Usage

### Values from maps (`buildSocialReachItems`)

Keys are arbitrary (`'north'`, `'premium'`, …). One map holds **int percents**, the other holds **label + icon + gradient** per key.

```dart
import 'package:flutter/material.dart';
import 'package:liquid_wave_indicator/liquid_wave_indicator.dart';

final valuesByKey = {
  'a': 72,
  'b': 45,
  'c': 0, // hidden in the feed
};

final uiByKey = {
  'a': SocialPlatformConfig(
    label: 'Metric A',
    icon: const Icon(Icons.star, color: Colors.white, size: 22),
    gradient: const LinearGradient(colors: [Colors.deepPurple, Colors.purple]),
  ),
  'b': SocialPlatformConfig(
    label: 'Metric B',
    icon: const Icon(Icons.bolt, color: Colors.white, size: 22),
    gradient: const LinearGradient(colors: [Colors.orange, Colors.deepOrange]),
  ),
};

final items = buildSocialReachItems(
  reachByPlatformKey: valuesByKey,
  configByPlatformKey: uiByKey,
);

SocialMediaFeed(items: items);
```

For **SVG** icons, add [`flutter_svg`](https://pub.dev/packages/flutter_svg) and pass `SvgPicture.asset(...)` as `icon`.

### Single pill

```dart
SocialMediaPill(
  progress: 0.75,
  label: 'Storage',
  icon: const Icon(Icons.sd_storage, color: Colors.white),
  gradient: const LinearGradient(
    colors: [Color(0xFF5C6BC0), Color(0xFF3949AB)],
  ),
);
```

### Custom size and timing

```dart
SocialMediaFeed(
  items: items,
  spacing: 10,
  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
  pillStyle: SocialMediaPillStyle(
    width: 80,
    height: 60,
    percentFontSize: 13,
    waveDuration: const Duration(milliseconds: 2000),
    percentTweenDuration: const Duration(milliseconds: 600),
  ),
);
```

## API overview

| Type | Role |
|------|------|
| `SocialMediaPill` | One liquid gauge; `progress` 0.0–1.0 |
| `SocialMediaFeed` | Centered row; skips `reach <= 0` |
| `SocialMediaReachSection` | Heading + title + row; skips if all `reach <= 0` |
| `SocialReachItem` | `label`, `icon`, `gradient`, `reach` (0–100) |
| `SocialPlatformConfig` | Per-key UI for `buildSocialReachItems` |
| `buildSocialReachItems` | Two maps → `List<SocialReachItem>` |
| `SocialMediaPillStyle` | Layout / animation; **`socialReach`** tall preset |

Full API: `dart doc` or [pub.dev](https://pub.dev/packages/liquid_wave_indicator).

## Example

```bash
cd example
flutter pub get
flutter run
```

**`example/`**: `main.dart`, `sample_data.dart`. Defaults **98 / 32 / 85 / 27**.

## Acknowledgments

We built this package together and are happy to put it out there so other developers can add liquid-style progress UI without reinventing the wheel—less grind, more focus on what makes your app special.

**George Amany** and **Mohameed Saleh** did the hands-on work on the code and the package. **Abdlrahman Ibrahem**, our tech lead, guided architecture and quality. **Abdalla Gad** shaped the look and feel as designer. Huge thanks to everyone involved; we hope it saves you time.

## License

[MIT](LICENSE).
