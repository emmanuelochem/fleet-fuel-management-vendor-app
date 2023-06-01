import 'package:ceuk_user_app/core/providers/user_data_provider.dart';
import 'package:ceuk_user_app/core/providers/vendor_data_provider.dart';
import 'package:ceuk_user_app/core/providers/vstaff_data_provider.dart';
import 'package:ceuk_user_app/staffs_main.dart';
import 'package:ceuk_user_app/user_main.dart';
import 'package:ceuk_user_app/vendor_main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Widget userApp = MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => UserDataProvider()),
    ],
    child: UserMain(),
  );

  Widget vendorApp = MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => VendorDataProvider()),
    ],
    child: VendorMain(),
  );

  Widget vStaffApp = MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => StaffDataProvider()),
    ],
    child: StaffMain(),
  );
  //runApp(userApp);
  //runApp(vendorApp);
  runApp(vStaffApp);
}
