import 'package:ceuk_user_app/core/design_system/color_shemes.dart';
import 'package:ceuk_user_app/core/design_system/typography_style.dart';
import 'package:ceuk_user_app/core/logics/generalLogics.dart';
import 'package:ceuk_user_app/shared/form/snack_bar.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SummaryTile extends StatelessWidget {
  const SummaryTile(
      {Key key,
      this.title = 'title',
      this.description = 'Description',
      this.showBorder = true,
      this.copy = false})
      : super(key: key);
  final String title;
  final String description;
  final bool showBorder;
  final bool copy;
  @override
  Widget build(BuildContext context) {
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
      child: Row(
        children: [
          Expanded(
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
          ),
          copy
              ? GestureDetector(
                  onTap: () {
                    FlutterClipboard.copy(description).then((value) =>
                        GeneralLogics.showMessageNew(
                            '$title copied.', FlushbarType.success, context));
                  },
                  child: Icon(
                    PhosphorIcons.copy,
                    size: 15.sp,
                  ),
                )
              : const SizedBox()
        ],
      ),
    );
  }
}
