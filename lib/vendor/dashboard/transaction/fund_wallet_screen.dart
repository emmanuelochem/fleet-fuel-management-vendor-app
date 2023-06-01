import 'dart:ui';

import 'package:ceuk_user_app/core/design_system/color_shemes.dart';
import 'package:ceuk_user_app/core/design_system/typography_style.dart';
import 'package:ceuk_user_app/shared/form/form_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FundWalletScreen extends StatefulWidget {
  const FundWalletScreen({Key key}) : super(key: key);

  @override
  State<FundWalletScreen> createState() => _RequestChannelsScreenState();
}

class _RequestChannelsScreenState extends State<FundWalletScreen> {
  @override
  Widget build(BuildContext context) {
    return ClipRect(
      clipBehavior: Clip.hardEdge,
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 5,
          sigmaY: 5,
        ),
        child: SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 0.25.sh,
              ),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 23, vertical: 0.015.sh),
                  child: Text('Close',
                      textAlign: TextAlign.end,
                      style: TypographyStyle.bodyMediumn
                          .copyWith(color: UIColors.white)),
                ),
              ),
              Container(
                height: 0.65.sh,
                decoration: BoxDecoration(
                  color: UIColors.white,
                  borderRadius: BorderRadiusDirectional.only(
                    topStart: Radius.circular(30.r),
                    topEnd: Radius.circular(30.r),
                  ),
                ),
                child: Column(
                  children: [
                    SingleChildScrollView(
                      padding: EdgeInsets.symmetric(
                          horizontal: 0.058.sw, vertical: 0.040.sh),
                      child: Column(
                        children: [
                          FormHeader(
                            title: 'Fund Wallet',
                            hasCustomTitleSize: true,
                            titleFontSize: 23.sp,
                            description:
                                'Transfer money to the your ceuc virtual account to fund your wallet.',
                          ),
                          Container(
                            height: 0.23.sh,
                            width: 1.sw,
                            padding: EdgeInsets.symmetric(
                              horizontal: 0.042.sw,
                              vertical: 0.017.sh,
                            ),
                            decoration: BoxDecoration(
                              color: UIColors.secondary600,
                              borderRadius: BorderRadius.circular(
                                10.r,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Ochem Ogorchukwu Emmanuel',
                                  style: TypographyStyle.heading3.copyWith(
                                    fontSize: 19.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(
                                  height: 0.015.sh,
                                ),
                                Text(
                                  '2213456789',
                                  style: TypographyStyle.heading3.copyWith(
                                    fontSize: 25.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(
                                  height: 0.015.sh,
                                ),
                                Text(
                                  'Providus Bank (CEUC)',
                                  style: TypographyStyle.heading3.copyWith(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            'Tap to copy account information',
                            style: TypographyStyle.heading3.copyWith(
                              fontSize: 12.sp,
                              decoration: TextDecoration.underline,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
