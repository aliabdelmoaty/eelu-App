import 'package:go_router/go_router.dart';
import 'package:payment/features/course/presentation/view/course_screen.dart';
import 'package:payment/features/home/presentation/view/home_screen.dart';
import 'package:payment/features/login/presentation/view/login_screen.dart';
import 'package:payment/features/profile/presentation/view/profile_screen.dart';
import 'package:payment/features/register/presentation/view/register_screen.dart';

abstract class AppRouter {
  static const String home = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String course = '/course';
  static const String profile = '/profile';



  static final router = GoRouter(routes: [
    GoRoute(
      path: home,
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: login,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: register,
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: course,
      builder: (context, state) => const CourseScreen(),
    ),
    GoRoute(
      path: profile,
      builder: (context, state) => const ProfileScreen(),
    ),
    
  ]);
}
