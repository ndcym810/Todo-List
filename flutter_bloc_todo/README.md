# Flutter BLoC Todo App

A modern, feature-rich Todo application built with Flutter and BLoC pattern for state management. This app demonstrates best practices in Flutter development, including clean architecture, state management, and local data persistence.

## Features

- Create, read, update, and delete todos
- Local data persistence using Isar database
- Clean and intuitive user interface
- BLoC pattern for state management
- Responsive design that works across different screen sizes

## Technologies Used

- **Flutter** (SDK ^3.7.2) - UI framework
- **flutter_bloc** (^9.1.0) - State management
- **Isar** (^3.1.0+1) - Local database
- **Hive** (^2.2.3) - Local storage
- **path_provider** (^2.1.5) - File system access
- **cupertino_icons** (^1.0.8) - iOS-style icons

## Getting Started

### Prerequisites

- Flutter SDK (^3.7.2)
- Dart SDK (^3.0.0)
- Android Studio / VS Code with Flutter extensions
- An Android or iOS device/emulator

### Installation

1. Clone the repository:

   ```bash
   git clone <repository-url>
   cd flutter_bloc_todo
   ```

2. Install dependencies:

   ```bash
   flutter pub get
   ```

3. Run the code generation for Isar:

   ```bash
   flutter pub run build_runner build
   ```

4. Run the app:
   ```bash
   flutter run
   ```

## Project Structure

```
lib/
  ├── bloc/         # BLoC state management
  ├── models/       # Data models
  ├── repositories/ # Data handling
  ├── screens/      # UI screens
  ├── widgets/      # Reusable widgets
  └── main.dart     # Entry point
```

## Known Issues & Future Improvements

### Known Issues

- Initial load time might be slow on some devices due to database initialization

### Future Improvements

- Add user authentication
- Implement cloud synchronization
- Add categories and tags for todos
- Include due dates and reminders
- Add dark mode support
- Implement search functionality

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the LICENSE file for details.

---

_Note: Replace `<repository-url>` with the actual repository URL when available._
