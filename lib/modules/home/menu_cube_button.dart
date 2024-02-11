import 'package:ceuk_user_app/core/design_system/color_shemes.dart';
import 'package:ceuk_user_app/core/design_system/typography_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class HomeCubeButton extends StatelessWidget {
  const HomeCubeButton(
      {Key key,
      this.child = const SizedBox(),
      this.icon,
      this.bgColor,
      this.textColor,
      this.title = ''})
      : super(key: key);
  final Widget child;
  final IconData icon;
  final String title;
  final Color bgColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await showMaterialModalBottomSheet(
          context: context,
          expand: false,
          isDismissible: false,
          enableDrag: false,
          elevation: 0,
          backgroundColor: Colors.transparent,
          builder: (context) => child,
        );
      },
      child: Container(
        //height: 0.055.sh,
        width: 70,
        padding: EdgeInsets.all(0.022.sw),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20.r)),
          color: bgColor ?? UIColors.primary600,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon == null
                ? const SizedBox()
                : Icon(
                    icon,
                    color: textColor ?? Colors.black,
                  ),
            title == ''
                ? const SizedBox()
                : Padding(
                    padding: EdgeInsets.symmetric(horizontal: 0.010.sw),
                    child: Text(
                      title,
                      overflow: TextOverflow.ellipsis,
                      style: TypographyStyle.bodyMediumn.copyWith(
                        fontSize: 13.sp,
                        color: textColor ?? Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
