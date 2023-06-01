import 'package:ceuk_user_app/core/design_system/color_shemes.dart';
import 'package:ceuk_user_app/core/design_system/typography_style.dart';
import 'package:ceuk_user_app/core/logics/generalLogics.dart';
import 'package:ceuk_user_app/core/providers/vendor_data_provider.dart';
import 'package:ceuk_user_app/shared/form/action_button.dart';
import 'package:ceuk_user_app/shared/form/optionsDialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class VendorAccountPage extends StatefulWidget {
  const VendorAccountPage({Key key}) : super(key: key);

  @override
  State<VendorAccountPage> createState() => _MyAccountPageState();
}

class _MyAccountPageState extends State<VendorAccountPage> {
  VendorDataProvider vendorDataProvider;

  @override
  didChangeDependencies() {
    super.didChangeDependencies();
    vendorDataProvider = Provider.of<VendorDataProvider>(context);
  }

  @override
  Widget build(BuildContext context) {
    var userData = vendorDataProvider.user;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        title: Text(
          'My Account',
          style: TypographyStyle.heading5.copyWith(),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        //leadingWidth: 0,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 0.058.sw),
        child: Column(children: [
          //profile bio
          Container(
            width: 1.sw,
            margin: EdgeInsets.only(
              top: 0.027.sh,
              bottom: 0.016.sh,
            ),
            padding: EdgeInsets.only(
              top: 0.027.sh,
              bottom: 0.016.sh,
            ),
            decoration: BoxDecoration(
                color: UIColors.secondary500,
                borderRadius: BorderRadius.circular(10.r)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text((userData['company_name']) ?? '',
                    textAlign: TextAlign.center,
                    style: TypographyStyle.bodyLarge.copyWith(
                      fontSize: 25.sp,
                      color: UIColors.secondary,
                    )),
                Text(
                  userData['manager_name'],
                  style: TypographyStyle.bodySmall.copyWith(
                    fontSize: 14.sp,
                    color: UIColors.secondary200,
                  ),
                ),
                Text(
                  userData['manager_phone'],
                  style: TypographyStyle.bodySmall.copyWith(
                    fontSize: 14.sp,
                    color: UIColors.secondary200,
                  ),
                ),
                Text(
                  userData['address'],
                  style: TypographyStyle.bodySmall.copyWith(
                    fontSize: 14.sp,
                    color: UIColors.secondary200,
                  ),
                ),
              ],
            ),
          ),

          //list tiles
          Container(
              margin: EdgeInsets.only(
                top: 0.043.sh,
                //bottom: 0.043.sh,
              ),
              child: Column(children: [
                // MyAccountOptionTile(
                //     icon: const Icon(
                //       PhosphorIcons.user,
                //       size: 16,
                //     ),
                //     title: 'Update Profile',
                //     actionRequired: false,
                //     onTap: () {}),

                SizedBox(
                  height: 0.2.sh,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 0.4.sw,
                      child: ActionButton(
                        text: 'Logout',
                        shape: ButtonShape.squircle,
                        size: ButtonSizes.xxxm,
                        backgroundColor: const Color(0xFFFFECEC),
                        textColor: const Color(0xFFC50000),
                        iconColor: const Color(0xFFC50000),
                        //leftIconPath: 'assets/images/icons/red_logout.svg',
                        onPressed: () {
                          OptionsDialog.messageDialog(context, 'Logout',
                              'Are you sure you want to log out of your account?',
                              () {
                            Navigator.pop(context);
                            GeneralLogics.logoutFunction(
                                context: context, isStudent: false);
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ])
              //
              )
        ]),
      ),
    );
  }
}
