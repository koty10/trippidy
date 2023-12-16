# Trippidy
This is a Flutter project for Trippidy - a tool for Online Organisation of Trips.

# Instalation
- Follow the instructions on https://docs.flutter.dev/get-started/install
- Install extensions to VS Code:
  - Dart from dartcode.org
  - Flutter from dartcode.org
- Change values like domain in lib/constants.dart to your server or leave it unchanged and use my server
- Run `flutter pub get`
- Regenerate models:
  - `dart run build_runner build --delete-conflicting-outputs`
- Either run `flutter build lib/main.dart` and manually install an .apk file from build/app/outputs/flutter-apk on your Android device or connect a physical Android phone with USB debugging enabled or run an emulator and run the project from VS Code from lib/main.dart
