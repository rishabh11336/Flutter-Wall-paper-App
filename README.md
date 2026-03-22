# WallCraft 🎨

## 📥 Download latest APK
<a href="https://raw.githubusercontent.com/rishabh11336/Flutter-Wall-paper-App/main/apk/app-release.apk">
  <img src="https://img.shields.io/badge/Download-APK%20for%20Android-green?style=for-the-badge&logo=android" alt="Download APK for Android" />
</a>

An open-source, beautifully modern wallpaper application built entirely with **Flutter** (Material 3). Designed with performance, edge-to-edge native experiences, and simplicity in mind.

## ✨ Features
* **Zero-Server Backend**: Dynamically hits the GitHub APIs! Wallpapers are added instantly just by dragging and dropping `.jpg`, `.png`, or `.webp` files into your GitHub repository! No manual `manifest.json` databases to manage.
* **Native Wallpaper Application**: Instantly apply any photo seamlessly to your device's Home Screen, Lock Screen, or both.
* **Liquid Smooth UI**: Unobtrusive frosted-glass App Bars, staggered infinite-scrolling grids, and skeleton "Shimmer" loaders using an immersive edge-to-edge aesthetic.
* **Auto-Tagging & Formatting**: Wallpapers hosted on GitHub have their filenames automatically parsed, spaced, capitalized, and organized into dynamic search tags.
* **Save to Gallery**: One-click download directly into the native Photos folder.

## 🛠 Tech Stack
- **Framework**: [Flutter 3.x](https://flutter.dev/) (Android, iOS)
- **State Management**: [Riverpod](https://riverpod.dev/) (`hooks_riverpod`, `riverpod_annotation`)
- **Routing**: [GoRouter](https://pub.dev/packages/go_router)
- **Networking**: [Dio](https://pub.dev/packages/dio)
- **Local Storage**: [Hive](https://pub.dev/packages/hive_flutter)
- **Native Bridges**: `flutter_wallpaper_manager`, `image_gallery_saver`

## 🚀 Getting Started

### 1. Prerequisites
- **Flutter SDK** (`>=3.4.0`)
- **Android Studio** or **Xcode** for simulation.

### 2. Installation
```bash
git clone https://github.com/rishabh11336/Flutter-Wall-paper-App.git
cd Flutter-Wall-paper-App
flutter pub get
```

### 3. Adding Your Own Wallpapers
By default, the app looks at the `rishabh11336/Wallpaper-Images` GitHub repository. 
If you want to host your own wallpapers:
1. Open `lib/core/constants.dart`.
2. Change the `manifestUrl` endpoint to point to your target repository's directory using the generic GitHub Contents API:
```dart
static const String manifestUrl = 'https://api.github.com/repos/<Your-User>/<Your-Repo>/contents/';
```
3. Upload images directly into that GitHub repository path. WallCraft automatically processes, filters, labels, and displays them right in the app in real time!

## 📱 Build The Application
### Android (12+)
```bash
flutter build apk --release
```
### iOS
```bash
flutter build ipa --release
```

## ⚖️ License
This project is completely open source and available for testing, cloning, or modifying securely!
