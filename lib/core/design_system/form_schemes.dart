import 'package:ceuk_user_app/core/design_system/color_shemes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FormUI {
  static OutlineInputBorder normal = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10.r),
    borderSide: const BorderSide(
      width: 0,
      style: BorderStyle.none,
    ),
  );

  static OutlineInputBorder focus = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10.r),
    borderSide: BorderSide(
        width: 0.003.sw, style: BorderStyle.solid, color: UIColors.primary),
  );

  static OutlineInputBorder enabled = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10.r),
    borderSide: BorderSide(
      width: 0.sw,
      style: BorderStyle.none,
      color: UIColors.primary,
    ),
  );
  static OutlineInputBorder error = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10.r),
    borderSide: BorderSide(
      width: 0.003.sw,
      style: BorderStyle.solid,
      color: UIColors.primary,
    ),
  );
  static OutlineInputBorder disabled = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10.r),
    borderSide: BorderSide(
      width: 0.00.sw,
      style: BorderStyle.none,
      color: UIColors.primary,
    ),
  );
}
