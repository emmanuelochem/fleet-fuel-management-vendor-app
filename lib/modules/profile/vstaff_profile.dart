import 'package:ceuk_user_app/core/providers/vstaff_data_provider.dart';
import 'package:ceuk_user_app/staffs_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'package:ceuk_user_app/core/design_system/color_shemes.dart';
import 'package:ceuk_user_app/core/design_system/typography_style.dart';
import 'package:ceuk_user_app/core/logics/generalLogics.dart';
import 'package:ceuk_user_app/shared/form/action_button.dart';
import 'package:ceuk_user_app/shared/form/optionsDialog.dart';
import 'package:sliver_tools/sliver_tools.dart';

class VendorStaffAccount extends StatefulWidget {
  const VendorStaffAccount({Key key}) : super(key: key);

  @override
  State<VendorStaffAccount> createState() => _MyAccountPageState();
}

class _MyAccountPageState extends State<VendorStaffAccount> {
  StaffDataProvider staffDataProvider;

  @override
  didChangeDependencies() {
    super.didChangeDependencies();
    staffDataProvider = Provider.of<StaffDataProvider>(context);
  }

  @override
  Widget build(BuildContext context) {
    var userData = staffDataProvider.user;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          //title
          SliverAppBar(
            //automaticallyImplyLeading: false,
            backgroundColor: UIColors.white,
            pinned: false,
            centerTitle: true,
            iconTheme: IconThemeData(
              color: UIColors.secondary100,
              size: 0.03.sh,
            ),
            automaticallyImplyLeading: false,
            //floating: true,
            // leading: const GoBack(
            //   route: '/home',
            // ),
            title: Text("My Profile",
                style: TypographyStyle.heading5.copyWith(
                  fontSize: 20.sp,
                  color: UIColors.secondary100,
                )),
            actions: const [],
          ),

          //profile

          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 0.058.sw),
            sliver: MultiSliver(
              children: [
                //profile bio
                SliverToBoxAdapter(
                  child: Container(
                    margin: EdgeInsets.only(
                      top: 0.057.sh,
                      bottom: 0.016.sh,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundColor: UIColors.white,
                          child: (userData['photo'] == null)
                              ? Image.asset('assets/brand/logo_icon.png')
                              : Image.network(userData['photo'].toString()),
                        ),
                        SizedBox(height: 0.012.sh),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                                userData['first_name'] +
                                        ' ' +
                                        userData['last_name'] ??
                                    '',
                                style: TypographyStyle.bodyLarge.copyWith(
                                  fontSize: 19.sp,
                                  color: UIColors.secondary100,
                                )),
                            Text(userData['email'],
                                style: TypographyStyle.bodySmall.copyWith(
                                  fontSize: 14.sp,
                                  color: UIColors.secondary300,
                                )),
                            Text(userData['phone_number'],
                                style: TypographyStyle.bodySmall.copyWith(
                                  fontSize: 14.sp,
                                  color: UIColors.secondary300,
                                )),
                            Text('Staff',
                                style: TypographyStyle.bodySmall.copyWith(
                                  fontSize: 14.sp,
                                  color: UIColors.secondary300,
                                )),
                          ],
                        ),
                        SizedBox(height: 0.0042.sh),
                      ],
                    ),
                  ),
                ),

                //list tiles
                SliverFillRemaining(
                  child: Container(
                    margin: EdgeInsets.only(
                      top: 0.013.sh,
                      //bottom: 0.043.sh,
                    ),
                    child: Column(
                      children: [
                        // MyAccountOptionTile(
                        //     icon: const Icon(
                        //       Tymsicons.br_user,
                        //       size: 16,
                        //     ),
                        //     svgIconPath: 'assets/icons/profile_user.svg',
                        //     title: 'Edit Profile',
                        //     actionRequired: false,
                        //     onTap: () {
                        //       Navigator.push(
                        //         context,
                        //         MaterialPageRoute(
                        //           builder: (BuildContext context) =>
                        //               const UpdateProfilePage(),
                        //         ),
                        //       ).then((value) {
                        //         setState(() {
                        //           _isReady = false;
                        //         });
                        //       });
                        //     }),
                        SizedBox(height: 0.055.sh),
                        SizedBox(
                          // width: 0.4.sw,
                          child: ActionButton(
                            text: 'Logout',
                            shape: ButtonShape.squircle,
                            size: ButtonSizes.large,
                            backgroundColor: const Color(0xFFFFECEC),
                            textColor: const Color(0xFFC50000),
                            iconColor: const Color(0xFFC50000),
                            //leftIconPath: 'assets/images/icons/red_logout.svg',
                            onPressed: () {
                              OptionsDialog.messageDialog(context, 'Logout',
                                  'Are you sure you want to log out of your account?',
                                  () {
                                Navigator.pop(context);
                                GeneralLogics.removeUserData().then((value) {
                                  Navigator.of(context).pushNamedAndRemoveUntil(
                                      StaffsRoutes.login,
                                      (Route<dynamic> route) => false);
                                });
                              });
                            },
                          ),
                        ),

                        const Spacer(),
                        Text('CeucEnergies © 2023',
                            style: TypographyStyle.bodySmall.copyWith(
                              fontSize: 12.sp,
                              color: UIColors.secondary300,
                            )),
                        SizedBox(height: 0.055.sh),
                      ],
                    ),
                  ),
                )
                //
              ],
            ),
          ),
        ],
      ),
    );
  }
}
