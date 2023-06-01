import 'package:ceuk_user_app/core/design_system/color_shemes.dart';
import 'package:ceuk_user_app/core/design_system/typography_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BanksListTile extends StatefulWidget {
  const BanksListTile({
    Key key,
    this.name,
    this.bankName,
    this.accountNumber,
    this.onClicked,
    this.longPressed,
  }) : super(key: key);

  final String name;
  final String bankName;
  final String accountNumber;
  final Function onClicked;
  final Function longPressed;

  @override
  State<BanksListTile> createState() => _BanksListTileState();
}

class _BanksListTileState extends State<BanksListTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onClicked,
      child: Container(
        //height: 0.080.sh,
        margin: EdgeInsets.only(bottom: 0.01.sh),
        padding: EdgeInsets.symmetric(
          horizontal: 0.032.sw,
          vertical: 0.015.sh,
        ),
        decoration: BoxDecoration(
            color: UIColors.white, borderRadius: BorderRadius.circular(15.r)),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 0.010.sh,
                vertical: 0.010.sh,
              ),
              decoration: BoxDecoration(
                  color: UIColors.secondary600, shape: BoxShape.circle),
              child: const Icon(
                PhosphorIcons.bank,
              ),
            ),
            SizedBox(
              width: 0.033.sw,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.name.toString(),
                    style: TypographyStyle.bodyMediumn.copyWith(
                        fontSize: 16.sp,
                        color: UIColors.secondary,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 0.0015.sh,
                  ),
                  Text(
                    widget.bankName,
                    style: TypographyStyle.bodySmall.copyWith(
                      fontSize: 14.sp,
                      color: UIColors.secondary300,
                    ),
                  )
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  widget.accountNumber,
                  textAlign: TextAlign.end,
                  style: TypographyStyle.bodySmall.copyWith(
                    fontSize: 13.sp,
                    color: UIColors.secondary,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
