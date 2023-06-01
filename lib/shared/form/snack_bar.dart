import 'package:ceuk_user_app/core/design_system/color_shemes.dart';
import 'package:ceuk_user_app/core/design_system/typography_style.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum FlushbarType { success, error, warning, hint }

class FlushBar {
  static Future showSnackBar(
      {BuildContext context, String message, FlushbarType type}) {
    return Flushbar(
      backgroundColor: type == FlushbarType.success
          ? UIColors.secondary400
          : type == FlushbarType.error
              ? UIColors.primary500
              : type == FlushbarType.hint
                  ? Colors.blue[400]
                  : Colors.yellow[400],
      margin: EdgeInsets.symmetric(horizontal: 0.040.sw, vertical: 60),
      borderRadius: 10.r,
      // message: message.toString(),
      flushbarStyle: FlushbarStyle.FLOATING,
      flushbarPosition: FlushbarPosition.TOP,
      duration: const Duration(seconds: 5),
      borderColor: type == FlushbarType.success
          ? UIColors.secondary300
          : type == FlushbarType.error
              ? UIColors.primary300
              : type == FlushbarType.hint
                  ? Colors.blue[300]
                  : Colors.yellow[300],
      //title: 'yuiuuuu',
      messageText: Text(
        message.toString(),
        textAlign: TextAlign.left,
        style: TypographyStyle.bodySmall.copyWith(
          fontWeight: FontWeight.w600,
          color: type == FlushbarType.success
              ? UIColors.secondary100
              : type == FlushbarType.error
                  ? UIColors.primary100
                  : type == FlushbarType.hint
                      ? Colors.blue[100]
                      : Colors.yellow[100],
        ),
      ),
      // messageColor: UIColors.secondary100,
      icon: SizedBox(
        height: 0.030.sh,
        child: Icon(
          type == FlushbarType.success
              ? PhosphorIcons.check
              : type == FlushbarType.warning
                  ? PhosphorIcons.warning
                  : type == FlushbarType.error
                      ? PhosphorIcons.x
                      : PhosphorIcons.info,
          color: type == FlushbarType.success
              ? UIColors.secondary100
              : type == FlushbarType.error
                  ? UIColors.primary100
                  : type == FlushbarType.hint
                      ? Colors.blue[100]
                      : Colors.yellow[100],
        ),
      ),
    ).show(context);
  }
}
