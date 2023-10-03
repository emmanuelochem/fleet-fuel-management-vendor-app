import 'package:ceuk_user_app/core/design_system/color_shemes.dart';
import 'package:ceuk_user_app/core/design_system/typography_style.dart';
import 'package:ceuk_user_app/core/providers/vstaff_data_provider.dart';
import 'package:ceuk_user_app/modules/home/menu_cube_button.dart';
import 'package:ceuk_user_app/modules/profile/staff_support_page.dart';
import 'package:ceuk_user_app/modules/request/staff_search_request.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class StaffHomePage extends StatefulWidget {
  const StaffHomePage({Key key}) : super(key: key);

  @override
  _VendorHomeState createState() => _VendorHomeState();
}

class _VendorHomeState extends State<StaffHomePage> {
  StaffDataProvider staffDataProvider;

  @override
  didChangeDependencies() {
    super.didChangeDependencies();
    staffDataProvider = context.read<StaffDataProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UIColors.white,
      body: Container(
        padding: EdgeInsets.all(0.058.sw),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 0.058.sw,
                      height: 0.03.sh,
                      margin: EdgeInsets.only(top: 0.03.sh),
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                        image: AssetImage('assets/brand/logo_icon.png'),
                      )),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(
              height: 0.02.sh,
            ),
            Text(
              "Account Overview",
              style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'CW BR Firma'),
            ),
            SizedBox(
              height: 0.010.sh,
            ),
            Container(
              padding: EdgeInsets.all(0.058.sw),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20.r)),
                color: UIColors.primary600 // Color(0xfff1f3f6)
                ,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${staffDataProvider.user['first_name']} ${staffDataProvider.user['last_name']}",
                        style: TypographyStyle.bodySmall.copyWith(
                            fontSize: 20.sp, fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: 0.005.sh,
                      ),
                      Text(
                        "${staffDataProvider.user['phone_number']}",
                        style: TypographyStyle.bodySmall.copyWith(
                            fontSize: 11.sp, fontWeight: FontWeight.w400),
                      )
                    ],
                  ),
                  // GestureDetector(
                  //   onTap: () async {

                  //   },
                  //   child: Container(
                  //     height: 0.06.sh,
                  //     width: 0.06.sh,
                  //     decoration: BoxDecoration(
                  //         shape: BoxShape.circle, color: UIColors.primary200),
                  //     child: Icon(
                  //       PhosphorIcons.wallet,
                  //       size: 0.030.sh,
                  //       color: UIColors.white,
                  //     ),
                  //   ),
                  // )
                ],
              ),
            ),
            SizedBox(
              height: 0.02.sh,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Quick Actions',
                  style: TypographyStyle.bodyMediumn.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 0.010.sh,
            ),
            Expanded(
              child: GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                crossAxisCount: 4,
                mainAxisSpacing: 10,
                childAspectRatio: 0.7,
                children: const [
                  HomeCubeButton(
                    title: 'Find\nRequest',
                    icon: PhosphorIcons.magnifying_glass,
                    child: FindRequest(),
                  ),
                  // HomeCubeButton(
                  //   title: 'Sales\nHistory',
                  //   icon: PhosphorIcons.chart_bar,
                  //   child: RequestHistory(),
                  // ),
                  HomeCubeButton(
                    title: 'Contact\nSupport',
                    icon: PhosphorIcons.lifebuoy,
                    child: SupportPage(),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
