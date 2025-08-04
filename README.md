# Donezoid - A Modern Flutter To-Do App

Donezoid is a modern, feature-rich To-Do Task Manager application built with Flutter. It showcases a clean architecture, Material 3 design, and a range of advanced features to provide a seamless and productive user experience.

This project was built to demonstrate best practices in Flutter development, including state management, local persistence, internationalization, and advanced UI/UX features.

## ✨ Features

*   **Modern UI:** Sleek, animated Material 3 design with light and dark themes.
*   **Task Management:** Create, update, and delete tasks with titles, descriptions, notes, priorities, due dates, and colors.
*   **Filtered Views:** View tasks in three separate tabs: All, Pending, and Completed.
*   **State Management:** Uses the `provider` package for robust and scalable state management.
*   **Local Persistence:** All tasks and settings are saved locally on the device using the `Hive` database, ensuring data is available offline.
*   **Internationalization (i18n):** Supports multiple languages (English and Spanish included) using `flutter_localizations`.
*   **Speech-to-Text:** Create tasks hands-free using voice input for the title, description, and notes.
*   **Haptic Feedback:** Provides tactile feedback for key user interactions.
*   **Celebration Animations:** A fun confetti animation celebrates with you when you complete a task.

## 📂 Project Structure

The project follows a clean, feature-first architectural pattern, with code organized into the following directories:

```
lib/
├── localization/   # Language JSON files and localization logic
├── models/         # Data models for the application (e.g., Task)
├── providers/      # State management using ChangeNotifier (e.g., TaskProvider)
├── screens/        # UI for each screen of the app
├── services/       # Core services like DatabaseService
├── theme/          # Application themes (light and dark)
├── utils/          # Utility functions and constants
└── widgets/        # Reusable custom widgets (e.g., TaskCard)
```

## 🚀 Getting Started

To run this project locally, you will need to have the Flutter SDK installed.

1.  **Clone the repository:**
    ```sh
    git clone <repository-url>
    ```

2.  **Install dependencies:**
    ```sh
    flutter pub get
    ```

3.  **Run the app:**
    ```sh
    flutter run
    ```

## 🛠️ Built With

*   **Flutter** - The UI toolkit for building natively compiled applications for mobile, web, and desktop from a single codebase.
*   **Provider** - For state management.
*   **Hive** - A lightweight and blazing fast key-value database written in pure Dart.
*   **speech_to_text** - For enabling voice input.
*   **confetti** - For the fun celebration animations.
*   **intl** & **flutter_localizations** - For internationalization.
