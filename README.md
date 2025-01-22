# EduPro - Course Management App

EduPro is a Flutter-based application designed to manage educational courses, allowing users to view, download, and manage course materials such as videos and PDFs. The app integrates with Firebase for authentication, data storage, and real-time updates.

## Features

- **User Authentication**:
  - Login, Register, and Forgot Password flows.
  - Firebase Authentication for secure user management.

- **Course Management**:
  - View courses with embedded videos and PDFs.
  - Add/Delete videos and PDFs (admin-only).
  - Real-time updates using Firebase Firestore.

- **File Handling**:
  - Download videos and PDFs with progress notifications.
  - YouTube video integration and quality selection.
  - Firebase Storage for file uploads and management.

- **State Management**:
  - Uses `Cubit` for efficient state handling.

- **Responsive UI**:
  - Built with `flutter_screenutil` for adaptive layouts.
  - Custom widgets for consistent design.

- **Navigation**:
  - Routing managed by `GoRouter` for deep linking and smooth transitions.

## Technologies Used

- **Frontend**: Flutter
- **Backend**: Firebase (Auth, Firestore, Storage)
- **State Management**: Flutter Bloc (Cubit)
- **Routing**: GoRouter
- **Dependencies**:
  - `cloud_firestore`, `firebase_auth`, `firebase_storage`
  - `dio` for HTTP requests
  - `file_picker` for file selection
  - `youtube_explode_dart` for YouTube video parsing
  - `permission_handler` for storage permissions

## Installation

1. **Clone the repository**:
   ```bash
   git clone https://github.com/your-username/edupro.git
   cd edupro
