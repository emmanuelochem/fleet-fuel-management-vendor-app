import 'package:ceuk_user_app/user/authentication/register/register_otp.dart';
import 'package:ceuk_user_app/user/authentication/register/register_page.dart';
import 'package:ceuk_user_app/user/authentication/views/login_page.dart';
import 'package:ceuk_user_app/user/authentication/views/splashscreen.dart';
import 'package:ceuk_user_app/user/authentication/views/welcome_page.dart';
import 'package:ceuk_user_app/user/dashboard/home/user_dashboard.dart';
import 'package:ceuk_user_app/user/dashboard/messenger/update_messenger.dart';
import 'package:ceuk_user_app/user/dashboard/vehicle/update_vehicle.dart';
import 'package:ceuk_user_app/vendor/authentication/register/register_phone.dart';
import 'package:flutter/material.dart';

class UserRoutes {
  static const String splashScreen = '/splash-screen';
  static const String welcome = '/welcome-screen';
  static const String getStarted = '/get-sarted';

  static const String registerPhone = '/register-phone';
  static const String registerOtp = '/register-otp';
  static const String registerInfo = '/register-pin';
  static const String login = '/login';
  static const String resetPassword = '/reset-pasword';
  static const String home = '/home';
  static const String updateVehicle = '/update-vehicle';
  static const String updateMessenger = '/update-messenger';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreenPage());
      case welcome:
        return MaterialPageRoute(builder: (_) => const NewWelcomePage());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case registerPhone:
        return MaterialPageRoute(builder: (_) => const RegisterPhone());
      case registerOtp:
        final Map args = settings.arguments as Map;
        return MaterialPageRoute(
          builder: (context) => RegisterOTP(
            phoneNumber: args['phone_number'],
          ),
        );
      case registerInfo:
        final Map args = settings.arguments as Map;
        return MaterialPageRoute(
          builder: (context) => RegisterPage(
            phoneNumber: args['phone_number'],
          ),
        );
      case home:
        return MaterialPageRoute(builder: (_) => const UserDashboardPage());
      case updateVehicle:
        final Map args = settings.arguments as Map;
        return MaterialPageRoute(
          builder: (context) => UpdateVehicle(
            vehicleData: args['vehicleData'],
          ),
        );
      case updateMessenger:
        final Map args = settings.arguments as Map;
        return MaterialPageRoute(
          builder: (context) => UpdateMessenger(
            messengerData: args['messengerData'],
          ),
        );
      // case welcomeScreen:
      //   return MaterialPageRoute(builder: (_) => const WelcomeScreen());
      // case registerPhone:
      //   return MaterialPageRoute(builder: (_) => const LoginPhone());

      // case resetPassword:
      //   return MaterialPageRoute(builder: (_) => ForgotPasswordPage());
      // case registerOtp:
      //   final Map args = settings.arguments as Map;
      //   return MaterialPageRoute(
      //       builder: (_) => RegisterOTP(
      //             phoneData: args['phoneData'],
      //             accountData: args['accountData'],
      //           ));
      // case registerInfo:
      //   final Map args = settings.arguments as Map;
      //   return MaterialPageRoute(builder: (_) => const RegisterInfo());
      // case home:
      //   final Map args = settings.arguments as Map;
      //   return MaterialPageRoute(builder: (_) => HomePage());
      // case createInflow:
      //   final Map args = settings.arguments as Map;
      //   return MaterialPageRoute(
      //       builder: (_) =>
      //           AddFlowRecord(recordFlowType: args['recordFlowType']));
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: SafeArea(
              child: Center(
                child: Text('User Route not found.'),
              ),
            ),
          ),
        );
    }
  }
}
