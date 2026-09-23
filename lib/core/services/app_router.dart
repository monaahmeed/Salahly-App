import 'package:go_router/go_router.dart';
import 'package:salahly/core/models/service_request_model.dart';
import 'package:salahly/core/utils/widgets/main_navigation_view.dart';
import 'package:salahly/core/utils/widgets/technician_navigation_view.dart';
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
import 'package:salahly/features/technician/dashboard/presentation/views/dashboard_view.dart';
import 'package:salahly/features/technician/jobs/presentation/views/job_invoice_view.dart';
import 'package:salahly/features/technician/jobs/presentation/views/jobs_view.dart';
import 'package:salahly/features/technician/profile/presentation/views/technician_reviews_view.dart';
import 'package:salahly/features/technician/profile/presentation/views/widgets/technician_profile_view_body.dart';
import 'package:salahly/features/technician/wallet/presentation/views/wallet_view.dart';

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

  static const kTechnicianDashboard = '/technicianDashboard';
  static const kTechnicianJobs = '/technicianJobs';
  static const kTechnicianWallet = '/technicianWallet';
  static const kTechnicianProfile = '/technicianProfile';
  static const kTechnicianInvoiceJob = '/TechnicianInvoiceJob';
  static const kTechnicianReviews = '/TechnicianReviews';

  static final router = GoRouter(
    initialLocation:   kHomeView ,
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
        path: kTechnicianReviews,
        builder: (context, state) => const TechnicianReviewsView(),
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

      GoRoute(
        path: kTechnicianInvoiceJob,
        builder: (context, state) {
          final request = state.extra  as ServiceRequestModel;
          return JobInvoiceView(request: request);
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

      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return TechnicianNavigationView(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: kTechnicianDashboard,
                builder: (context, state) => const DashboardView(),
              ),
            ],
          ),

          StatefulShellBranch(
            routes: [
              GoRoute(
                path: kTechnicianJobs,
                builder: (context, state) => const JobsView(),
              ),
            ],
          ),

          StatefulShellBranch(
            routes: [
              GoRoute(
                path: kTechnicianWallet,
                builder: (context, state) => const WalletView(),
              ),
            ],
          ),

          StatefulShellBranch(
            routes: [
              GoRoute(
                path: kTechnicianProfile,
                builder: (context, state) => const TechnicianProfileViewBody()
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
