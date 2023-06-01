import 'package:ceuk_user_app/core/design_system/color_shemes.dart';
import 'package:ceuk_user_app/core/logics/generalLogics.dart';
import 'package:ceuk_user_app/core/providers/vendor_data_provider.dart';
import 'package:ceuk_user_app/vendor/authentication/views/vendor_auth_api.dart';
import 'package:ceuk_user_app/vendor_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({Key key}) : super(key: key);

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  bool isStarting = true;
  Future<void> pageLoaded(BuildContext context) async {
    Future.delayed(const Duration(seconds: 4), () async {
      handleDestination(context);
    });
  }

  handleDestination(context) async {
    var authToken = await GeneralLogics.getToken();
    VendorDataProvider vendorDataProvider =
        Provider.of<VendorDataProvider>(context, listen: false);
    if (authToken == null) {
      Navigator.pushReplacementNamed(
        context,
        VendorRoutes.welcome,
      );
    } else {
      VendorAuthApi request = VendorAuthApi();
      await request.getVendorData(context: context).then(
        (value) async {
          if (value != null) {
            Map data = {'user': value['data']};
            GeneralLogics.setVendorData(vendorDataProvider, data);
            Navigator.pushReplacementNamed(context, VendorRoutes.home,
                arguments: <String, dynamic>{});
          } else {
            GeneralLogics.removeUserData();
            Navigator.pushReplacementNamed(
              context,
              VendorRoutes.welcome,
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
