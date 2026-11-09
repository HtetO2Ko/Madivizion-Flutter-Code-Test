import 'package:go_router/go_router.dart';
import 'package:j_donut/features/welcome/presentation/screens/welcome_screen.dart';

import '../../features/auth/presentation/screens/app_startup_screen.dart';
import '../../features/auth/presentation/screens/date_of_birth_screen.dart';
import '../../features/auth/presentation/screens/name_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/onboarding/presentation/screens/onboarding_screen.dart';
import '../../features/auth/presentation/screens/phone_number_screen.dart';
import '../../features/auth/presentation/screens/otp_screen.dart';
import 'route_names.dart';

class AppRouter {
  AppRouter._();

  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/splash',
        name: 'splash',
        builder: (context, state) => const AppStartupScreen(),
      ),

      GoRoute(
        path: '/',
        name: AppRouteNames.onboarding,
        builder: (context, state) {
          return const OnboardingScreen();
        },
      ),

      GoRoute(
        path: '/auth/phone',
        name: AppRouteNames.phoneNumber,
        builder: (context, state) {
          return PhoneNumberScreen();
        },
      ),

      GoRoute(
        path: '/auth/otp',
        name: AppRouteNames.otp,
        builder: (context, state) {
          final phoneNumber = state.uri.queryParameters['phone'] ?? '';
          return OtpScreen(phoneNumber: phoneNumber);
        },
      ),

      GoRoute(
        path: '/auth/name',
        name: AppRouteNames.name,
        builder: (context, state) {
          return NameScreen(
            phoneNumber: state.uri.queryParameters['phone'] ?? '',
            firstName: state.uri.queryParameters['firstName'],
            lastName: state.uri.queryParameters['lastName'],
          );
        },
      ),

      GoRoute(
        path: '/auth/date-of-birth',
        name: AppRouteNames.dateOfBirth,
        builder: (context, state) {
          return DateOfBirthScreen(
            phoneNumber: state.uri.queryParameters['phone'] ?? '',
            firstName: state.uri.queryParameters['firstName'] ?? '',
            lastName: state.uri.queryParameters['lastName'] ?? '',
          );
        },
      ),

      GoRoute(
        name: AppRouteNames.welcome,
        path: '/welcome',
        builder: (context, state) {
          return WelcomeScreen();
        },
      ),

      GoRoute(
        name: AppRouteNames.home,
        path: '/home',
        builder: (context, state) {
          return HomeScreen();
        },
      ),
    ],
  );
}
