# Aswat al-Quloob — أصوات القلوب

> **Voices of the Heart** — A custom Arabic keyboard for Android & iOS, built with Flutter.

Aswat al-Quloob gives you a clean, fast Arabic typing experience registered as a real system keyboard. The host app walks you through setup and lets you tweak preferences; the keyboard itself shows up everywhere on your device just like any stock keyboard.

---

## Architecture at a Glance

```
Host App (Flutter)
├── Onboarding  →  3-step first-run flow
├── Settings    →  Haptic/sound toggles, keyboard preview
└── Keyboard    →  In-app preview powered by KeyboardBloc
        │
    Platform Channel  (com.aswat.alquloob/keyboard)
        │
  ┌─────┴──────────────────────┐
  │  Android                    │  iOS
  │  InputMethodService         │  Custom Keyboard Extension
  │  (Kotlin)                   │  (Swift / UIInputViewController)
  └─────────────────────────────┘
```

### State management — BLoC

Every feature has its own **Bloc** (business-logic component) following the `flutter_bloc` pattern:

| Bloc | Responsibility |
|------|---------------|
| `OnboardingBloc` | Tracks the 3-step onboarding, checks if the keyboard has been enabled in system settings, and persists completion via `SharedPreferences`. |
| `KeyboardBloc` | Manages the in-app keyboard preview — key presses, shift, backspace, language toggle. Pure synchronous logic, zero I/O. |
| `SettingsBloc` | Reads/writes user prefs (haptic feedback, key sounds) to `SharedPreferences`. |

All BLoCs are provided at the root of the widget tree via `MultiBlocProvider` in `app.dart`. UI widgets use `BlocBuilder` with `buildWhen` guards to minimize rebuilds.

### Native keyboard bridging

**Android** registers an `InputMethodService` (`AswatInputMethodService`) in the manifest. It spins up its own `FlutterEngine` so the keyboard view is rendered by Flutter. A separate `MethodChannel` (`com.aswat.alquloob/ime`) lets Dart commit text into whatever app the user is typing in.

**iOS** uses a Custom Keyboard Extension (`AswatKeyboard` target) with a `UIInputViewController` subclass. The extension is pure UIKit — no Flutter engine — keeping the memory footprint small. It talks to the text field through `textDocumentProxy`.

The **host app** talks to native code on a different channel (`com.aswat.alquloob/keyboard`) for things like "is our keyboard turned on?" and "open the OS keyboard settings page".

---

## Project Structure

```
lib/
├── main.dart                     Entry point
├── app.dart                      Root widget + MultiBlocProvider
├── core/
│   ├── constants/
│   │   ├── app_colors.dart       Colour palette
│   │   ├── app_strings.dart      All user-facing text
│   │   └── arabic_layout.dart    Key layouts (main + shift)
│   ├── theme/
│   │   └── app_theme.dart        Material 3 theme
│   └── platform/
│       └── keyboard_channel.dart MethodChannel wrapper
├── features/
│   ├── onboarding/               Welcome → Permissions → Done
│   ├── keyboard/                 In-app keyboard preview
│   └── settings/                 Preferences + about
└── shared/
    └── widgets/
        └── gradient_button.dart  Reusable CTA button

android/
└── app/src/main/
    ├── kotlin/com/aswat/alquloob/
    │   ├── MainActivity.kt              Platform channel handler
    │   └── AswatInputMethodService.kt   System keyboard service
    ├── res/xml/method.xml               IME metadata
    └── AndroidManifest.xml              Service registration

ios/
├── Runner/
│   ├── AppDelegate.swift                Platform channel handler
│   └── Info.plist
└── AswatKeyboard/
    ├── KeyboardViewController.swift     Custom keyboard extension
    └── Info.plist                        Extension config
```

---

## Getting Started

### Prerequisites

- Flutter SDK (3.16+)
- Android Studio or Xcode
- A physical device is strongly recommended for testing the keyboard service

### Run the app

```bash
# 1. Install dependencies
flutter pub get

# 2. Run on a connected device
flutter run
```

### Enable the keyboard (Android)

1. Launch the app — the onboarding will guide you.
2. When prompted, tap **Open Keyboard Settings**.
3. Toggle on **Aswat al-Quloob**.
4. In any app, long-press the globe/keyboard icon on your current keyboard to switch.

### Enable the keyboard (iOS)

1. In Xcode, add a **Custom Keyboard Extension** target named `AswatKeyboard`.
2. Copy `ios/AswatKeyboard/KeyboardViewController.swift` and `Info.plist` into the target.
3. Build & run on a real device.
4. Go to **Settings → General → Keyboard → Keyboards → Add New Keyboard** and select **Aswat al-Quloob**.

---

## Building the App Icon

The icon source lives at `assets/icon/app_icon.svg`. It features:

- A **teal-to-emerald gradient** background with rounded corners
- A **golden heart** silhouette (referencing *Quloob* — hearts)
- A large white Arabic **أ** (alef with hamza)
- Subtle **Islamic geometric border** lines

To generate platform-specific raster icons from the SVG, you can use the [`flutter_launcher_icons`](https://pub.dev/packages/flutter_launcher_icons) package:

```yaml
# Add to dev_dependencies, then run: flutter pub run flutter_launcher_icons
flutter_launcher_icons:
  android: true
  ios: true
  image_path: "assets/icon/app_icon.png"  # export the SVG to PNG first
```

---

## Key Design Decisions

| Decision | Rationale |
|----------|-----------|
| **BLoC over Riverpod/Provider** | Explicit event → state flow makes the keyboard logic easy to trace and test. No magic, no code generation. |
| **Native keyboard, not overlay** | Overlays break in many apps and can't receive system input focus. A real `InputMethodService` / keyboard extension works everywhere. |
| **Separate FlutterEngine for Android IME** | The keyboard service runs in a different process than the host app, so it needs its own engine instance. |
| **Pure UIKit for iOS extension** | Embedding a FlutterEngine in an iOS keyboard extension is fragile and memory-heavy. UIKit keeps the extension under the 30 MB memory limit. |
| **Pre-computed shadow colours** | Calling `withOpacity()` on every frame allocates a new `Color`. Using compile-time constants avoids this. |

---

## License

This project is provided as-is for educational and personal use.
