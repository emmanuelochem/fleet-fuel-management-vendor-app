import 'package:ceuk_user_app/core/design_system/color_shemes.dart';
import 'package:ceuk_user_app/core/design_system/typography_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recase/recase.dart';

class StaffRequestSuccessPage extends StatelessWidget {
  const StaffRequestSuccessPage({Key key, this.data, this.onContinue})
      : super(key: key);

  final Map data;
  final Function onContinue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: UIColors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          actions: [
            GestureDetector(
              onTap: onContinue,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 0.08.sw, vertical: 0.003.sh),
                child: Text(
                  'Close',
                  style: TypographyStyle.heading4.copyWith(
                    fontSize: 16.sp,
                    color: UIColors.primary,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
          leadingWidth: 100,
          automaticallyImplyLeading: false,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          padding:
              EdgeInsets.symmetric(horizontal: 0.058.sw, vertical: 0.040.sh),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 0.006.sh),
                  child: Icon(
                    PhosphorIcons.check_circle_fill,
                    size: 0.17.sh,
                    color: UIColors.primary,
                  ),
                ),
                Text(
                  data['message'],
                  style: TypographyStyle.heading4.copyWith(
                    fontSize: 18.sp,
                    color: UIColors.secondary,
                  ),
                ),
                SizedBox(
                  height: 0.020.sh,
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
                        title: 'Request type',
                        description: data['data']['type'] == 'errander'
                            ? ReCase('messenger').sentenceCase
                            : ReCase(data['data']['type']).sentenceCase,
                        showBorder: true,
                      ),
                      requestSummary(
                        title: 'Request Code',
                        description: data['data']['code'],
                        showBorder: true,
                      ),
                      requestSummary(
                        title: 'Date',
                        description: data['data']['date'],
                        showBorder: true,
                      ),
                      requestSummary(
                        title: 'Time',
                        description: data['data']['time'],
                        showBorder: true,
                      ),
                      requestSummary(
                        title: 'Status',
                        description:
                            ReCase(data['data']['status']).sentenceCase,
                        showBorder: true,
                      ),
                      requestSummary(
                        title: 'Reference',
                        description: data['data']['reference'],
                        showBorder: false,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 0.040.sh,
                ),
              ],
            ),
          ),
        ));
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
