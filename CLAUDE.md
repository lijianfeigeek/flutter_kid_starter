# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Flutter educational app for children called "KidStarter" that helps kids learn alphabets, numbers, colors, and shapes. The app features audio playback for learning content and uses a child-friendly design with custom fonts and colorful interfaces.

## Development Commands

Essential Flutter commands for development:

- `flutter run` - Run the app in debug mode
- `flutter run -d ios` - Run specifically on iOS simulator/device
- `flutter run -d android` - Run specifically on Android device/emulator
- `flutter build apk` - Build Android APK
- `flutter build ios` - Build iOS app (requires Xcode)
- `flutter test` - Run all tests
- `flutter test test/widget_test.dart` - Run a specific test file
- `flutter analyze` - Run static analysis on code
- `flutter pub get` - Install dependencies from pubspec.yaml
- `flutter pub upgrade` - Upgrade dependencies to latest versions
- `flutter clean` - Clean build artifacts and cache
- `flutter doctor` - Check development environment setup

**iOS Development Setup:**
- Install Xcode from Mac App Store
- Run `xcode-select --install` for command line tools
- Set up iOS Simulator in Xcode
- Trust developer certificates on physical devices

## Project Structure

### Core Architecture

- **Entry Point**: `lib/main.dart` - Sets up the MaterialApp with custom theme and launches HomeScreen
- **Constant Definitions**: `lib/constant.dart` - Contains app-wide color schemes and text styles
- **Helper Utilities**: `lib/helper.dart` - Provides color generation utilities

### Screen Navigation Structure

The app uses a simple navigation pattern with HomeScreen as the main hub:
- `lib/screens/home.dart` - Main screen with category cards (Colors, 123, ABC, Stories, Shapes)
- `lib/screens/alphabets.dart` - Alphabet learning screen
- `lib/screens/colors.dart` - Color learning screen
- `lib/screens/counting.dart` - Number learning screen
- `lib/screens/shapes.dart` - Shape learning screen
- `lib/screens/stories.dart` - Stories screen

### Data Layer

Educational content is stored in JSON format:
- `assets/data/alphabets.json` - Alphabet letters with associated audio files
- `assets/data/colors.json` - Color definitions with hex codes and audio
- `assets/data/numbers.json` - Number learning content

### Entity Models

- `lib/entities/alphabet.dart` - Alphabet data model
- `lib/entities/color.dart` - Color data model
- `lib/entities/number.dart` - Number data model

### Reusable Widgets

- `lib/widgets/category_card.dart` - Category selection cards on home screen
- `lib/widgets/page_header.dart` - Consistent page headers
- `lib/widgets/tile_card.dart` - Interactive tile cards for content

### Asset Management

The app uses extensive audio and visual assets:
- `assets/audio/` - Contains MP3 files for each letter, number, and color
- `assets/images/` - Background images and UI graphics
- `assets/fonts/` - Custom CabinSketch font family
- `assets/icons/` - App icons for Android and iOS

### Dependencies

Key Flutter packages from `pubspec.yaml`:
- `flutter_sound: ^9.2.13` - Audio playback functionality for MP3 files
- `path_provider: ^2.1.2` - File system access for audio files
- `cupertino_icons: ^1.0.8` - iOS-style icons
- `flutter_launcher_icons: "^0.13.1"` - App icon generation

**Note:** This project has been updated to use modern Flutter/Dart SDK versions (">=2.12.0 <4.0.0") and recent package versions.

### Key Architecture Patterns

1. **Stateless Widget Pattern**: Most screens are StatelessWidget, except screens requiring audio state management use StatefulWidget
2. **Asset-Based Learning**: Content is loaded from JSON files using `rootBundle.loadString()` and parsed into entity models
3. **Audio Integration**: Uses `flutter_sound` package for playing MP3 files located in `assets/audio/`
4. **Dynamic Color Theming**: Each learning category has its own color scheme passed as constructor parameters
5. **Child-Friendly UI**: Uses custom CabinSketch font, large touch targets, and bright colors

### Audio Architecture

The app uses a consistent audio playback pattern across learning screens:
- Audio files are referenced in JSON data assets
- `flutter_sound` package handles MP3 playback
- Each learning entity (alphabet, color, number) has associated audio file paths
- Audio state is managed at the widget level for simple play/pause functionality

### Data Loading Pattern

Educational content follows this loading pattern:
```dart
Future<List<EntityType>> _fetchData() async {
  String jsonString = await rootBundle.loadString('assets/data/entity.json');
  final jsonParsed = json.decode(jsonString);
  return jsonParsed.map<EntityType>((json) => EntityType.fromJson(json)).toList();
}
```

### Test Infrastructure

- Basic widget test exists in `test/widget_test.dart` (currently generic template)
- Tests use Flutter's built-in testing framework with `WidgetTester`
- Current test is a placeholder that doesn't reflect actual app functionality

## Development Notes

- The app targets children with simple, intuitive navigation
- Audio files are essential for the learning experience - ensure they're included in assets
- Custom theming uses Material Design with child-friendly modifications
- Asset references are hardcoded and must match the file structure exactly
- JSON data files use a consistent structure: text/display content + audio file path
- Project uses modern Flutter/Dart SDK versions (">=2.12.0 <4.0.0") with updated package versions
- Test file is currently a generic template and doesn't test actual app functionality
- Uses flutter_lints for code analysis and quality enforcement
- Font configuration uses CabinSketch family with Bold (700) and Regular weights