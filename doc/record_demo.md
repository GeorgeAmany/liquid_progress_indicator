# Recording a README demo GIF

Use the **example app** so your GIF matches what developers will see on pub.dev. It shows **Liquid Progress Indicator** / **Social Media Reach** with four pills (defaults Instagram **62%**, TikTok **38%**, Facebook **68%**, Snapchat **30%**) and **Adjust values**—move the sliders while recording so the wave fill updates.

## 1. Run the example

```bash
cd example
flutter pub get
flutter run
```

Use an **iPhone-sized simulator** or a narrow window (~390×844) so the layout matches a phone frame.

## 2. Record the screen

**macOS + Simulator**

- **File → Record Screen** in Simulator, or use **QuickTime Player → File → New Screen Recording**.
- Capture **8–15 seconds**: let the wave animation run, then **drag both sliders** so viewers see the liquid fill and percentage update.

**Physical device**

- iOS: Screen Recording from Control Center.  
- Android: built-in screen recorder or `adb screenrecord`.

## 3. Convert to GIF

- Online: [ezgif.com/video-to-gif](https://ezgif.com/video-to-gif) (trim, resize to ~360px width, optimize).
- CLI (if you use Homebrew): `brew install ffmpeg` then e.g.  
  `ffmpeg -i demo.mov -vf "fps=12,scale=360:-1:flags=lanczos" -loop 0 doc/demo.gif`

## 4. Add to the repo

Save the file as **`doc/demo.gif`** in the package root (inside the `doc` folder, next to this file).  
On macOS, avoid names like `doc:demo.gif` (colon)—use **`demo.gif`** inside **`doc/`** so the README path `doc/demo.gif` works on GitHub and pub.dev.

In **`README.md`**, the **Preview** section should reference it:

```markdown
![liquid_progress_indicator demo](doc/demo.gif)
```

After you push to GitHub, pub.dev will show the GIF on your package page (relative paths in the README resolve from the published package).

## Tips

- **Short loop** (under 2 MB if possible) loads faster on pub.dev.  
- **Portrait** matches the example layout.  
- Avoid rapid flashing for accessibility.
