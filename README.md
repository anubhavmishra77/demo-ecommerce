# E-Commerce Shop App Design for Homepage

A Flutter e-commerce shop app that demonstrates modern UI implementation with GetX state management and API integration.

## Features

- Modern UI with Material Design 3
- Product listing with lazy loading
- Search functionality
- Like/Unlike products with animations
- Pull-to-refresh
- Shimmer loading effects
- Error handling with retry options
- Smooth animations and micro-interactions

## Getting Started

### Prerequisites

- Flutter (latest stable version)
- Android Studio / VS Code
- An Android/iOS device or emulator

### Installation

1. **Install Flutter**
   bash
   # Download Flutter from https://flutter.dev/docs/get-started/install
   # Add Flutter to your PATH
   
   # Verify installation
   flutter doctor
   

2. **Clone the Repository**
   bash
   git clone https://github.com/anubhavmishra77/demo-ecommerce.git
   cd ecommerce-shop-app
   

3. **Install Dependencies**
   bash
   flutter pub get
   

4. **Run the App**
   bash
   # Debug mode
   flutter run

   # Release mode
   flutter run --release
   

### Building for Release

1. **Android**
   bash
   # Generate APK
   flutter build apk --release

   # Generate Android App Bundle
   flutter build appbundle --release
   
   APK location: `build/app/outputs/flutter-apk/app-release.apk`

2. **iOS**
   bash
   # From the root of the project
   cd ios
   pod install
   cd ..
   flutter build ios --release
   

### Troubleshooting

1. **Clean and Rebuild**
   bash
   flutter clean
   flutter pub get
   flutter run
   
