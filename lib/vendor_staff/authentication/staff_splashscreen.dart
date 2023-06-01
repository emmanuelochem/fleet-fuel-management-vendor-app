import 'package:ceuk_user_app/core/design_system/color_shemes.dart';
import 'package:ceuk_user_app/core/logics/generalLogics.dart';
import 'package:ceuk_user_app/core/providers/vstaff_data_provider.dart';
import 'package:ceuk_user_app/staffs_routes.dart';
import 'package:ceuk_user_app/vendor_staff/authentication/staff_auth_api.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class StaffSplashScreenPage extends StatefulWidget {
  const StaffSplashScreenPage({Key key}) : super(key: key);

  @override
  State<StaffSplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<StaffSplashScreenPage> {
  bool isStarting = true;
  Future<void> pageLoaded(BuildContext context) async {
    Future.delayed(const Duration(seconds: 4), () async {
      handleDestination(context);
    });
  }

  handleDestination(context) async {
    var authToken = await GeneralLogics.getToken();
    StaffDataProvider staffDataProvider =
        Provider.of<StaffDataProvider>(context, listen: false);
    if (authToken == null) {
      Navigator.pushReplacementNamed(
        context,
        StaffsRoutes.welcome,
      );
    } else {
      StaffsAuthApi request = StaffsAuthApi();
      await request.getStaffData(context: context).then(
        (value) async {
          if (value != null) {
            Map data = {'user': value['data']};
            GeneralLogics.setStaffData(staffDataProvider, data);
            Navigator.pushReplacementNamed(context, StaffsRoutes.home,
                arguments: <String, dynamic>{});
          } else {
            GeneralLogics.removeUserData();
            Navigator.pushReplacementNamed(
              context,
              StaffsRoutes.welcome,
            );
          }
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isStarting) {
      pageLoaded(context);
      isStarting = false;
    }
    return Scaffold(
      backgroundColor: UIColors.white,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.center,
              child: Image.asset(
                'assets/brand/logo_icon.png',
                width: 0.25.sw,
              ),
            ),
          )
        ],
      ),
    );
  }
}
