import 'package:ceuk_user_app/core/design_system/color_shemes.dart';
import 'package:ceuk_user_app/core/design_system/typography_style.dart';
import 'package:ceuk_user_app/shared/form/dropdown_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recase/recase.dart';

typedef ValueCallback = DropdownModel Function(DropdownModel);

class DropDownListTile extends StatelessWidget {
  DropDownListTile({Key key, @required this.item, this.callback})
      : super(key: key);

  DropdownModel item;
  ValueCallback callback;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        callback(item);
      },
      child: Container(
        //height: 0.059.sh,
        padding: EdgeInsets.symmetric(
          horizontal: 0.042.sw,
          vertical: 0.016.sh,
        ),
        margin: EdgeInsets.only(
          bottom: 0.006.sh,
        ),
        decoration: BoxDecoration(
            color: UIColors.white, borderRadius: BorderRadius.circular(10.r)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            item.icon != null
                ? Padding(
                    padding: EdgeInsets.only(right: 0.024.sw),
                    child: Image.asset(
                      item.icon,
                      height: 0.025.sh,
                      width: 0.025.sh,
                    ),
                  )
                : const SizedBox.shrink(),
            Expanded(
              child: Text(ReCase(item.name.toString()).sentenceCase,
                  overflow: TextOverflow.visible,
                  style: TypographyStyle.bodyLarge.copyWith(fontSize: 17.sp)),
            ),
          ],
        ),
      ),
    );
  }
}
