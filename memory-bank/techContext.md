# Tech Context

## Technologies & Dependencies

This document lists the key technologies, libraries, and development tools used in the Health Wallet application.

### Core Technologies

-   **Flutter:** The UI toolkit for building the application from a single codebase.
-   **Dart:** The programming language for Flutter.

### Key Libraries & Packages

-   **`flutter_bloc`:** For state management.
-   **`get_it` & `injectable`:** For dependency injection.
-   **`auto_route`:** For navigation.
-   **`dio`:** For network requests.
-   **`freezed`:** For code generation for immutable classes.
-   **`json_serializable`:** For JSON serialization/deserialization.
-   **`l10n`:** For localization and internationalization.

### Development & Tooling

-   **FVM (Flutter Version Management):** Used to ensure the entire team uses the same Flutter SDK version.
-   **Visual Studio Code:** The recommended IDE for development.
-   **Git:** For version control.

### Technical Constraints

-   **Platform Support:** The application must support iOS 13+ and Android 6.0+.
-   **Offline Support:** The application should provide basic functionality even when the user is offline. Critical data should be cached locally.
