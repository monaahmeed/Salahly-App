import 'package:go_router/go_router.dart';
import 'package:salahly/features/auth/presentation/views/login_view.dart';
import 'package:salahly/features/auth/presentation/views/register_view.dart';
import 'package:salahly/features/client/home/presentation/views/home_view.dart';
import 'package:salahly/features/onboarding/presentation/views/onboarding_view.dart';
import 'package:salahly/features/onboarding/presentation/views/splash_view.dart';
import 'package:salahly/features/auth/presentation/views/forgot_password_view.dart';

abstract class AppRouter {
  static const kSplashView = '/';
  static const kOnboardingView = '/onboardingView';
  static const kLoginView = '/loginView';
  static const kRegisterView = '/registerView';
  static const kForgotPasswordView = '/forgotPasswordView';
  static const kHomeView = '/homeView';
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
      GoRoute(path: kHomeView, builder: (context, state) => const HomeView()),
    ],
  );
}
