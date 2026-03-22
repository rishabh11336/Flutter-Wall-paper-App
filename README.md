# WallCraft – Flutter Wallpaper App (Phase 1)

A cross-platform (iOS & Android) wallpaper browsing app that fetches wallpapers from a public GitHub repository and lets users preview them in full-screen.

## Screenshots

Phase 1 delivers:
- 🏠 **Home screen** with category tab bar and a 2-column wallpaper grid
- ✨ **Shimmer loading skeletons** while images load
- 🖼️ **Preview screen** with full-screen image, Hero animation, and gradient overlay
- 🎨 **Light & Dark mode** support with Material 3

---

## Tech Stack

| Concern           | Package                          |
| ----------------- | -------------------------------- |
| State management  | `flutter_riverpod`               |
| Navigation        | `go_router`                      |
| HTTP client       | `dio`                            |
| Image loading     | `cached_network_image`           |
| Loading skeletons | `shimmer`                        |
| Models            | `freezed` + `json_serializable`  |
| Typography        | `google_fonts` (Outfit + Inter)  |

---

## Getting Started

### Prerequisites

- Flutter **3.19+** (latest stable recommended)
- Dart **3.2+**
- iOS: Xcode 15+ and CocoaPods
- Android: Android Studio with Gradle 8+

### Setup

```bash
# 1. Clone the repo
git clone <your-repo-url>
cd wallpaper_app

# 2. Install dependencies
flutter pub get

# 3. Generate freezed/json_serializable code
flutter pub run build_runner build --delete-conflicting-outputs

# 4. Run the app
flutter run
```

> **Note:** If `flutter` is not in your PATH, use the full path to your Flutter binary (e.g. `~/Developer/flutter/bin/flutter`).

---

## Pointing to Your GitHub Image Repo

The app fetches a `manifest.json` file from a public GitHub repository.

### 1. Create a manifest

In your GitHub repo (e.g. [rishabh11336/Wallpaper-Images](https://github.com/rishabh11336/Wallpaper-Images)), create:

```
wallpapers/
├── manifest.json
├── nature/
│   ├── forest_01.jpg
│   └── thumbs/
│       └── forest_01.jpg
├── abstract/
│   └── ...
└── ...
```

### 2. manifest.json format

```json
{
  "version": 1,
  "categories": ["nature", "abstract", "minimal", "urban"],
  "wallpapers": [
    {
      "id": "nature_01",
      "title": "Forest Dawn",
      "category": "nature",
      "tags": ["green", "forest", "morning"],
      "url": "https://raw.githubusercontent.com/rishabh11336/Wallpaper-Images/main/wallpapers/nature/forest_01.jpg",
      "thumb_url": "https://raw.githubusercontent.com/rishabh11336/Wallpaper-Images/main/wallpapers/nature/thumbs/forest_01.jpg",
      "resolution": "4K",
      "width": 3840,
      "height": 2160
    }
  ]
}
```

### 3. Update the manifest URL

Open `lib/core/constants.dart` and change `manifestUrl` to point to your raw GitHub URL:

```dart
static const String manifestUrl =
    'https://raw.githubusercontent.com/rishabh11336/Wallpaper-Images/main/wallpapers/manifest.json';
```

---

## Project Structure

```
lib/
├── main.dart                          Entry point
├── app/
│   ├── app.dart                       MaterialApp + theme
│   └── router.dart                    GoRouter routes
├── core/
│   ├── constants.dart                 URLs, timeouts
│   └── theme/
│       ├── app_theme.dart             Light & dark themes
│       └── app_colors.dart            Color tokens
├── data/
│   ├── models/
│   │   ├── wallpaper.dart             Freezed model
│   │   ├── wallpaper.freezed.dart     Generated
│   │   └── wallpaper.g.dart           Generated
│   ├── repositories/
│   │   └── wallpaper_repository.dart
│   └── sources/
│       └── github_source.dart         Fetches manifest.json
├── features/
│   ├── home/
│   │   ├── home_screen.dart           Tab bar + grid
│   │   ├── home_provider.dart         Riverpod providers
│   │   └── widgets/
│   │       ├── category_tab_bar.dart
│   │       ├── wallpaper_grid.dart
│   │       ├── wallpaper_card.dart    Card with shimmer
│   │       └── shimmer_grid.dart      Loading skeleton
│   └── preview/
│       ├── preview_screen.dart        Full-screen preview
│       └── widgets/
│           └── preview_actions_sheet.dart
└── shared/
    ├── widgets/
    │   └── error_view.dart            Error & retry UI
    └── extensions/
        └── context_extensions.dart
```

---

## Phase Roadmap

| Phase | Features |
| ----- | -------- |
| **1 ✅** | Project scaffolding, GitHub data source, home screen, preview screen, shimmer loading, navigation |
| **2** | Actual wallpaper setting (home/lock/both), bottom navigation, download to device |
| **3** | Search & filter, favourites system, advanced categories |

---

## Code Generation

After modifying any `@freezed` model or adding new ones, regenerate with:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

For continuous watch during development:

```bash
flutter pub run build_runner watch --delete-conflicting-outputs
```

---

## License

MIT
