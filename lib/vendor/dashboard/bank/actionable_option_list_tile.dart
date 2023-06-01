import 'package:ceuk_user_app/core/design_system/color_shemes.dart';
import 'package:ceuk_user_app/core/design_system/typography_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ActionableOptionListTile extends StatelessWidget {
  ActionableOptionListTile({
    Key key,
    @required this.title,
    @required this.backgroundColor,
    @required this.fontSize,
    this.fontFamily,
    this.onPressed,
    @required this.iconData,
    @required this.iconBackgroundColor,
    this.iconColor,
    this.titleColor,
  }) : super(key: key);

  final String title;
  final Color backgroundColor;
  final double fontSize;
  String fontFamily;
  IconData iconData;
  final Color iconBackgroundColor;
  final Color iconColor;
  final Color titleColor;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        //height: 0.080.sh,
        margin: EdgeInsets.only(bottom: 0.007.sh),
        padding: EdgeInsets.symmetric(
          horizontal: 0.042.sw,
          vertical: 0.014.sh,
        ),
        decoration: BoxDecoration(
            color: backgroundColor, borderRadius: BorderRadius.circular(10.r)),
        child: Row(
          children: [
            Container(
              height: 0.033.sh,
              width: 0.033.sh,
              decoration: BoxDecoration(
                color: iconBackgroundColor,
                shape: BoxShape.circle,
              ),
              child: Icon(
                iconData,
                color: iconColor,
                size: 0.024.sh,
              ),
            ),
            SizedBox(
              width: 0.043.sw,
            ),
            Expanded(
              child: Text(
                title.toString(),
                style: TypographyStyle.bodyMediumn.copyWith(
                    fontFamily: fontFamily ?? 'FacebookSans',
                    fontSize: fontSize,
                    color: titleColor ?? UIColors.secondary),
              ),
            ),
            // chipText != null
            //     ? Center(
            //         child: Column(
            //           mainAxisSize: MainAxisSize.min,
            //           children: [
            //             Container(
            //               margin: EdgeInsets.only(
            //                 left: 0.05.sw,
            //               ),
            //               padding: EdgeInsets.symmetric(
            //                   horizontal: 0.027.sw, vertical: 0.005.sh),
            //               decoration: BoxDecoration(
            //                 color: chipBackgroundColor,
            //                 borderRadius: BorderRadius.circular(200.r),
            //               ),
            //               child: Row(
            //                 children: [
            //                   Text(
            //                     chipText.toString(),
            //                     style: TypographyStyle.bodySmall.copyWith(
            //                       fontSize: fontSize ?? 14.sp,
            //                       color: chipTextColor,
            //                     ),
            //                   ),
            //                 ],
            //               ),
            //             ),
            //           ],
            //         ),
            //       )
            //     : const SizedBox.shrink()
            onPressed != null
                ? SvgPicture.asset(
                    'assets/images/icons/play.svg',
                    color: UIColors.secondary400,
                  )
                : const SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}
