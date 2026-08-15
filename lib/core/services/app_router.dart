import 'package:go_router/go_router.dart';
import 'package:salahly/core/utils/widgets/main_navigation_view.dart';
import 'package:salahly/features/auth/presentation/views/forgot_password_view.dart';
import 'package:salahly/features/auth/presentation/views/login_view.dart';
import 'package:salahly/features/auth/presentation/views/register_view.dart';
import 'package:salahly/features/client/booking/presentation/views/booking_view.dart';
import 'package:salahly/features/client/booking/presentation/views/my_booking_view.dart';
import 'package:salahly/features/client/home/data/models/technician_model.dart';
import 'package:salahly/features/client/home/presentation/views/home_view.dart';
import 'package:salahly/features/client/profile/presentation/views/profile_view.dart';
import 'package:salahly/features/onboarding/presentation/views/onboarding_view.dart';
import 'package:salahly/features/onboarding/presentation/views/splash_view.dart';

abstract class AppRouter {
  static const kSplashView = '/';
  static const kOnboardingView = '/onboardingView';
  static const kLoginView = '/loginView';
  static const kRegisterView = '/registerView';
  static const kForgotPasswordView = '/forgotPasswordView';
  static const kHomeView = '/homeView';
  static const kBookingsView = '/bookingsView';
  static const kMyBookingsView = '/myBookingsView';
  static const kProfileView = '/profileView';

  static final router = GoRouter(
    initialLocation: kHomeView,
    routes: [
      GoRoute(
        path: kSplashView,
        builder: (context, state) => const SplashView(),
      ),
      GoRoute(
        path: kOnboardingView,
        builder: (context, state) => const OnboardingView(),
      ),
      GoRoute(path: kLoginView, builder: (context, state) => const LoginView()),
      GoRoute(
        path: kRegisterView,
        builder: (context, state) => const RegisterView(),
      ),
      GoRoute(
        path: kForgotPasswordView,
        builder: (context, state) => const ForgotPasswordView(),
      ),

      GoRoute(
        path: kBookingsView,
        builder: (context, state) {
         
          final data = state.extra as Map<String, dynamic>?;

          return BookingView(
            categoryName: data?['categoryName'] as String?,
            technician: data?['technician'] as TechnicianModel?,
          );
        },
      ),

      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainNavigationView(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: kHomeView,
                builder: (context, state) => const HomeView(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: kMyBookingsView,
                builder: (context, state) => const MyBookingsView(),
              ),
            ],
          ),
           StatefulShellBranch(
            routes: [
              GoRoute(
                path: kProfileView,
                builder: (context, state) => const ProfileView(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
