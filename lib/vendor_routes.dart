import 'package:ceuk_user_app/vendor/authentication/register/register_otp.dart';
import 'package:ceuk_user_app/vendor/authentication/register/register_page.dart';
import 'package:ceuk_user_app/vendor/authentication/views/login_page.dart';
import 'package:ceuk_user_app/vendor/authentication/views/splashscreen.dart';
import 'package:ceuk_user_app/vendor/authentication/views/vendor_register.dart';
import 'package:ceuk_user_app/vendor/authentication/views/welcome_page.dart';
import 'package:ceuk_user_app/vendor/dashboard/bank/add_bank.dart';
import 'package:ceuk_user_app/vendor/dashboard/bank/manage_banks.dart';
import 'package:ceuk_user_app/vendor/dashboard/bank/update_bank.dart';
import 'package:ceuk_user_app/vendor/dashboard/staff/vendor_staff_register.dart';
import 'package:ceuk_user_app/vendor/dashboard/transaction/chartspage.dart';
import 'package:ceuk_user_app/vendor/dashboard/home/vendor_dashboard.dart';
import 'package:flutter/material.dart';

class VendorRoutes {
  static const String splashScreen = '/splash-screen';
  static const String welcome = '/welcome-screen';
  static const String getStarted = '/get-sarted';

  static const String registerPhone = '/register-phone';
  static const String registerOtp = '/register-otp';
  static const String registerInfo = '/register-pin';
  static const String login = '/login';
  static const String resetPassword = '/reset-pasword';
  static const String home = '/home';

  static const String banks = '/vendors-bank';
  static const String addbank = '/add-bank';
  static const String updateBank = '/update-bank';

  static const String addstaff = '/add-staff';
  static const String staffs = '/vendor-staff';

  static const String stats = '/stats-pg';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreenPage());
      case welcome:
        return MaterialPageRoute(builder: (_) => const NewWelcomePage());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case registerPhone:
        return MaterialPageRoute(builder: (_) => const VendorRegisterPage());
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

      //
      case home:
        return MaterialPageRoute(builder: (_) => const VendorDashboard());
      case banks:
        return MaterialPageRoute(builder: (_) => const VendorsManageBanks());
      case addbank:
        return MaterialPageRoute(builder: (_) => const VendorAddBank());
      case updateBank:
        final Map args = settings.arguments as Map;
        return MaterialPageRoute(
            builder: (_) => VendorUpdateBank(vendorData: args['vendorData']));
      case addstaff:
        return MaterialPageRoute(builder: (_) => const VendorAddStaffPage());
      case stats:
        return MaterialPageRoute(builder: (_) => const StatsPage());

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: SafeArea(
              child: Center(
                child: Text('Vendor Route not found.'),
              ),
            ),
          ),
        );
    }
  }
}
