import 'package:ceuk_user_app/core/design_system/color_shemes.dart';
import 'package:ceuk_user_app/core/design_system/typography_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RegularActionTile extends StatelessWidget {
  RegularActionTile({
    Key key,
    this.iconColor,
    this.onTap,
    @required this.title,
    @required this.backgroundColor,
    @required this.svgIconPath,
    this.verticalPadding,
    this.fontFamily,
    this.titleFontSize,
    this.titleColor,
    this.trailingText,
    this.trailingColor,
    this.trailingFontFamily,
    this.trailingFontSize,
  }) : super(key: key);

  final String svgIconPath;
  final Color iconColor;
  final String title;
  final Color backgroundColor;
  VoidCallback onTap;
  double verticalPadding;
  String fontFamily;
  double titleFontSize;
  Color titleColor;
  String trailingText;
  Color trailingColor;
  String trailingFontFamily;
  double trailingFontSize;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 0.01.sh),
        padding: EdgeInsets.symmetric(
          horizontal: 0.042.sw,
          vertical: verticalPadding ?? 0.015.sh,
        ),
        decoration: BoxDecoration(
            color: backgroundColor, borderRadius: BorderRadius.circular(10.r)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 0.037.sh,
              //width: 0.037.sh,
              child: SvgPicture.asset(
                svgIconPath.toString(),
                color: iconColor,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(
              width: 0.030.sw,
            ),
            Expanded(
              child: Text(
                title.toString(),
                style: TypographyStyle.bodyMediumn.copyWith(
                    fontFamily: fontFamily ?? 'FacebookSans',
                    fontSize: titleFontSize ?? 18.sp,
                    color: titleColor ?? UIColors.primary100),
              ),
            ),
            trailingText != null
                ? Text(
                    trailingText.toString(),
                    style: TypographyStyle.bodyMediumn.copyWith(
                        fontFamily: trailingFontFamily ?? 'FacebookSans',
                        fontSize: trailingFontSize ?? 18.sp,
                        color: trailingColor ?? UIColors.primary100),
                  )
                : const SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}
