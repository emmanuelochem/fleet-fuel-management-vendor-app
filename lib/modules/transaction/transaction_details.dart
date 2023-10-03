import 'dart:ui';

import 'package:ceuk_user_app/core/constants/app_constant.dart';
import 'package:ceuk_user_app/core/design_system/color_shemes.dart';
import 'package:ceuk_user_app/core/design_system/typography_style.dart';
import 'package:ceuk_user_app/shared/form/form_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recase/recase.dart';

class UserTransactionDetailsScreen extends StatelessWidget {
  const UserTransactionDetailsScreen({Key key, this.history}) : super(key: key);

  final Map history;

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
                height: 0.15.sh,
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
                height: 0.75.sh,
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
                          const FormHeader(
                            title: 'Transaction details',

                            // description:
                            //     'Tap any of the options below to make your request.',
                          ),
                          Container(
                            width: 1.sw,
                            decoration: BoxDecoration(
                              color: UIColors.secondary600,
                              borderRadius: BorderRadius.circular(
                                10.r,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                requestSummary(
                                  title: 'Request',
                                  description: ReCase(
                                          history['type'] == 'credit'
                                              ? 'Wallet funding'
                                              : 'Service request')
                                      .sentenceCase,
                                  showBorder: true,
                                ),
                                requestSummary(
                                  title: 'Amount',
                                  description: 'NGN ${history['amount']}',
                                  showBorder: true,
                                ),
                                requestSummary(
                                  title: 'Status',
                                  description:
                                      ReCase(history['status']).sentenceCase,
                                  showBorder: true,
                                ),
                                requestSummary(
                                  title: 'Channel',
                                  description:
                                      ReCase(history['channel']).sentenceCase,
                                  showBorder: true,
                                ),
                                requestSummary(
                                  title: 'Reference',
                                  description: history['reference'],
                                  showBorder: true,
                                ),
                                requestSummary(
                                  title: 'Description',
                                  description:
                                      '${history['description'] ?? '---'}',
                                  showBorder: true,
                                ),
                                requestSummary(
                                  title: 'Date',
                                  description:
                                      '${AppConstant.formatDate.format(DateTime.parse(history['created_at']))} -  ${AppConstant.formatTime.format(DateTime.parse(history['created_at']))}',
                                  showBorder: false,
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
            ],
          ),
        ),
      ),
    );
  }

  Container requestSummary(
      {String title = 'Title',
      String description = 'Description',
      bool showBorder = true}) {
    return Container(
      width: 1.sw,
      padding: EdgeInsets.symmetric(
        horizontal: 0.042.sw,
        vertical: 0.017.sh,
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: (showBorder) ? 1 : 0,
            color: UIColors.secondary500,
          ),
        ),
      ),
      child: RichText(
        textAlign: TextAlign.start,
        text: TextSpan(
          children: [
            TextSpan(
              text: '$title: ',
              style: TypographyStyle.bodySmall
                  .copyWith(color: UIColors.secondary200),
            ),
            TextSpan(
              text: description,
              style: TypographyStyle.bodySmall
                  .copyWith(color: UIColors.secondary200),
            ),
          ],
        ),
      ),
    );
  }
}
