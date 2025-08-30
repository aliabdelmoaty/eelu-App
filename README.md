# Edupro - Course Management App
[![Ask DeepWiki](https://devin.ai/assets/askdeepwiki.png)](https://deepwiki.com/aliabdelmoaty/eelu-App)

Edupro is a comprehensive e-learning mobile application built with Flutter and Firebase. It provides a platform for students to access course materials, including lecture notes (PDFs) and video tutorials, while giving administrators the tools to manage this content seamlessly.

## Key Features

- **User Authentication:** Secure user registration, login, and password reset functionalities powered by Firebase Authentication.
- **Role-Based Access Control:** The application distinguishes between students and administrators. Admins have exclusive rights to add, update, and delete course materials.
- **Dynamic Course Catalog:** Courses and their associated materials are fetched in real-time from Cloud Firestore and displayed in a user-friendly grid layout.
- **Rich Media Support:**
    - **In-App Video Player:** Watch course videos directly within the app, with support for YouTube links.
    - **PDF Viewer:** Access and read lecture notes and other documents with the integrated PDF viewer.
- **Offline Access:**
    - **Download Manager:** Download videos and PDFs to your device for offline learning.
    - **Video Quality Selection:** Choose the desired video quality before starting a download to manage storage and data usage.
    - **Progress Notifications:** Stay informed about download progress with real-time local notifications.
- **Content Management (Admin Panel):**
    - Upload new lecture PDFs directly from the device.
    - Add new video resources by providing their URLs.
    - Remove outdated or incorrect materials from any course.
- **User Profile:** A dedicated screen for users to view their registered information and sign out of the application.
- **Responsive & Modern UI:** Built with `flutter_screenutil` for adaptability across different screen sizes, featuring shimmer effects for loading states and Lottie animations for a polished user experience.

## Core Technologies

- **Framework:** Flutter
- **Backend:** Firebase (Authentication, Cloud Firestore, Storage)
- **State Management:** Flutter Bloc (Cubit)
- **Routing:** GoRouter
- **Networking:** Dio
- **Video & PDF Rendering:**
    - `youtube_explode_dart` & `youtube_player_flutter`
    - `syncfusion_flutter_pdfviewer`
- **File & Permissions:** `file_picker`, `permission_handler`
- **Notifications:** `flutter_local_notifications`, `firebase_messaging`

## Project Structure

The project follows a feature-driven architecture to ensure scalability and maintainability.

- `lib/features`: Contains the primary modules of the app, such as `login`, `register`, `home`, `course`, and `profile`. Each feature folder is self-contained with its own UI (View), state management (Cubit), and data models.
- `lib/core`: Includes shared components, utilities, and constants that are used across multiple features. This includes the app router, color schemes, custom widgets, and helper classes.

## Getting Started

To get a local copy up and running, follow these simple steps.

### Prerequisites

- Flutter SDK installed on your machine.
- A configured IDE like VS Code or Android Studio.

### Firebase Setup

1.  Create a new project on the [Firebase Console](https://console.firebase.google.com/).
2.  Add an Android app and an iOS app to your Firebase project.
3.  Follow the on-screen instructions to download the configuration files:
    - For Android, download `google-services.json` and place it in the `android/app/` directory.
    - For iOS, download `GoogleService-Info.plist` and place it in the `ios/Runner/` directory.
4.  Enable **Authentication** (with Email/Password), **Firestore**, and **Storage** in the Firebase console.

### Installation

1.  Clone the repository:
    ```sh
    git clone https://github.com/aliabdelmoaty/eelu-app.git
    ```
2.  Navigate to the project directory:
    ```sh
    cd eelu-app
    ```
3.  Install the required dependencies:
    ```sh
    flutter pub get
    ```
4.  Run the application:
    ```sh
    flutter run