# ☕ Espress Yo Self

**Sustainable Coffee Rewards & Loyalty Mobile App**

A Flutter-based mobile application that promotes sustainable coffee consumption through a comprehensive rewards system, encouraging eco-friendly choices while providing an engaging user experience for coffee enthusiasts.

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Firebase](https://img.shields.io/badge/Firebase-039BE5?style=for-the-badge&logo=Firebase&logoColor=white)
![Supabase](https://img.shields.io/badge/Supabase-3ECF8E?style=for-the-badge&logo=supabase&logoColor=white)

## 📋 Project Overview

Espress Yo Self is a modern coffee shop loyalty application that combines traditional rewards systems with sustainable practices. The app allows users to:

- **Track Coffee Purchases**: Scan QR codes after purchasing coffee to earn points and stamps
- **Sustainable Rewards**: Get bonus points (50% extra) for purchasing eco-friendly coffee products
- **Digital Stamp System**: Collect stamps with each purchase to earn free coffee (10 stamps = 1 free coffee)
- **User Profile Management**: Customize profiles with photo uploads and personal information
- **Transaction History**: View detailed purchase history and track rewards earned
- **Real-time Authentication**: Secure login via email/password or Google Sign-In

## 🎯 Chosen SDG and Justification

**Primary SDG: Goal 12 - Responsible Consumption and Production**

This application directly supports SDG 12 by:

- **Promoting Sustainable Consumption**: The app incentivizes users to choose eco-friendly coffee products through bonus point systems
- **Supporting Sustainable Business Practices**: Features like QR code scanning and digital rewards reduce paper waste from traditional stamp cards
- **Educating Consumers**: The app highlights eco-friendly products (Organic Fair Trade Coffee, Sustainable Cold Brew, Plant-Based Latte) to raise awareness about sustainable consumption choices
- **Measuring Impact**: The transaction system tracks eco-friendly purchases, allowing both users and businesses to monitor their sustainable consumption patterns

**Secondary SDG Support:**

- **Goal 3 (Good Health and Well-being)**: Promotes organic and plant-based coffee options
- **Goal 13 (Climate Action)**: Encourages environmentally conscious consumption choices

## 🛠️ Tech Stack

### **Frontend**

- **Flutter 3.6.0+** - Cross-platform mobile development
- **Dart** - Programming language
- **Flutter Riverpod 2.6.1** - State management
- **Go Router 15.1.1** - Navigation and routing
- **Flutter ScreenUtil 5.9.3** - Responsive UI design

### **Backend & Services**

- **Firebase** - Backend-as-a-Service
  - Firebase Auth - User authentication
  - Cloud Firestore - NoSQL database
  - Firebase Analytics - App analytics
  - Firebase Crashlytics - Crash reporting
  - Firebase Performance - Performance monitoring
- **Supabase** - Additional backend services and storage

### **UI/UX Libraries**

- **Flutter SVG 2.1.0** - SVG asset rendering
- **Google Fonts 6.2.1** - Typography
- **Lottie 3.3.1** - Animations
- **Cached Network Image 3.4.1** - Image caching
- **Material 3** - Design system

### **Device Features**

- **Mobile Scanner 5.0.1** - QR code scanning
- **Image Picker 1.1.2** - Camera and gallery access
- **Permission Handler 12.0.0+1** - Device permissions
- **Google Sign In 6.3.0** - OAuth authentication
- **Shared Preferences 2.5.3** - Local data storage

### **Development Tools**

- **Build Runner 2.4.15** - Code generation
- **Freezed 3.0.6** - Data class generation
- **JSON Annotation/Serializable** - JSON handling
- **Flutter Lints 5.0.0** - Code quality

## 🚀 Setup & Installation Instructions

### Prerequisites

- Flutter SDK 3.6.0 or higher
- Dart SDK
- Android Studio / VS Code
- Android SDK (for Android development)
- Xcode (for iOS development - macOS only)

### 1. Clone the Repository

```bash
git clone <repository-url>
cd espress_yo_self
```

### 2. Install Dependencies

```bash
flutter pub get
```

### 3. Environment Configuration

Create environment variables for Firebase and Supabase:

```bash
# Add these to your environment or create a .env file
FIREBASE_API_KEY=your_firebase_api_key
FIREBASE_APP_ID=your_firebase_app_id
FIREBASE_MESSAGING_SENDER_ID=your_sender_id
FIREBASE_PROJECT_ID=your_project_id
FIREBASE_STORAGE_BUCKET=your_storage_bucket
SUPABASE_URL=your_supabase_url
SUPABASE_ANON_KEY=your_supabase_anon_key
```

### 4. Firebase Setup

1. Create a new Firebase project at [Firebase Console](https://console.firebase.google.com/)
2. Add Android/iOS apps to your Firebase project
3. Download and place `google-services.json` in `android/app/`
4. For iOS, place `GoogleService-Info.plist` in `ios/Runner/`
5. Enable Authentication, Firestore, and other required services

### 5. Code Generation

```bash
flutter packages pub run build_runner build
```

### 6. Run the Application

```bash
# For development
flutter run

# For specific platform
flutter run -d android
flutter run -d ios

# For release build
flutter run --release
```

## 📱 How to Use / Contribution Guidelines

### For Users:

1. **Sign Up/Login**: Create an account or sign in with Google
2. **Complete Profile**: Add your name and profile picture
3. **Scan QR Codes**: After purchasing coffee, scan the QR code to earn points
4. **Track Progress**: View your points and stamp progress in the Rewards section
5. **Redeem Rewards**: Use collected stamps or points to redeem free coffee
6. **Choose Eco-Friendly**: Look for eco-friendly coffee options to earn bonus points

### For Contributors:

#### Getting Started

1. Fork the repository
2. Create a feature branch: `git checkout -b feature/amazing-feature`
3. Follow the existing code structure and architectural patterns

#### Code Style Guidelines

- Follow Flutter/Dart coding conventions
- Use Riverpod for state management
- Implement proper error handling
- Write meaningful commit messages
- Add comments for complex business logic

#### Architecture

The app follows Clean Architecture principles:

- **Presentation Layer**: UI components and ViewModels
- **Domain Layer**: Business logic and entities
- **Data Layer**: Repositories and data sources

#### Folder Structure

```
lib/
├── constants/          # App constants and themes
├── data/              # Data layer (repositories, models, services)
├── di/                # Dependency injection
├── domain/            # Domain layer (entities, use cases)
├── presentation/      # UI layer (screens, widgets, view models)
├── routes/            # App routing configuration
└── utils/             # Utility functions
```

#### Testing

```bash
# Run tests
flutter test

# Run tests with coverage
flutter test --coverage
```

#### Pull Request Process

1. Ensure your code follows the style guidelines
2. Update documentation if needed
3. Test your changes thoroughly
4. Create a descriptive pull request

## 🔥 Firebase Usage

### Authentication

- Email/Password authentication
- Google Sign-In integration
- User profile management with profile picture upload

### Cloud Firestore Collections

- **users**: User profiles and account information
- **transactions**: Coffee purchase history and points earned
- **rewards**: Available rewards and redemption options
- **stamp_progress**: User stamp collection progress
- **user_redemptions**: Redeemed rewards history

### Real-time Features

- Live transaction updates
- Real-time reward status
- Instant point calculations

### Analytics & Performance

- User engagement tracking
- Purchase pattern analysis
- App performance monitoring
- Crash reporting and debugging

### Security Rules

The app implements secure Firestore rules to protect user data and ensure proper access control.

## 📦 APK Download Links

### Latest Release v1.0.0

| Architecture            | Download Link                                                                                     | Size   |
| ----------------------- | ------------------------------------------------------------------------------------------------- | ------ |
| **ARM64 (arm64-v8a)**   | [Download APK](https://github.com/your-repo/releases/download/v1.0.0/app-arm64-v8a-release.apk)   | ~45 MB |
| **ARM32 (armeabi-v7a)** | [Download APK](https://github.com/your-repo/releases/download/v1.0.0/app-armeabi-v7a-release.apk) | ~42 MB |
| **x86_64**              | [Download APK](https://github.com/your-repo/releases/download/v1.0.0/app-x86_64-release.apk)      | ~48 MB |

**Recommended**: Download ARM64 version for most modern Android devices (2019+)

### System Requirements

- Android 5.0 (API level 21) or higher
- 100 MB free storage space
- Internet connection for full functionality
- Camera permission for QR code scanning

## 🌟 Features Highlight

### 🎯 Core Features

- **QR Code Scanning**: Advanced mobile scanner for quick purchase tracking
- **Point System**: Earn 1 point per Rp. 1000 spent
- **Stamp Collection**: Digital stamp card system (10 stamps = free coffee)
- **Eco Bonus**: 50% extra points for sustainable coffee choices
- **Profile Management**: Complete user profile with image upload
- **Purchase History**: Detailed transaction tracking

### 🌱 Sustainability Features

- **Eco-Friendly Product Identification**: Automatic detection of sustainable products
- **Bonus Point System**: Incentivizes eco-conscious choices
- **Sustainable Product Catalog**: Features organic, fair trade, and plant-based options
- **Impact Tracking**: Monitor your sustainable consumption patterns

### 📊 Analytics & Insights

- **Purchase Analytics**: Track spending patterns and preferences
- **Reward Analytics**: Monitor points earned and stamps collected
- **Eco Impact**: View your contribution to sustainable consumption

### 🔐 Security & Privacy

- **Secure Authentication**: Firebase Auth with Google Sign-In
- **Data Protection**: Encrypted storage and secure API communications
- **Privacy Controls**: User-controlled data sharing preferences

## 🤝 Contributing

We welcome contributions! Please see our [Contributing Guidelines](CONTRIBUTING.md) for details.

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 📞 Support

For support, email support@espressyoself.com or join our [Discord community](https://discord.gg/espressyoself).

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Firebase for robust backend services
- The open-source community for the packages used
- Coffee shops promoting sustainable practices

---

**Made with ☕ and 💚 for a sustainable future**
