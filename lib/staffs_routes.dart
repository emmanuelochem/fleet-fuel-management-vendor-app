import 'package:ceuk_user_app/vendor_staff/authentication/staff_login_page.dart';
import 'package:ceuk_user_app/vendor_staff/authentication/staff_splashscreen.dart';
import 'package:ceuk_user_app/vendor_staff/authentication/staff_welcome_page.dart';
import 'package:ceuk_user_app/vendor_staff/dashboard/home/staff_home.dart';
import 'package:ceuk_user_app/vendor_staff/dashboard/request/staff_request_details_page.dart';
import 'package:flutter/material.dart';

import 'vendor_staff/dashboard/home/staff_dashboard.dart';

class StaffsRoutes {
  static const String splashScreen = '/splash-screen';
  static const String welcome = '/welcome-screen';
  static const String getStarted = '/get-sarted';
  static const String login = '/login';
  static const String resetPassword = '/reset-pasword';
  static const String home = '/home';
  static const String staffs = '/vendor_staff-staff';
  static const String stats = '/stats-pg';
  static const String requestDetails = '/req-details';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashScreen:
        return MaterialPageRoute(builder: (_) => const StaffSplashScreenPage());
      case welcome:
        return MaterialPageRoute(builder: (_) => const StaffNewWelcomePage());
      case login:
        return MaterialPageRoute(builder: (_) => const StaffLoginPage());

      //
      case home:
        return MaterialPageRoute(builder: (_) => const StaffDashboard());
      case stats:
        return MaterialPageRoute(builder: (_) => const StaffHomePage());

      case requestDetails:
        final Map args = settings.arguments as Map;
        return MaterialPageRoute(
            builder: (_) => RequestDetailsPage(
                  requestData: args['requestData'],
                ));

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: SafeArea(
              child: Center(
                child: Text('Staff Route not found.'),
              ),
            ),
          ),
        );
    }
  }
}
