import 'package:ceuk_user_app/core/design_system/color_shemes.dart';
import 'package:ceuk_user_app/core/design_system/typography_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class HomeCubeButton extends StatelessWidget {
  const HomeCubeButton(
      {Key key,
      this.child = const SizedBox(),
      this.icon = Icons.abc,
      this.title = 'Title'})
      : super(key: key);
  final Widget child;
  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: GestureDetector(
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
              margin: EdgeInsets.all(0.010.sw),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20.r)),
                color: UIColors.primary600.withOpacity(.4),
              ),
              child: Center(
                child: Container(
                  margin: EdgeInsets.all(0.058.sw),
                  child: Icon(icon),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 0.005.sh,
        ),
        Text(
          title,
          style: TypographyStyle.bodyMediumn.copyWith(
            fontSize: 13.sp,
          ),
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
