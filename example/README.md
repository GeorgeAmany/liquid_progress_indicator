# Example

This folder is **not** published on pub.dev. It depends on the parent package via a **path** dependency, which pub.dev does not allow for published packages.

To publish **liquid_progress_indicator**, run from the **repository root** (parent of `example/`):

```bash
cd ..
dart pub publish --dry-run
```

| File | Role |
|------|------|
| `lib/main.dart` | `buildSocialReachItems`, `SocialMediaReachSection`, sliders |
| `lib/sample_data.dart` | Gradients + SVG asset paths |

Default reach **98 / 32 / 85 / 27**.

## Run

```bash
flutter pub get
flutter run
```

If platforms are missing:

```bash
flutter create .
```

**[doc/record_demo.md](../doc/record_demo.md)** — updating `doc/demo.gif`.
