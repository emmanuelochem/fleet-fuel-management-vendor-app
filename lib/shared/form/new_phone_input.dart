import 'package:ceuk_user_app/core/design_system/color_shemes.dart';
import 'package:ceuk_user_app/core/design_system/form_schemes.dart';
import 'package:ceuk_user_app/core/design_system/typography_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

typedef ValueCallback = String Function(String);

class NewPhoneInputField extends StatefulWidget {
  const NewPhoneInputField({
    Key key,
    this.fieldKey,
    this.maxLength,
    this.hintText,
    this.labelText,
    this.helperText,
    this.onSaved,
    this.validator,
    this.onFieldSubmitted,
    this.fieldTitle,
    this.sideNote,
    this.onFieldChange,
    this.initialValue,
    this.canChange = true,
    this.enabled = true,
    this.defaultCountryIso = 'NG',
  }) : super(key: key);

  final Key fieldKey;
  final int maxLength;
  final String hintText;
  final String labelText;
  final String helperText;
  final String initialValue;
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> validator;
  final ValueChanged<String> onFieldSubmitted;
  final String fieldTitle;
  final String sideNote;
  final ValueChanged<String> onFieldChange;
  final bool canChange;
  final bool enabled;
  final String defaultCountryIso;

  @override
  _NewPhoneInputFieldState createState() => _NewPhoneInputFieldState();
}

class _NewPhoneInputFieldState extends State<NewPhoneInputField> {
  final TextEditingController textController = TextEditingController();
  FocusNode focusNode;
  @override
  void initState() {
    focusNode = FocusNode();
    focusNode.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      //height: 95,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(widget.fieldTitle,
                  style: TypographyStyle.bodyMediumn.copyWith(fontSize: 15.sp)),
              widget.sideNote != null
                  ? Padding(
                      padding: EdgeInsets.only(left: 0.012.sw),
                      child: Text(widget.sideNote,
                          style: TypographyStyle.bodySmall.copyWith(
                            color: UIColors.secondary300,
                          )),
                    )
                  : const SizedBox.shrink(),
            ],
          ),
          SizedBox(
            height: 0.0055.sh,
          ),
          TextFormField(
            enabled: widget.enabled,
            focusNode: focusNode,
            key: widget.fieldKey,
            obscureText: false,
            controller: textController,
            onSaved: widget.onSaved,
            keyboardType: TextInputType.phone,
            validator: widget.validator ??
                (value) {
                  if (value.isEmpty) {
                    return 'Please enter mobile number';
                  } else if ((value).contains('+234')) {
                    return 'Please exclude +234';
                  } else if (value.substring(0, 1) == '0') {
                    return 'Please provide your number without the first zero';
                  }
                  return null;
                },
            autovalidateMode: AutovalidateMode.onUserInteraction,
            onFieldSubmitted: widget.onFieldSubmitted,
            onChanged: widget.onFieldChange,
            style: TypographyStyle.bodyLarge
                .copyWith(color: UIColors.secondary200),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                  horizontal: 0.049.sw, vertical: 0.018.sh),
              prefixText: '+234',
              border: FormUI.normal,
              focusedBorder: FormUI.focus,
              enabledBorder: FormUI.enabled,
              errorBorder: FormUI.error,
              disabledBorder: FormUI.disabled,
              hintText: widget.hintText,
              labelText: widget.labelText,
              helperText: widget.helperText,
              hintStyle: TypographyStyle.bodyLarge
                  .copyWith(color: UIColors.secondary300),
              helperStyle: TypographyStyle.bodySmall,
              isDense: true,
              filled: true,
              fillColor: !widget.enabled
                  ? UIColors.secondary500
                  : focusNode.hasFocus
                      ? UIColors.secondary600
                      : UIColors.secondary600,
            ),
          ),
          SizedBox(
            height: 0.020.sh,
          ),
        ],
      ),
    );
  }
}
