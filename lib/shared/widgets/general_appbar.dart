import 'package:ceuk_user_app/core/design_system/color_shemes.dart';
import 'package:ceuk_user_app/core/design_system/typography_style.dart';
import 'package:ceuk_user_app/shared/widgets/back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GeneralAppBar extends StatelessWidget implements PreferredSizeWidget {
  const GeneralAppBar({
    Key key,
    @required this.title,
    this.leading = true,
    this.actions = const [],
  }) : super(key: key);
  final String title;
  final bool leading;
  final List<Widget> actions;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  @override
  PreferredSizeWidget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: UIColors.white,
      elevation: 0,
      centerTitle: true,
      leading: leading ? const GoBack() : const SizedBox(),
      title: Text(
        title,
        style: TypographyStyle.heading5.copyWith(
          fontSize: 18.sp,
          color: UIColors.secondary,
        ),
      ),
      titleSpacing: 0,
      actions: actions,
    );
  }
}
