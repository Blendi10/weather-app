🌦️ Weather App

A Flutter weather application that fetches real-time weather data from OpenWeather API
.
It supports:

Weather by current location (with fallback to default).

Weather by city search (bottom sheet picker).

Switching between Metric / Imperial / Standard units.

Display of conditions, wind, humidity, rain/snow, and cloud coverage.

🚀 Getting Started
✅ Prerequisites

Flutter
 installed
Check installation:

flutter doctor


A valid OpenWeather API key (free tier supports /data/2.5/weather).

📥 Installation

Clone this repo and install dependencies:

git clone https://github.com/<your-username>/weather-app.git
cd weather_app
flutter pub get

⚙️ Configuration

Create a .env file in the project root:

API_KEY=0b2fe332acfcb58d151ae9e8f184124a
BASE_URL=https://api.openweathermap.org/data/2.5
IMG_URL=http://openweathermap.org/img/wn


In pubspec.yaml, ensure assets are listed:

flutter:
  assets:
    - .env
    - assets/images/

📱 Platform Setup
Android

Add permissions in android/app/src/main/AndroidManifest.xml:

<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION"/>
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION"/>

iOS

In ios/Runner/Info.plist:

<key>NSLocationWhenInUseUsageDescription</key>
<string>We use your location to show local weather.</string>


If you use CocoaPods:

cd ios
pod install
cd ..

▶️ Run the app

Run on your device or emulator:

flutter run

Or specify a platform:

flutter run -d ios
flutter run -d android

🌍 Features

City Picker: Choose from popular cities via bottom sheet search.

Location Based Weather: Automatically fetches your local weather (with cache + fallback).

Weather Units: Switch between °C / °F / Kelvin easily.

Dynamic Icons: Displays condition icons directly from OpenWeather.

🛠️ Troubleshooting

401 Unauthorized: Check .env is set correctly and API key is valid.

“.env not found”: Ensure it exists at root and added under assets in pubspec.yaml.

iOS build issues: Update ios/Podfile with platform :ios, '12.0', then run pod install.

Location denied: The app falls back to a default (Munich), but you can manually pick a city after.