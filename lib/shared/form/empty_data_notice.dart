import 'package:ceuk_user_app/core/design_system/color_shemes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmptyDataNotice extends StatelessWidget {
  const EmptyDataNotice({Key key, @required this.message, this.icon})
      : super(key: key);
  final String message;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Padding(
      padding: const EdgeInsets.all(30.0),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              Icon(
                icon ?? PhosphorIcons.x,
                size: 0.35.sw,
                color: UIColors.secondary300,
              ),
              SizedBox(
                height: 0.02.sh,
              ),
              Text(message,
                  textAlign: TextAlign.center,
                  style:
                      TextStyle(fontSize: 15.sp, color: UIColors.secondary300))
            ],
          ),
        ),
      ),
    ));
  }
}
