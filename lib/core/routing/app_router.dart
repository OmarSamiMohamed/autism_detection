import 'package:flutter/material.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/register_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/home/presentation/pages/diagnosis_page.dart';
import '../../features/questions/presentation/pages/questions_page.dart';
import '../../features/questions/presentation/pages/repetitive_behaviors_page.dart';
import '../../features/questions/presentation/pages/social_interaction_page.dart';
import '../../features/questions/presentation/pages/communication_page.dart';
import '../../features/questions/presentation/pages/self_care_page.dart';
import '../../features/questions/presentation/pages/attention_page.dart';
import '../../features/report/presentation/pages/loading_page.dart';
import '../../features/report/presentation/pages/report_page.dart';
import '../../features/auth/presentation/pages/forgot_password_page.dart';
import '../../features/auth/presentation/pages/forget_verify_page.dart';
import '../../features/auth/presentation/pages/pass_change_page.dart';
import '../../features/auth/presentation/pages/password_change_success_page.dart';
import '../../features/auth/presentation/pages/register_verify_page.dart';
import '../../features/auth/presentation/pages/register_success_page.dart';
import '../../features/home/presentation/pages/image_upload_page.dart';
import '../../features/report/presentation/pages/result_page.dart';
import '../../features/support/presentation/pages/support_page.dart';
import '../../features/support/presentation/pages/support_content_page.dart';

class AppRouter {
  static const String login = '/login';
  static const String register = '/register';
  static const String forgetPassword = '/forget-password';
  static const String forgetVerify = '/forget-verify';
  static const String passChange = '/pass-change';
  static const String passChangeSuccess = '/pass-change-success';
  static const String registerVerify = '/register-verify';
  static const String registerSuccess = '/register-success';
  static const String home = '/home';
  static const String diagnosis = '/diagnosis';
  static const String questions = '/questions';
  static const String repetitiveBehaviors = '/repetitive-behaviors';
  static const String socialInteraction = '/social-interaction';
  static const String communication = '/communication';
  static const String selfCare = '/self-care';
  static const String attention = '/attention';
  static const String loading = '/loading';
  static const String report = '/report';
  static const String support = '/support';
  static const String supportContent = '/support-content';
  static const String imageUpload = '/image-upload';
  static const String result = '/result';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case register:
        return MaterialPageRoute(builder: (_) => const RegisterPage());
      case home:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case diagnosis:
        return MaterialPageRoute(builder: (_) => const DiagnosisPage());
      case questions:
        return MaterialPageRoute(builder: (_) => const QuestionsPage());
      case repetitiveBehaviors:
        return MaterialPageRoute(
            builder: (_) => const RepetitiveBehaviorsPage());
      case socialInteraction:
        return MaterialPageRoute(builder: (_) => const SocialInteractionPage());
      case communication:
        return MaterialPageRoute(builder: (_) => const CommunicationPage());
      case selfCare:
        return MaterialPageRoute(builder: (_) => const SelfCarePage());
      case attention:
        return MaterialPageRoute(builder: (_) => const AttentionPage());
      case loading:
        return MaterialPageRoute(builder: (_) => const LoadingPage());
      case report:
        return MaterialPageRoute(builder: (_) => const ReportPage());
      case support:
        return MaterialPageRoute(builder: (_) => const SupportPage());
      case supportContent:
        return MaterialPageRoute(builder: (_) => const SupportContentPage());
      case forgetPassword:
        return MaterialPageRoute(builder: (_) => const ForgetPassPage());
      case forgetVerify:
        return MaterialPageRoute(
            builder: (_) => const ForgetVerificationScreen());
      case passChange:
        return MaterialPageRoute(builder: (_) => const PassChange());
      case passChangeSuccess:
        return MaterialPageRoute(
            builder: (_) => const PasswordChangedSuccessPage());
      case registerVerify:
        return MaterialPageRoute(
            builder: (_) => const RigesterVerificationScreen());
      case registerSuccess:
        return MaterialPageRoute(builder: (_) => const SucsessNewacc());
      case imageUpload:
        return MaterialPageRoute(builder: (_) => const ImageUploadPage());
      case result:
        return MaterialPageRoute(builder: (_) => const ResultPage());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
