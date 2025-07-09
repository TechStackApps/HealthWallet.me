# Progress

## Current Status

This document provides a high-level overview of the project's progress, including what works, what's left to build, and any known issues.

### What Works

-   **Project Structure:** The initial project structure is set up.
-   **Memory Bank:** The core documentation for the memory bank has been created.
-   **Local Storage:** The local database has been refactored to use Drift instead of Hive.
-   **Records Feature:** The records feature is refactored and contains the data layer for allergies and medications. The records now correctly displays all historical data.
-   **Home Page:** The dropdown on the home page now uses icons instead of text, and the sources are displayed dynamically with a fallback to the source ID.
-   **Theming:** The app's theme has been updated to match the Figma design, including typography and colors.
-   **Dashboard:** Fixed a layout error on the dashboard page.
-   **Authentication:** Implemented FaceID/Passcode authentication at app launch. Fixed a `PlatformException` on Android related to the `local_auth` plugin. Enabled device credential fallback (passcode, pattern, PIN) when biometrics are not available. Refactored the authentication flow to be an optional step in the onboarding process.
-   **UI Refactor:** Refactored the application to use the new `Insets` class and padding constants.
-   **Onboarding:** Refactored the splash screen to prevent a crash on the onboarding screen.

### What's Left to Build

-   **Authentication:** User login and registration functionality.
-   **Health Records ( বাকি):** All other screens related to viewing and managing health records.
-   **User Profile:** User profile and settings screens.
-   **API Integration:** Connecting the application to the backend API.
-   **Unit & Integration Tests:** Comprehensive test coverage for the application.

### Known Issues

-   **`test/widget_test.dart` is failing:** The default widget test is broken due to changes in the application's entry point. This needs to be fixed.
