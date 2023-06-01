import 'package:ceuk_user_app/core/design_system/color_shemes.dart';
import 'package:ceuk_user_app/core/design_system/typography_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MultiColoredTile extends StatelessWidget {
  MultiColoredTile({
    Key key,
    @required this.iconColor,
    @required this.onPressed,
    @required this.title,
    @required this.backgroundColor,
    @required this.pngIconPath,
    @required this.fontSize,
    @required this.fontFamily,
    this.chipText,
    this.chipTextColor,
    this.chipBackgroundColor,
    this.iconHeight,
  }) : super(key: key);

  final String pngIconPath;
  final Color iconColor;
  final String title;
  final Color backgroundColor;
  Function onPressed;
  final double fontSize;
  final String fontFamily;
  String chipText;
  Color chipTextColor = UIColors.white;
  Color chipBackgroundColor = UIColors.white;
  double iconHeight;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        //height: 0.080.sh,
        padding: EdgeInsets.symmetric(
          horizontal: 0.042.sw,
          vertical: 0.017.sh,
        ),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(
            10.r,
          ),
        ),
        child: Row(
          children: [
            SizedBox(
              height: iconHeight ?? 0.027.sh,
              child: Image.asset(
                pngIconPath.toString(),
                //color: iconColor,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              width: 0.030.sw,
            ),
            Expanded(
              child: Text(
                title.toString(),
                style: TypographyStyle.bodyMediumn.copyWith(
                  fontFamily: fontFamily,
                  fontSize: fontSize,
                ),
              ),
            ),
            chipText != null
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            left: 0.05.sw,
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: 0.027.sw, vertical: 0.005.sh),
                          decoration: BoxDecoration(
                            color: chipBackgroundColor,
                            borderRadius: BorderRadius.circular(200.r),
                          ),
                          child: Row(
                            children: [
                              Text(
                                chipText.toString(),
                                style: TypographyStyle.bodySmall.copyWith(
                                  fontSize: 14.sp,
                                  color: chipTextColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                : const SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}
