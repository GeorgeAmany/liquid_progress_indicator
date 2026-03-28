# liquid_progress_indicator

[![pub package](https://img.shields.io/pub/v/liquid_progress_indicator.svg)](https://pub.dev/packages/liquid_progress_indicator)
[![style: flutter lints](https://img.shields.io/badge/style-flutter__lints-blue.svg)](https://pub.dev/packages/flutter_lints)

Animated liquid-style wave fill inside compact cards. Use **`SocialMediaFeed`** for a centered row of metrics (e.g. social reach as 0–100), or **`SocialMediaPill`** alone for any 0.0–1.0 progress. You provide **icons** (`Icon`, `Image`, `SvgPicture`, …) and **`LinearGradient`**s—no assets are bundled.

---

## Features

- **Wave animation** — continuous sine-wave surface with a soft second layer
- **Tweened percentage** — label animates when the value changes
- **Feed helper** — `buildSocialReachItems` merges a `Map<String, int>` with per-platform config
- **Zero hidden UI deps** — sizes are logical pixels; optional `SocialMediaPillStyle` for full control
- **Semantics** — pills expose a label and current percent for accessibility

---

## Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  liquid_progress_indicator: ^0.1.0
```

Then:

```bash
flutter pub get
```

**Flutter:** `>=3.16.0` · **Dart:** `^3.9.2` (see `pubspec.yaml` in the repo for exact constraints).

---

## Quick start

```dart
import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

class DashboardSnippet extends StatelessWidget {
  const DashboardSnippet({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      SocialReachItem(
        label: 'Instagram',
        reach: 72,
        icon: const Icon(Icons.camera_alt, color: Colors.white, size: 22),
        gradient: const LinearGradient(
          colors: [Color(0xFFF58529), Color(0xFFDD2A7B), Color(0xFF8134AF)],
        ),
      ),
      SocialReachItem(
        label: 'TikTok',
        reach: 45,
        icon: const Icon(Icons.music_note, color: Colors.white, size: 22),
        gradient: const LinearGradient(
          colors: [Color(0xFF00F2EA), Color(0xFFFF0050)],
        ),
      ),
    ];

    return SocialMediaFeed(items: items);
  }
}
```

Entries with **`reach <= 0`** are not shown in the feed.

---

## Usage

### 1. Row from a map (`buildSocialReachItems`)

When your API returns something like `{'instagram': 72, 'tiktok': 45}`, keep numbers in **one map** and branding in another:

```dart
import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

final Map<String, int> reachByPlatform = {
  'instagram': 72,
  'tiktok': 45,
  'facebook': 88,
  'snapchat': 0, // hidden in the feed
};

final Map<String, SocialPlatformConfig> platformUi = {
  'instagram': SocialPlatformConfig(
    label: 'Instagram',
    icon: const Icon(Icons.camera_alt, color: Colors.white, size: 22),
    gradient: const LinearGradient(
      colors: [Color(0xFFF58529), Color(0xFFDD2A7B), Color(0xFF8134AF)],
    ),
  ),
  'tiktok': SocialPlatformConfig(
    label: 'TikTok',
    icon: const Icon(Icons.music_note, color: Colors.white, size: 22),
    gradient: const LinearGradient(
      colors: [Color(0xFF00F2EA), Color(0xFFFF0050)],
    ),
  ),
  // ...facebook, snapchat, etc.
};

final items = buildSocialReachItems(
  reachByPlatformKey: reachByPlatform,
  configByPlatformKey: platformUi,
);

// Inside build():
SocialMediaFeed(items: items);
```

Keys present only in the reach map are built; keys without a matching **`SocialPlatformConfig`** are skipped. Order follows the **iteration order** of `reachByPlatform` (use a map literal in the order you want, or sort `items` before passing them in).

**SVG icons** (optional): add [`flutter_svg`](https://pub.dev/packages/flutter_svg) to your app and pass `SvgPicture.asset('assets/instagram.svg')` as `icon`.

---

### 2. Single pill (`progress` 0.0–1.0)

```dart
SocialMediaPill(
  progress: 0.75,
  label: 'Hydration',
  icon: const Icon(Icons.water_drop, color: Colors.white),
  gradient: const LinearGradient(
    colors: [Color(0xFF4FC3F7), Color(0xFF0288D1)],
  ),
);
```

---

### 3. Customize size and timing

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

---

## API overview

| Type | Role |
|------|------|
| `SocialMediaFeed` | Centered `Row` of pills; filters `reach > 0` |
| `SocialMediaPill` | One animated card; `progress` is 0.0–1.0 |
| `SocialReachItem` | `label`, `icon`, `gradient`, `reach` (int, typically 0–100) |
| `SocialPlatformConfig` | Same as item minus `reach`; used with `buildSocialReachItems` |
| `buildSocialReachItems` | `Map<String,int>` + `Map<String,SocialPlatformConfig>` → `List<SocialReachItem>` |
| `SocialMediaPillStyle` | Layout, colors, shadow, animation durations |

For full signatures, run **`dart doc`** in the package root or open the **API reference** tab on [pub.dev](https://pub.dev/packages/liquid_progress_indicator) after publishing.

---

## Example project

The repository includes a runnable Flutter app under **`example/`**:

```bash
cd example
flutter pub get
flutter run
```

It demonstrates:

- a **feed** built with `buildSocialReachItems`
- **sliders** that update reach / progress live
- a **standalone** `SocialMediaPill` with custom `SocialMediaPillStyle`

---

## Publishing (maintainers)

1. Set `homepage`, `repository`, and `issue_tracker` in `pubspec.yaml` to your real URLs.
2. `dart pub publish --dry-run` then `dart pub publish` (after `dart pub login`).
3. Prefer a short **`description:`** in `pubspec.yaml` (pub.dev shows it in search; keep it under ~180 characters).

---

## License

See [LICENSE](LICENSE) (MIT).
