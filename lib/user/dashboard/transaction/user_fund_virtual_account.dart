import 'dart:ui';

import 'package:ceuk_user_app/core/design_system/color_shemes.dart';
import 'package:ceuk_user_app/core/design_system/typography_style.dart';
import 'package:ceuk_user_app/core/logics/generalLogics.dart';
import 'package:ceuk_user_app/core/providers/user_data_provider.dart';
import 'package:ceuk_user_app/shared/form/form_header.dart';
import 'package:ceuk_user_app/shared/form/snack_bar.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class UserFundVirtualAccount extends StatefulWidget {
  const UserFundVirtualAccount({Key key}) : super(key: key);

  @override
  State<UserFundVirtualAccount> createState() => _RequestChannelsScreenState();
}

class _RequestChannelsScreenState extends State<UserFundVirtualAccount> {
  UserDataProvider userDataProvider;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    userDataProvider = Provider.of<UserDataProvider>(context);
  }

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
                          GestureDetector(
                            onTap: () {
                              FlutterClipboard.copy(userDataProvider
                                      .user['virtual_account']['account_name'])
                                  .then((value) => GeneralLogics.showMessageNew(
                                      'Account number copied.',
                                      FlushbarType.success,
                                      context));
                            },
                            child: Container(
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
                                    userDataProvider.user['virtual_account']
                                        ['account_name'],
                                    style: TypographyStyle.heading3.copyWith(
                                      fontSize: 19.sp,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 0.015.sh,
                                  ),
                                  Text(
                                    userDataProvider.user['virtual_account']
                                        ['account_number'],
                                    style: TypographyStyle.heading3.copyWith(
                                      fontSize: 25.sp,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 0.015.sh,
                                  ),
                                  Text(
                                    'Providus Bank',
                                    style: TypographyStyle.heading3.copyWith(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Text(
                            'Tap to copy account number',
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
