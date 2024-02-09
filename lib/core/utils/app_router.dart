import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:payment/core/constant.dart';
import 'package:payment/features/course/presentation/view/course_screen.dart';
import 'package:payment/features/course/presentation/view/data/cubit/course_cubit.dart';
import 'package:payment/features/course/presentation/view/widgets/pdf_view.dart';
import 'package:payment/features/course/presentation/view/widgets/video_play.dart';
import 'package:payment/features/forgot%20Password/presentation/data/cubit/forgot_password_cubit.dart';
import 'package:payment/features/forgot%20Password/presentation/view/forgot_password_screen.dart';
import 'package:payment/features/home/presentation/data/cubit/home_cubit.dart';
import 'package:payment/features/home/presentation/view/home_screen.dart';
import 'package:payment/features/login/presentation/data/cubit/login_cubit.dart';
import 'package:payment/features/login/presentation/view/login_screen.dart';
import 'package:payment/features/profile/presentation/data/cubit/profile_cubit.dart';
import 'package:payment/features/profile/presentation/view/profile_screen.dart';
import 'package:payment/features/register/model/register_model.dart';
import 'package:payment/features/register/presentation/data/cubit/register_cubit.dart';
import 'package:payment/features/register/presentation/view/register_screen.dart';

abstract class AppRouter {
  static final String register =
      (token.isEmpty || token == '') ? '/' : '/register';
  static final String home = (token.isEmpty || token == '') ? '/home' : '/';
  static const String login = '/login';
  static const String course = '/course';
  static const String profile = '/profile';
  static const String forgot = '/forgot';
  static const String pdfView = '/pdfView';
  static const String video = '/video';

  static final router = GoRouter(routes: [
    GoRoute(
      path: home,
      builder: (context, state) => BlocProvider(
        create: (context) => HomeCubit()
          ..getCourses()
          ..getDataCourses()
          ..getDataUser(),
        child: const HomeScreen(),
      ),
    ),
    GoRoute(
      path: forgot,
      builder: (context, state) => BlocProvider(
        create: (context) => ForgotPasswordCubit(),
        child: const ForgotPasswordScreen(),
      ),
    ),
    GoRoute(
      path: login,
      builder: (context, state) => BlocProvider(
        create: (context) => LoginCubit(),
        child: const LoginScreen(),
      ),
    ),
    GoRoute(
      path: register,
      builder: (context, state) => BlocProvider(
        create: (context) => RegisterCubit(),
        child: const RegisterScreen(),
      ),
    ),
    GoRoute(
      path: course,
      builder: (context, state) {
        return BlocProvider(
          create: (context) => CourseCubit(),
          child: CourseScreen(
              title: (state.extra as Map<String, dynamic>)['title'].toString(),
              
              itemCourseModel:
                  (state.extra as Map<String, dynamic>)['itemCourseModel'],
                
                  ),
                  
        );
      },
    ),
    GoRoute(
      path: profile,
      builder: (context, state) => BlocProvider(
        create: (context) => ProfileCubit(),
        child: ProfileScreen(userData: state.extra as RegisterModel),
      ),
    ),
    GoRoute(
      path: pdfView,
      builder: (context, state) => PdfView(
        linkPdf: (state.extra as Map<String, dynamic>)['linkPdf'].toString(),
        title: (state.extra as Map<String, dynamic>)['title'].toString(),
        cubit: (state.extra as Map<String, dynamic>)['cubit'] as CourseCubit
      ),
    ),
    GoRoute(
      path: video,
      builder: (context, state) => VideoPlayer(
        title: (state.extra as Map<String, dynamic>)['title'].toString(),
        urlVideo: (state.extra as Map<String, dynamic>)['urlVideo'].toString(),
        cubit: (state.extra as Map<String, dynamic>)['cubit'] as CourseCubit
      ),
    ),
  ]);
}
