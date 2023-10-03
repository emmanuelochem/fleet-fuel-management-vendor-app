import 'package:ceuk_user_app/core/providers/vstaff_data_provider.dart';
import 'package:ceuk_user_app/staffs_main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Widget vStaffApp = MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => StaffDataProvider()),
    ],
    child: StaffMain(),
  );
  runApp(vStaffApp);
}
