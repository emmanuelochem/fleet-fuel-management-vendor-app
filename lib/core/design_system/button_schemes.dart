import 'package:ceuk_user_app/core/design_system/color_shemes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ButtonUI {
  static ButtonStyle buttomprimary = ButtonStyle(
    fixedSize: MaterialStateProperty.all(const Size.fromWidth(double.infinity)),
    backgroundColor: MaterialStateProperty.resolveWith(
      (states) {
        if (states.contains(MaterialState.disabled)) {
          return UIColors.primary.withOpacity(0.4);
        } else {
          return UIColors.primary;
        }
      },
    ),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50.r),
        // side: BorderSide(color: Colors.red),
      ),
    ),
  );

  static ButtonStyle buttonPrimary100 = ButtonStyle(
    fixedSize: MaterialStateProperty.all(const Size.fromWidth(double.infinity)),
    backgroundColor: MaterialStateProperty.resolveWith(
      (states) {
        if (states.contains(MaterialState.disabled)) {
          return UIColors.primary100.withOpacity(0.4);
        } else {
          return UIColors.primary100;
        }
      },
    ),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50.r),
        // side: BorderSide(color: Colors.red),
      ),
    ),
  );
  static ButtonStyle buttonPrimary500 = ButtonStyle(
    fixedSize: MaterialStateProperty.all(const Size.fromWidth(double.infinity)),
    backgroundColor: MaterialStateProperty.resolveWith(
      (states) {
        if (states.contains(MaterialState.disabled)) {
          return UIColors.primary500.withOpacity(0.4);
        } else {
          return UIColors.primary500;
        }
      },
    ),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50.r),
        // side: BorderSide(color: Colors.red),
      ),
    ),
  );

  static ButtonStyle buttomSquareprimary = ButtonStyle(
    fixedSize: MaterialStateProperty.all(const Size.fromWidth(double.infinity)),
    backgroundColor: MaterialStateProperty.resolveWith(
      (states) {
        if (states.contains(MaterialState.disabled)) {
          return UIColors.primary.withOpacity(0.4);
        } else {
          return UIColors.primary;
        }
      },
    ),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.r),
        // side: BorderSide(color: Colors.red),
      ),
    ),
  );

  static ButtonStyle buttonSquarePrimary100 = ButtonStyle(
    fixedSize: MaterialStateProperty.all(const Size.fromWidth(double.infinity)),
    backgroundColor: MaterialStateProperty.resolveWith(
      (states) {
        if (states.contains(MaterialState.disabled)) {
          return UIColors.primary100.withOpacity(0.4);
        } else {
          return UIColors.primary100;
        }
      },
    ),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.r),
        // side: BorderSide(color: Colors.red),
      ),
    ),
  );
  static ButtonStyle buttonSquarePrimary500 = ButtonStyle(
    fixedSize: MaterialStateProperty.all(const Size.fromWidth(double.infinity)),
    backgroundColor: MaterialStateProperty.resolveWith(
      (states) {
        if (states.contains(MaterialState.disabled)) {
          return UIColors.primary500.withOpacity(0.4);
        } else {
          return UIColors.primary500;
        }
      },
    ),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.r),
        // side: BorderSide(color: Colors.red),
      ),
    ),
  );
}
