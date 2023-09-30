import 'dart:io';
import 'dart:ui';

import 'package:ceuk_user_app/core/design_system/color_shemes.dart';
import 'package:ceuk_user_app/core/design_system/typography_style.dart';
import 'package:ceuk_user_app/core/logics/generalLogics.dart';
import 'package:ceuk_user_app/modules/request/staff_request_api.dart';
import 'package:ceuk_user_app/modules/request/staff_request_success_page.dart';
import 'package:ceuk_user_app/shared/form/action_button.dart';
import 'package:ceuk_user_app/shared/form/form_header.dart';
import 'package:ceuk_user_app/shared/form/snack_bar.dart';
import 'package:ceuk_user_app/staffs_routes.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:path/path.dart' as path;

class StaffPumpSalesSnapshot extends StatefulWidget {
  const StaffPumpSalesSnapshot({Key key, this.requestId}) : super(key: key);
  final String requestId;
  @override
  State<StaffPumpSalesSnapshot> createState() => _RequestChannelsScreenState();
}

class _RequestChannelsScreenState extends State<StaffPumpSalesSnapshot> {
  bool _isLoading = false;

  File pumpImage;
  bool _isFlagged = false;
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
                height: 0.20.sh,
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
                height: 0.70.sh,
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FormHeader(
                            title: 'Sales Confirmation',
                            hasCustomTitleSize: true,
                            titleFontSize: 23.sp,
                            description: 'Take a picture of your pump meter.',
                          ),

                          Text(
                            'Instructions',
                            style: TypographyStyle.heading3.copyWith(
                              fontSize: 15.sp,
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 0.01.sh),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '1. Ensure you zoom in to capture the meter.',
                                  style: TypographyStyle.bodySmall.copyWith(
                                    color: UIColors.secondary,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14.sp,
                                  ),
                                ),
                                Text(
                                  '2. Ensure the picture is not blur.',
                                  style: TypographyStyle.bodySmall.copyWith(
                                    color: UIColors.secondary,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14.sp,
                                  ),
                                ),
                                Text(
                                  '3. Ensure the meter reading matches the requested amount.',
                                  style: TypographyStyle.bodySmall.copyWith(
                                    color: UIColors.secondary,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: 0.05.sh),
                          GestureDetector(
                            onTap: () async {
                              var photo =
                                  await GeneralLogics.getGalleryPicture();
                              setState(() {
                                pumpImage = photo;
                              });
                            },
                            child: Stack(
                              children: [
                                Container(
                                  width: 1.sw,
                                  height: 0.2.sh,
                                  padding: const EdgeInsets.all(50),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.r),
                                    color: UIColors.secondary600,
                                    border: Border.all(
                                      color: (_isFlagged && pumpImage == null)
                                          ? UIColors.primary
                                          : UIColors.secondary600,
                                    ),
                                    image: pumpImage != null
                                        ? DecorationImage(
                                            fit: BoxFit.cover,
                                            image: FileImage(pumpImage),
                                          )
                                        : null,
                                  ),
                                  child: pumpImage != null
                                      ? const SizedBox()
                                      : Icon(
                                          PhosphorIcons.camera,
                                          size: 48,
                                          color:
                                              (_isFlagged && pumpImage == null)
                                                  ? UIColors.primary
                                                  : pumpImage == null
                                                      ? UIColors.secondary400
                                                      : Colors.transparent,
                                        ),
                                ),
                                pumpImage == null
                                    ? const SizedBox()
                                    : Positioned(
                                        right: 10,
                                        top: 10,
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              pumpImage = null;
                                              _isFlagged = false;
                                            });
                                          },
                                          child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 0.005.sh,
                                                  horizontal: 0.02.sh),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(25.r),
                                                color: UIColors.secondary
                                                    .withOpacity(.7),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  'Reset',
                                                  style: TypographyStyle
                                                      .heading4
                                                      .copyWith(
                                                    fontSize: 15.sp,
                                                    color: UIColors.white,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              )),
                                        ),
                                      ),
                              ],
                            ),
                          ),
                          SizedBox(height: 0.02.sh),

                          SizedBox(height: 0.04.sh),
                          // const Spacer(),
                          ActionButton(
                            text: 'Submit',
                            backgroundColor: UIColors.primary,
                            textColor: UIColors.white,
                            shape: ButtonShape.squircle,
                            size: ButtonSizes.large,
                            isLoading: _isLoading,
                            onPressed: _isLoading
                                ? null
                                : () async {
                                    FocusScopeNode currentFocus =
                                        FocusScope.of(context);
                                    if (!currentFocus.hasPrimaryFocus) {
                                      currentFocus.unfocus();
                                    }

                                    if (pumpImage != null) {
                                      StaffsRequestApi staffsRequestApi =
                                          StaffsRequestApi();
                                      Map<String, dynamic> data = {
                                        "metre_picture":
                                            await MultipartFile.fromFile(
                                          pumpImage.path,
                                          filename:
                                              path.basename(pumpImage.path),
                                        ),
                                      };
                                      setState(() {
                                        _isLoading = true;
                                        _isFlagged = false;
                                      });
                                      if (context.mounted) {
                                        await staffsRequestApi
                                            .confirmRequest(
                                                requestId: widget.requestId,
                                                data: data,
                                                context: context)
                                            .then((value) async {
                                          if (value != null) {
                                            //log(value['data'].toString());
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      StaffRequestSuccessPage(
                                                    data: value,
                                                    onContinue: () {
                                                      Navigator.of(context)
                                                          .pushNamedAndRemoveUntil(
                                                              StaffsRoutes.home,
                                                              (Route<dynamic>
                                                                      route) =>
                                                                  false);
                                                    },
                                                  ),
                                                ));
                                          }
                                          setState(() {
                                            _isLoading = false;
                                          });
                                        });
                                      }
                                    } else {
                                      setState(() {
                                        _isFlagged = true;
                                      });
                                      GeneralLogics.showMessageNew(
                                          'Meter capture is required.',
                                          FlushbarType.error,
                                          context);
                                    }
                                  },
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
