import 'package:ceuk_user_app/staffs_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StaffMain extends StatelessWidget {
  StaffMain({Key key}) : super(key: key);

  // This widget is the root of your application.
  final _navigatorKey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(428, 926),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (theme, darkTheme) {
          return MaterialApp(
            navigatorKey: _navigatorKey,
            title: 'Ceuc Attendant',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                visualDensity: VisualDensity.adaptivePlatformDensity,
                scaffoldBackgroundColor: Colors.white),
            onGenerateRoute: StaffsRoutes.generateRoute,
            initialRoute: StaffsRoutes.splashScreen,
          );
        });
  }
}
