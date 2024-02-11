import 'dart:io';
import 'dart:ui';

import 'package:ceuk_user_app/core/design_system/color_shemes.dart';
import 'package:ceuk_user_app/core/design_system/typography_style.dart';
import 'package:ceuk_user_app/core/logics/generalLogics.dart';
import 'package:ceuk_user_app/core/network/api.dart';
import 'package:ceuk_user_app/modules/request/staff_request_success_page.dart';
import 'package:ceuk_user_app/shared/form/action_button.dart';
import 'package:ceuk_user_app/shared/form/snack_bar.dart';
import 'package:ceuk_user_app/staffs_routes.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:path/path.dart' as path;

class RequestProcessingScreen extends StatefulWidget {
  const RequestProcessingScreen({Key key, this.data}) : super(key: key);

  final Map data;

  @override
  State<RequestProcessingScreen> createState() =>
      _RequestProcessingScreenState();
}

class _RequestProcessingScreenState extends State<RequestProcessingScreen> {
  String meterReading = '0';
  TextEditingController remarkController = TextEditingController();

  bool _isLoading = false;

  File pumpImage;
  bool _isFlagged = false;
  final _formKey = GlobalKey<FormState>();
  bool showSnapshot = true;
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
              // GestureDetector(
              //   onTap: () => Navigator.pop(context),
              //   child: Padding(
              //     padding:
              //         EdgeInsets.symmetric(horizontal: 23, vertical: 0.015.sh),
              //     child: Text('Close',
              //         textAlign: TextAlign.end,
              //         style: TypographyStyle.bodyMediumn
              //             .copyWith(color: UIColors.white)),
              //   ),
              // ),
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
                          horizontal: 0.058.sw, vertical: 0.020.sh),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  height: 0.04.sh,
                                  width: 0.04.sh,
                                  decoration: BoxDecoration(
                                      color: UIColors.secondary500,
                                      shape: BoxShape.circle),
                                  child: Icon(
                                    PhosphorIcons.caret_left,
                                    size: 0.027.sh,
                                    color: UIColors.secondary,
                                  ),
                                ),
                              ),
                              Text(
                                'Paid To',
                                textAlign: TextAlign.center,
                                style: TypographyStyle.heading4.copyWith(
                                    fontSize: 17.sp,
                                    fontWeight: FontWeight.w600),
                              ),
                              const SizedBox()
                            ],
                          ),
                          SizedBox(
                            width: 1.sw,
                            child: SingleChildScrollView(
                              padding: EdgeInsets.only(top: 0.02.sh),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    //height: 0.080.sh,
                                    margin: EdgeInsets.only(bottom: 0.01.sh),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 0.032.sw,
                                      vertical: 0.012.sh,
                                    ),
                                    decoration: BoxDecoration(
                                        color: UIColors.primary600,
                                        borderRadius:
                                            BorderRadius.circular(15.r)),
                                    child: Row(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 0.008.sh,
                                            vertical: 0.008.sh,
                                          ),
                                          decoration: BoxDecoration(
                                            color: UIColors.primary500,
                                            shape: BoxShape.circle,
                                          ),
                                          child: Icon(
                                            PhosphorIcons.user,
                                            color: UIColors.primary200,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 0.033.sw,
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                widget.data['bank']
                                                    ['account_name'],
                                                style: TypographyStyle
                                                    .bodyMediumn
                                                    .copyWith(
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w600,
                                                  color: UIColors.primary200,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 0.0015.sh,
                                              ),
                                              Text(
                                                widget.data['bank']
                                                    ['account_number'],
                                                style: TypographyStyle.bodySmall
                                                    .copyWith(
                                                  fontSize: 11.sp,
                                                  fontWeight: FontWeight.w400,
                                                  color: UIColors.primary300,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 0.01.sh),
                                  Container(
                                    width: 1.sw,
                                    padding: EdgeInsets.symmetric(
                                        vertical: 0.01.sh, horizontal: 0.02.sw),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.r),
                                      color: pumpImage != null
                                          ? UIColors.primary600
                                          : UIColors.secondary600,
                                      border: Border.all(
                                        color: (_isFlagged && pumpImage == null)
                                            ? UIColors.primary
                                            : UIColors.secondary600,
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        Row(children: [
                                          Expanded(
                                            child: Row(
                                              children: [
                                                Text(
                                                  'Pump Snapshot',
                                                  style: TypographyStyle
                                                      .heading4
                                                      .copyWith(
                                                    fontSize: 14.sp,
                                                    color:
                                                        UIColors.secondary200,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                pumpImage == null
                                                    ? SizedBox()
                                                    : Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 0.01.sw),
                                                        child: Icon(
                                                          PhosphorIcons
                                                              .check_circle_fill,
                                                          size: 0.020.sh,
                                                          color: Colors.green,
                                                        ),
                                                      ),
                                              ],
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () async {
                                              setState(() {
                                                showSnapshot = !showSnapshot;
                                              });
                                            },
                                            child: Icon(
                                              showSnapshot
                                                  ? PhosphorIcons.caret_up_bold
                                                  : PhosphorIcons
                                                      .caret_down_bold,
                                              size: 0.02.sh,
                                              color: UIColors.secondary,
                                            ),
                                          ),
                                        ]),
                                        showSnapshot
                                            ? GestureDetector(
                                                onTap: () async {
                                                  var photo =
                                                      await GeneralLogics
                                                          .galleryPicture();
                                                  final textRecognizer =
                                                      GoogleMlKit.vision
                                                          .textRecognizer();
                                                  final inputImage =
                                                      InputImage.fromFile(
                                                          photo);
                                                  final visionText =
                                                      await textRecognizer
                                                          .processImage(
                                                              inputImage);
                                                  final block =
                                                      visionText.blocks[0];
                                                  final line = block.lines[0];
                                                  final element =
                                                      line.elements[0];
                                                  meterReading =
                                                      (element.text ?? '0');
                                                  setState(() {
                                                    pumpImage = photo;
                                                  });
                                                },
                                                child: Container(
                                                  width: 1.sw,
                                                  height: 0.15.sh,
                                                  margin: EdgeInsets.only(
                                                      top: 0.01.sh),
                                                  decoration: BoxDecoration(
                                                      // border: Border(
                                                      //   top: BorderSide(
                                                      //       width: 1,
                                                      //       color: UIColors
                                                      //           .secondary400),
                                                      // ),
                                                      ),
                                                  child: Stack(
                                                    children: [
                                                      Container(
                                                        height: 0.15.sh,
                                                        width: 1.sw,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.r),
                                                          image: pumpImage !=
                                                                  null
                                                              ? DecorationImage(
                                                                  fit: BoxFit
                                                                      .cover,
                                                                  image: FileImage(
                                                                      pumpImage),
                                                                )
                                                              : null,
                                                        ),
                                                        child: pumpImage != null
                                                            ? const SizedBox()
                                                            : Icon(
                                                                PhosphorIcons
                                                                    .camera,
                                                                size: 48,
                                                                color: (_isFlagged &&
                                                                        pumpImage ==
                                                                            null)
                                                                    ? UIColors
                                                                        .primary
                                                                    : pumpImage ==
                                                                            null
                                                                        ? UIColors
                                                                            .secondary400
                                                                        : Colors
                                                                            .transparent,
                                                              ),
                                                      ),
                                                      pumpImage == null
                                                          ? const SizedBox()
                                                          : Positioned(
                                                              right: 10,
                                                              top: 10,
                                                              child:
                                                                  GestureDetector(
                                                                onTap: () {
                                                                  setState(() {
                                                                    meterReading =
                                                                        '0';
                                                                    pumpImage =
                                                                        null;
                                                                    _isFlagged =
                                                                        false;
                                                                  });
                                                                },
                                                                child:
                                                                    Container(
                                                                        padding: EdgeInsets.symmetric(
                                                                            vertical: 0.002
                                                                                .sh,
                                                                            horizontal: 0.01
                                                                                .sh),
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          borderRadius:
                                                                              BorderRadius.circular(25.r),
                                                                          color: UIColors
                                                                              .secondary
                                                                              .withOpacity(.7),
                                                                        ),
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Text(
                                                                            'Reset',
                                                                            style:
                                                                                TypographyStyle.heading4.copyWith(
                                                                              fontSize: 12.sp,
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
                                              )
                                            : const SizedBox(),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 0.01.sh),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        'Meter Reading : ',
                                        style:
                                            TypographyStyle.bodySmall.copyWith(
                                          color: UIColors.secondary300,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15.sp,
                                        ),
                                      ),
                                      Text(
                                        meterReading,
                                        style:
                                            TypographyStyle.bodySmall.copyWith(
                                          color: UIColors.secondary200,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 0.04.sh),
                                  ActionButton(
                                    text: 'Complete',
                                    backgroundColor: UIColors.primary,
                                    textColor: UIColors.white,
                                    shape: ButtonShape.capsule,
                                    size: ButtonSizes.medium,
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
                                              Map<String, dynamic> data = {
                                                "step": "2",
                                                "others": {
                                                  "metre_amount": meterReading,
                                                  "metre_litre": 'meterReading',
                                                  "metre_rate": ''
                                                },
                                                "metre_picture":
                                                    await MultipartFile
                                                        .fromFile(
                                                  pumpImage.path,
                                                  filename: path
                                                      .basename(pumpImage.path),
                                                ),
                                              };
                                              setState(() {
                                                _isLoading = true;
                                                _isFlagged = false;
                                              });
                                              Apis apis = Apis();
                                              var resp = await apis.request
                                                  .completeRequest(
                                                      data: data,
                                                      id: widget.data['request']
                                                          ['id'],
                                                      context: context);
                                              if (resp != null) {
                                                //log(value['data'].toString());
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          StaffRequestSuccessPage(
                                                        data: resp,
                                                        onContinue: () {
                                                          Navigator.of(context)
                                                              .pushNamedAndRemoveUntil(
                                                                  StaffsRoutes
                                                                      .home,
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
                                            } else {
                                              setState(() {
                                                _isLoading = false;
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

  Padding confirmationSummary(
      {String key, String value, bool noMargin = false}) {
    return Padding(
      padding: EdgeInsets.only(bottom: noMargin ? 0 : 0.015.sh),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            key,
            style: TypographyStyle.bodySmall.copyWith(
              color: UIColors.secondary200,
              fontWeight: FontWeight.w500,
              fontSize: 14.sp,
            ),
          ),
          Text(
            value,
            style: TypographyStyle.bodySmall.copyWith(
              color: UIColors.secondary,
              fontWeight: FontWeight.w600,
              fontSize: 15.sp,
            ),
          ),
        ],
      ),
    );
  }
}
