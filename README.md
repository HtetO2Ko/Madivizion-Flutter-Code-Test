
# J'Donuts — Flutter Application

A Flutter mobile application for J'Donuts, featuring user authentication, product browsing, membership rewards, and offline data persistence.

## 1. Requirements

- Flutter: 3.47.9

Check your installed versions:

```bash
flutter --version
```

## 2. Getting Started

Clone the repository:

```bash
git clone https://github.com/HtetO2Ko/Madivizion-Flutter-Code-Test.git
cd Madivizion-Flutter-Code-Test
```

Install dependencies:

```bash
flutter pub get
```

Run the application:

```bash
flutter run
```

Build Android APK:

```bash
flutter build apk --release
```

## 3. Architecture

The project follows a feature-first architecture inspired by Clean Architecture.

Each feature is divided into three layers:

- **Presentation:** Screens, widgets, BLoC, events, and states.
- **Domain:** Business logic, entities, and repository contracts.
- **Data:** Repository implementations, data sources, and models.

This structure separates UI, business logic, and data handling to improve maintainability and testability.

## 4. Folder Structure

```text
lib/
├── app/
│   └── router/
│
├── core/
│   ├── database/
│   │   ├── app_database.dart
│   │   ├── banner_seeder.dart
│   │   ├── member_seeder.dart
│   │   ├── product_seeder.dart
│   │   └── shop_seeder.dart
│   │
│   ├── storage/
│   │   └── session_storage.dart
│   │
│   ├── theme/
│   └── widgets/
│
├── features/
│   ├── auth/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   │
│   ├── home/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   │
│   ├── product/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   │
│   ├── rewards/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   │
│   └── setting/
│       ├── data/
│       ├── domain/
│       └── presentation/
│
├── injection_container.dart
└── main.dart
```

## 5. State Management

The application uses **flutter_bloc (BLoC)** for state management.

BLoC separates user interactions from business logic through events and states.

Examples:

- `RewardsBloc`: Handles rewards loading and tab selection.
- `DateOfBirthBloc`: Handles date-of-birth selection and validation.
- `SettingsBloc`: Handles settings actions, including logout.

This approach makes application state predictable and easier to maintain and test.

## 6. Dependency Injection

The application uses **get_it** for dependency injection.

Repositories, database services, seeders, and other dependencies are registered in:

```text
lib/injection_container.dart
```

Dependencies are accessed through GetIt instead of manually creating instances throughout the application.

## 7. Navigation

The application uses **go_router** for navigation.

It handles navigation between onboarding, authentication, home, product details, rewards, and settings.

The logout flow:

1. User requests logout.
2. Local database is cleared.
3. Secure session information is removed.
4. Application navigates to `/splash`.
5. Splash checks the session and redirects to the appropriate screen.

## 8. Offline Strategy

The application uses local persistence to support offline data access.

### SQLite Database

SQLite is used to store application data, including:

- User information
- Products
- Banners
- Member information
- Shops

### Database Seeding

Seeders populate the local database with initial data when required:

- `ProductSeeder`
- `BannerSeeder`
- `MemberSeeder`
- `ShopSeeder`

### Secure Session Storage

The application uses `flutter_secure_storage` to store session information.

The current implementation stores the user's phone number using:

```text
session_phone_number
```

The session can be retrieved using `SessionStorage.getPhoneNumber()` and cleared using `SessionStorage.clearSession()`.

## 9. Animations

The application uses Flutter's built-in animation widgets.

### Rewards Screen

- Animated rewards tab indicator using `AnimatedPositioned`.
- Animated tab text using `AnimatedDefaultTextStyle`.
- Rewards badge entrance animation.
- Points ring animation.
- Membership tier presentation.

Other implemented animations should be documented here as applicable.

## 10. Fake OTP

The application uses a simulated OTP verification flow for demonstration purposes.

**Test OTP:**

```text
123456
```

Enter this six-digit code to complete OTP verification.


## 13. Time Spent

**Total development time:** 18 hours
