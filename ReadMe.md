# MyDay - SwiftUI Journal App

MyDay is a simple SwiftUI-based journal application designed to help you keep track of your daily thoughts and activities. It includes user registration and login functionalities with a clean, consistent design inspired by [Mood Tracker Journal & Diary App Design on Dribbble](https://dribbble.com/shots/23904627-Mood-Tracker-Journal-Diary-App-Design).

## Project Structure

The project is divided into two main parts:
- **Backend**: Contains the Node.js server and related files.
- **Frontend**: Contains the SwiftUI iOS application.

## Getting Started

### Prerequisites

- **Backend**:
  - Node.js
  - MongoDB Atlas account
- **Frontend**:
  - Xcode 12 or later
  - iOS 14 or later

### Installation

#### Backend

1. **Navigate to the backend directory**:
    ```sh
    cd backend
    ```
2. **Install the dependencies**:
    ```sh
    npm install
    ```
3. **Create a `.env` file in the backend directory with the following content**:
    ```
    MONGODB_URI=your-mongodb-uri
    PORT=5000
    ```
4. **Start the backend server**:
    ```sh
    node server.js
    ```

#### Frontend

1. **Navigate to the frontend directory**:
    ```sh
    cd frontend
    ```
2. **Open the project in Xcode**:
    ```sh
    open MyDay.xcodeproj
    ```
3. **Build and run the project**:
    - Select a simulator or a connected device.
    - Click the "Run" button in Xcode or press `Cmd + R`.

## Usage

- **Login**: Enter your username and password, then tap the "Login" button to access your account.
- **Register**: Tap "Don't have an account? Register" to create a new account. Fill in your details and tap "Register".

## License

This project is licensed under the MIT License.
