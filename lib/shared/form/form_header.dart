import 'package:ceuk_user_app/core/design_system/color_shemes.dart';
import 'package:ceuk_user_app/core/design_system/typography_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FormHeader extends StatelessWidget {
  const FormHeader({
    Key key,
    this.title,
    this.description,
    this.centerTitle = false,
    this.centerDescription = false,
    this.descriptionFontSize,
    this.titleFontSize,
    this.hasCustomTitleSize = false,
    this.hasDescriptionTitleSize = false,
  }) : super(key: key);
  final String title;
  final String description;
  final bool centerTitle;
  final bool centerDescription;
  final double titleFontSize;
  final double descriptionFontSize;
  final bool hasCustomTitleSize;
  final bool hasDescriptionTitleSize;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 1.sw,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          title != null
              ? Text(
                  title.toString(),
                  textAlign: centerTitle ? TextAlign.center : TextAlign.start,
                  style: hasCustomTitleSize
                      ? TypographyStyle.heading4
                          .copyWith(fontSize: titleFontSize)
                      : TypographyStyle.heading4,
                )
              : const SizedBox.shrink(),
          description != null
              ? Column(
                  crossAxisAlignment: centerDescription
                      ? CrossAxisAlignment.center
                      : CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 0.007.sh,
                    ),
                    Text(description.toString(),
                        textAlign: centerDescription
                            ? TextAlign.center
                            : TextAlign.start,
                        style: hasDescriptionTitleSize
                            ? TypographyStyle.bodyMediumn.copyWith(
                                fontSize: descriptionFontSize,
                                color: UIColors.secondary300,
                              )
                            : TypographyStyle.bodyMediumn.copyWith(
                                fontSize: 17.sp,
                                color: UIColors.secondary300,
                              )),
                  ],
                )
              : const SizedBox.shrink(),
          SizedBox(
            height: 0.040.sh,
          ),
        ],
      ),
    );
  }
}
