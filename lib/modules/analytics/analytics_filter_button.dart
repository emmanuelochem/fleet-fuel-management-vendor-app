import 'package:ceuk_user_app/core/design_system/color_shemes.dart';
import 'package:ceuk_user_app/shared/form/dropdown_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

typedef ValueCallback = DropdownModel Function(DropdownModel);

class AnalyticsFilterButton extends StatefulWidget {
  const AnalyticsFilterButton(
      {Key key, this.data, this.activeValue, this.callback})
      : super(key: key);

  final DropdownModel data;
  final String activeValue;
  final ValueCallback callback;

  @override
  State<AnalyticsFilterButton> createState() => _AnalyticsFilterButtonState();
}

class _AnalyticsFilterButtonState extends State<AnalyticsFilterButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.callback(widget.data);
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          // horizontal: 0.03.sh,
          vertical: 0.013.sh,
        ),
        decoration: BoxDecoration(
            color: widget.activeValue == widget.data.value
                ? UIColors.primary
                : UIColors.secondary.withOpacity(0.02),
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
                color: widget.activeValue == widget.data.value
                    ? UIColors.primary
                    : UIColors.secondary500)),
        child: Text(
          widget.data.name,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 10.sp,
              fontWeight: FontWeight.w600,
              color: widget.activeValue == widget.data.value
                  ? UIColors.white
                  : UIColors.secondary),
        ),
      ),
    );
  }
}
