import 'package:ceuk_user_app/core/design_system/color_shemes.dart';
import 'package:ceuk_user_app/core/design_system/typography_style.dart';
import 'package:ceuk_user_app/core/providers/vendor_data_provider.dart';
import 'package:ceuk_user_app/vendor/dashboard/transaction/withdrawal_screen.dart';
import 'package:ceuk_user_app/vendor_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

class VendorHomePage extends StatefulWidget {
  const VendorHomePage({Key key}) : super(key: key);

  @override
  _VendorHomeState createState() => _VendorHomeState();
}

class _VendorHomeState extends State<VendorHomePage> {
  VendorDataProvider vendorDataProvider;
  @override
  void didChangeDependencies() {
    vendorDataProvider = Provider.of<VendorDataProvider>(context);
    super.didChangeDependencies();
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
                        "NGN ${vendorDataProvider.user['wallet']['available_balance']}",
                        style: TextStyle(
                            fontSize: 22.sp, fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: 0.005.sh,
                      ),
                      Text(
                        "Current Balance",
                        style: TextStyle(
                            fontSize: 16.sp, fontWeight: FontWeight.w400),
                      )
                    ],
                  ),
                  GestureDetector(
                    onTap: () async {
                      await showMaterialModalBottomSheet(
                        context: context,
                        expand: false,
                        isDismissible: true,
                        enableDrag: false,
                        backgroundColor: Colors.transparent,
                        builder: (context) => const WithdrawalScreen(),
                      ).then((value) {
                        //futureData = getBanks();
                        // setState(() {});
                      });
                    },
                    child: Container(
                      height: 0.06.sh,
                      width: 0.06.sh,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: UIColors.primary200),
                      child: Icon(
                        PhosphorIcons.wallet,
                        size: 0.030.sh,
                        color: UIColors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 0.02.sh,
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Text(
            //       "Make Request",
            //       style: TextStyle(
            //           fontSize: 16.sp,
            //           fontWeight: FontWeight.w800,
            //           fontFamily: 'CW BR Firma'),
            //     ),
            //   ],
            // ),
            // SizedBox(
            //   height: 0.010.sh,
            // ),
            // SingleChildScrollView(
            //   scrollDirection: Axis.horizontal,
            //   child: Row(
            //     children: [
            //       GestureDetector(
            //         onTap: () {
            //           Navigator.push(
            //               context,
            //               MaterialPageRoute(
            //                   builder: (context) => const RequestPage()));
            //         },
            //         child: Container(
            //           height: 0.065.sh,
            //           width: 0.065.sh,
            //           margin: EdgeInsets.only(right: 0.0448.sw),
            //           decoration: BoxDecoration(
            //             shape: BoxShape.circle,
            //             color: UIColors.primary200,
            //           ),
            //           child: Icon(
            //             Icons.add,
            //             size: 40,
            //             color: UIColors.white,
            //           ),
            //         ),
            //       ),
            //       avatarWidget("avatar1", "Mike"),
            //       avatarWidget("avatar2", "Joseph"),
            //       avatarWidget("avatar3", "Ashley"),
            //     ],
            //   ),
            // ),
            // const SizedBox(
            //   height: 20,
            // ),
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
                children: [
                  serviceWidget(PhosphorIcons.plus, "Add\nBank"),
                  serviceWidget(PhosphorIcons.bank, "Manage\nBanks"),
                  serviceWidget(PhosphorIcons.user_plus, "Add\nStaff"),
                  // serviceWidget(
                  //     PhosphorIcons.chart_line_up, "Analytics\nGraph"),
                  // serviceWidget(Iconsax.import_1, "Cashout\nHistory"),
                  // serviceWidget(Iconsax.export_1, "Make\nRequest"),
                  // serviceWidget(Iconsax.send_sqaure_2, "Wallet\nHistory"),
                  // serviceWidget(Iconsax.user_add, "Manage\nStaffs"),
                  // serviceWidget(Iconsax.user_add, "Manage\nSubsidiaries"),
                  //serviceWidget(Iconsax.more, "More\n"),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Column serviceWidget(IconData icon, String name) {
    return Column(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () async {
              if (name == 'Add\nBank') {
                Navigator.pushNamed(
                  context,
                  VendorRoutes.addbank,
                );
              }
              if (name == 'Manage\nBanks') {
                Navigator.pushNamed(
                  context,
                  VendorRoutes.banks,
                );
              }
              if (name == 'Add\nStaff') {
                Navigator.pushNamed(
                  context,
                  VendorRoutes.addstaff,
                );
              }
              if (name == 'Analytics\nGraph') {
                Navigator.pushNamed(
                  context,
                  VendorRoutes.stats,
                );
              }
            },
            child: Container(
              margin: EdgeInsets.all(0.010.sw),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20.r)),
                color: UIColors.primary600.withOpacity(.4),
              ),
              child: Center(
                child: Container(
                  margin: EdgeInsets.all(0.058.sw),
                  child: Icon(icon),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 0.005.sh,
        ),
        Text(
          name,
          style: TypographyStyle.bodyMediumn.copyWith(
            fontSize: 14.sp,
          ),
          textAlign: TextAlign.center,
        )
      ],
    );
  }

  Container avatarWidget(String img, String name) {
    return Container(
      margin: EdgeInsets.only(right: 0.034.sw),
      height: 0.150.sh,
      width: 0.250.sw,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(
              15.r,
            ),
          ),
          color: UIColors.primary600.withOpacity(.4)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            height: 0.06.sh,
            width: 0.06.sh,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                image: DecorationImage(
                  image: AssetImage('assets/images/$img.png'),
                  fit: BoxFit.contain,
                ),
                border: Border.all(
                  color: UIColors.secondary600,
                  width: 0.0001.sh,
                )),
          ),
          Text(
            name,
            style: TextStyle(
              fontSize: 14.sp,
              fontFamily: 'CW BR Firma',
              fontWeight: FontWeight.w700,
            ),
          )
        ],
      ),
    );
  }
}
