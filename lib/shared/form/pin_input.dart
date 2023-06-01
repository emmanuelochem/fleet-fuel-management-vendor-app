import 'package:ceuk_user_app/core/design_system/color_shemes.dart';
import 'package:ceuk_user_app/core/design_system/typography_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

typedef InputCallback = String Function(String);

class PinInputFields extends StatefulWidget {
  PinInputFields(
      {Key key,
      @required this.controller,
      this.callback,
      @required this.inputLength,
      this.hideText = false,
      this.validator,
      this.enableKeyboard = true})
      : super(key: key);

  final TextEditingController controller;
  final InputCallback callback;
  final int inputLength;
  final bool hideText;
  final bool enableKeyboard;
  String Function(String) validator;

  @override
  State<PinInputFields> createState() => _PinInputFieldsState();
}

class _PinInputFieldsState extends State<PinInputFields> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 1.sw,
      child: PinCodeTextField(
        appContext: context,
        textStyle: TypographyStyle.bodyLarge,
        length: widget.inputLength,
        obscureText: widget.hideText,
        obscuringCharacter: '*',
        animationType: AnimationType.fade,
        validator: (v) {
          if (v.length < widget.inputLength) {
            return "Enter a valid ${widget.inputLength} digits pin.";
            // return null;
          } else {
            return null;
          }
        },
        autovalidateMode: AutovalidateMode.onUserInteraction,
        pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(10.r),
          fieldHeight: 0.062.sh,
          fieldWidth: 0.062.sh,
          borderWidth: 1,
          inactiveColor: UIColors.secondary600,
          activeColor: UIColors.primary,
          selectedFillColor: UIColors.secondary500,
          selectedColor: UIColors.primary,
          inactiveFillColor: UIColors.secondary600,
          activeFillColor: UIColors.secondary500,

          // errorBorderColor: UIColors.sRed100,
        ),
        cursorColor: UIColors.secondary100,
        animationDuration: const Duration(milliseconds: 300),
        backgroundColor: Colors.transparent,
        enableActiveFill: true,
        controller: widget.controller,
        keyboardType:
            widget.enableKeyboard ? TextInputType.number : TextInputType.none,
        onCompleted: (value) {
          widget.callback(value);
          setState(() {});
        },
        onTap: () {},
        onChanged: (value) {
          widget.callback(value);
          setState(() {});
        },
        beforeTextPaste: (text) {
          return true;
        },
      ),
    );
  }
}
