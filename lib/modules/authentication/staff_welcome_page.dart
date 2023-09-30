import 'package:ceuk_user_app/core/design_system/color_shemes.dart';
import 'package:ceuk_user_app/shared/form/action_button.dart';
import 'package:ceuk_user_app/staffs_routes.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class StaffNewWelcomePage extends StatefulWidget {
  const StaffNewWelcomePage({Key key}) : super(key: key);

  @override
  _NewWelcomePageState createState() => _NewWelcomePageState();
}

class _NewWelcomePageState extends State<StaffNewWelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        children: [
          Container(
            width: 1.sw,
            padding:
                EdgeInsets.symmetric(vertical: 0.02.sh, horizontal: 0.058.sw),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/brand/logo-h.svg',
                        color: UIColors.primary,
                        width: 200,
                      ),
                      SizedBox(
                        height: 0.01.sh,
                      ),
                      SizedBox(
                        width: 1.sw,
                        child: RichText(
                          textAlign: TextAlign.left,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Fuel up Smarter, Save Cost.',
                                style: TextStyle(
                                    fontSize: 13.sp,
                                    color: const Color(0xff082552),
                                    fontWeight: FontWeight.w700),
                              ),
                              //  TextSpan(
                              //     text: 'Simplified pertroleum services',
                              //     style: TextStyle(
                              //         fontSize: 17.sp,
                              //         color: const Color(0xff082552),
                              //         fontWeight: FontWeight.w700),
                              //   ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 0.2.sh,
                  child: Column(
                    children: <Widget>[
                      ActionButton(
                          text: 'Sign In',
                          backgroundColor: UIColors.primary,
                          textColor: UIColors.white,
                          shape: ButtonShape.squircle,
                          size: ButtonSizes.large,
                          onPressed: () async {
                            Navigator.pushNamed(
                              context,
                              StaffsRoutes.login,
                            );
                          }),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
