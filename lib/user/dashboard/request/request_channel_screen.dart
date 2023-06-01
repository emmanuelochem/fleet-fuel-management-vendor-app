import 'dart:ui';

import 'package:ceuk_user_app/core/design_system/color_shemes.dart';
import 'package:ceuk_user_app/core/design_system/typography_style.dart';
import 'package:ceuk_user_app/shared/form/form_header.dart';
import 'package:ceuk_user_app/user/dashboard/request/messenger_request_page.dart';
import 'package:ceuk_user_app/user/dashboard/request/vehicle_request_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class RequestChannelsScreen extends StatefulWidget {
  const RequestChannelsScreen({Key key}) : super(key: key);

  @override
  State<RequestChannelsScreen> createState() => _RequestChannelsScreenState();
}

class _RequestChannelsScreenState extends State<RequestChannelsScreen> {
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
                height: 0.45.sh,
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
                height: 0.45.sh,
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
                            title: 'Select request type',
                            titleFontSize: 25.sp,
                            hasCustomTitleSize: true,
                            description:
                                'Tap any of the options below to make your request.',
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomRadio(
                                title: 'Vehicle',
                                icon: PhosphorIcons.car,
                                onPress: () async {
                                  Navigator.pop(context);
                                  await showMaterialModalBottomSheet(
                                    context: context,
                                    expand: false,
                                    isDismissible: false,
                                    enableDrag: false,
                                    //elevation: 10,
                                    backgroundColor: Colors.transparent,
                                    builder: (context) =>
                                        const VehicleRequestPage(),
                                  );
                                },
                              ),
                              CustomRadio(
                                title: 'Messenger',
                                icon: PhosphorIcons.user,
                                onPress: () async {
                                  Navigator.pop(context);
                                  await showMaterialModalBottomSheet(
                                    context: context,
                                    expand: false,
                                    isDismissible: false,
                                    enableDrag: false,
                                    //elevation: 10,
                                    backgroundColor: Colors.transparent,
                                    builder: (context) =>
                                        const MessengerRequestPage(),
                                  );
                                },
                              ),
                            ],
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

class CustomRadio extends StatelessWidget {
  const CustomRadio({Key key, this.icon, this.title, this.onPress})
      : super(key: key);

  final IconData icon;
  final String title;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        width: 0.35.sw,
        height: 0.17.sh,
        margin: EdgeInsets.symmetric(horizontal: 0.03.sw),
        decoration: BoxDecoration(
            color: UIColors.primary600.withOpacity(.4),
            borderRadius: BorderRadius.circular(10.r)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(
              icon,
              color: UIColors.secondary200,
              size: 0.04.sh,
            ),
            SizedBox(height: 0.010.sh),
            Text(
              title,
              style: TypographyStyle.bodySmall.copyWith(
                color: UIColors.secondary200,
              ),
            )
          ],
        ),
      ),
    );
  }
}
