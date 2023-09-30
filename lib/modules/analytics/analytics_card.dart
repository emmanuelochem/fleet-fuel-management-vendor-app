import 'package:ceuk_user_app/core/design_system/color_shemes.dart';
import 'package:ceuk_user_app/core/design_system/typography_style.dart';
import 'package:ceuk_user_app/shared/widgets/shimmer_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AnalyticsCard extends StatelessWidget {
  final IconData icon;
  final bool isActive;
  final String name;
  final String value;
  final bool isLoading;
  const AnalyticsCard(
      {Key key,
      @required this.icon,
      this.isActive = false,
      this.isLoading = false,
      this.name = 'name',
      this.value = 'value'})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 0.2.sh,
      height: 140,
      decoration: BoxDecoration(
          color: UIColors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: UIColors.secondary.withOpacity(0.01),
              spreadRadius: 10,
              blurRadius: 3,
            ),
          ]),
      child: Padding(
        padding: EdgeInsets.all(0.02.sh),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            isLoading
                ? ShimmerLoader.circular(
                    width: 0.040.sh,
                    height: 0.040.sh,
                  )
                : Container(
                    width: 0.040.sh,
                    height: 0.040.sh,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color:
                            isActive ? UIColors.primary : UIColors.secondary),
                    child: Center(
                        child: Icon(
                      icon,
                      color: UIColors.white,
                    )),
                  ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                isLoading
                    ? ShimmerLoader.rectangular(
                        width: 0.050.sh,
                        height: 0.01.sh,
                      )
                    : Text(
                        name,
                        style: TypographyStyle.bodyLarge.copyWith(
                            fontSize: 10.sp,
                            height: 1.5,
                            color: UIColors.secondary200),
                      ),
                SizedBox(
                  height: 0.005.sh,
                ),
                isLoading
                    ? ShimmerLoader.rectangular(
                        width: 0.090.sh,
                        height: 0.015.sh,
                      )
                    : Text(
                        value,
                        style: TypographyStyle.bodySmall.copyWith(
                            fontSize: 14.sp,
                            height: 1.5,
                            color: UIColors.secondary100,
                            fontWeight: FontWeight.w600),
                      )
              ],
            )
          ],
        ),
      ),
    );
  }
}
