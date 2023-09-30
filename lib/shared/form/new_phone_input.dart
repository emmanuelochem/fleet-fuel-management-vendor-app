import 'package:ceuk_user_app/core/design_system/color_shemes.dart';
import 'package:ceuk_user_app/core/design_system/form_schemes.dart';
import 'package:ceuk_user_app/core/design_system/typography_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';

class IntPhoneInputField extends StatefulWidget {
  IntPhoneInputField(
      {Key key,
      this.fieldKey,
      this.maxLength,
      this.hintText,
      this.labelText,
      this.helperText,
      this.onSaved,
      this.validator,
      this.onFieldSubmitted,
      this.onFieldChange,
      this.fieldTitle,
      this.sideNote,
      this.footerNote,
      this.footerNoteColor,
      this.footerHighlightNote,
      this.footerHighlightColor,
      this.enabled = true,
      this.initialValue,
      this.textController,
      this.hasController = false,
      this.disabledColor,
      this.defaultCountry = 'NG'})
      : super(key: key);

  final Key fieldKey;
  final int maxLength;
  final String hintText;
  final String labelText;
  final String helperText;
  final FormFieldSetter<PhoneNumber> onSaved;
  final FormFieldValidator<PhoneNumber> validator;
  final ValueChanged<String> onFieldSubmitted;
  final ValueChanged<PhoneNumber> onFieldChange;
  final String fieldTitle;
  final String sideNote;
  final String footerNote;
  Color footerNoteColor;
  final String footerHighlightNote;
  final Color footerHighlightColor;
  final bool enabled;
  final String initialValue;
  final bool hasController;
  final TextEditingController textController;
  final Color disabledColor;
  String defaultCountry;

  @override
  _IntPhoneInputFieldState createState() => _IntPhoneInputFieldState();
}

class _IntPhoneInputFieldState extends State<IntPhoneInputField> {
  final bool _obscureText = true;
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IntlPhoneField(
                initialCountryCode: widget.defaultCountry,
                showDropdownIcon: false,
                disableLengthCheck: false,
                showCountryFlag: false,
                dropdownIconPosition: IconPosition.trailing,
                flagsButtonMargin: EdgeInsets.only(left: 0.049.sw),
                pickerDialogStyle: PickerDialogStyle(
                    countryCodeStyle: TypographyStyle.bodyLarge
                        .copyWith(color: UIColors.secondary200),
                    countryNameStyle: TypographyStyle.bodyLarge
                        .copyWith(color: UIColors.secondary200),
                    listTilePadding: const EdgeInsets.all(0)),
                controller: widget.hasController ? widget.textController : null,
                initialValue: widget.hasController ? null : widget.initialValue,
                enabled: widget.enabled,
                focusNode: focusNode,
                key: widget.fieldKey,
                obscureText: false,
                onSaved: widget.onSaved,
                validator: widget.validator,
                onSubmitted: widget.onFieldSubmitted,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                onChanged: widget.onFieldChange,
                style: TypographyStyle.bodyLarge
                    .copyWith(color: UIColors.secondary200),
                decoration: InputDecoration(
                  prefixStyle: TypographyStyle.bodyLarge
                      .copyWith(color: UIColors.secondary200),
                  border: FormUI.normal,
                  focusedBorder: FormUI.focus,
                  enabledBorder: FormUI.enabled,
                  errorBorder: FormUI.error,
                  disabledBorder: FormUI.disabled,
                  hintStyle: TypographyStyle.bodyLarge
                      .copyWith(color: UIColors.secondary300),
                  helperStyle: TypographyStyle.bodySmall
                      .copyWith(color: UIColors.secondary300, fontSize: 15.sp),
                  filled: true,
                  counterText: '',
                  fillColor: !widget.enabled
                      ? (widget.disabledColor ?? UIColors.secondary500)
                      : focusNode.hasFocus
                          ? UIColors.secondary600
                          : UIColors.secondary600,
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: 0.049.sw, vertical: 0.018.sh),
                  hintText: widget.hintText,
                  labelText: widget.labelText,
                  helperText: widget.helperText,
                ),
              ),
              // InternationalPhoneNumberInput(
              //   selectorConfig: SelectorConfig(
              //       selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
              //       setSelectorButtonAsPrefixIcon: true,
              //       trailingSpace: false,
              //       leadingPadding: 0.049.sw),
              //   textFieldController:
              //       widget.hasController ? widget.textController : null,
              //   initialValue: widget.hasController ? null : widget.initialValue,
              //   isEnabled: widget.enabled,
              //   focusNode: focusNode,
              //   key: widget.fieldKey,
              //   onSaved: widget.onSaved,
              //   validator: widget.validator,
              //   onFieldSubmitted: widget.onFieldSubmitted,
              //   autoValidateMode: AutovalidateMode.onUserInteraction,
              //   formatInput: true,
              //   countrySelectorScrollControlled: true,
              //   keyboardType: const TextInputType.numberWithOptions(
              //       signed: true, decimal: true),
              //   onInputChanged: widget.onFieldChange,
              //   selectorTextStyle: TypographyStyle.bodyLarge
              //       .copyWith(color: UIColors.secondary200),
              //   searchBoxDecoration: InputDecoration(
              //     border: FormUI.normal,
              //     focusedBorder: FormUI.focus,
              //     enabledBorder: FormUI.enabled,
              //     errorBorder: FormUI.error,
              //     disabledBorder: FormUI.disabled,
              //     hintStyle: TypographyStyle.bodyLarge
              //         .copyWith(color: UIColors.secondary300),
              //     helperStyle: TypographyStyle.bodySmall
              //         .copyWith(color: UIColors.secondary300, fontSize: 15.sp),
              //     filled: true,
              //     fillColor: !widget.enabled
              //         ? (widget.disabledColor ?? UIColors.secondary500)
              //         : focusNode.hasFocus
              //             ? UIColors.secondary600
              //             : UIColors.secondary600,
              //     isDense: true,
              //     contentPadding: EdgeInsets.symmetric(
              //         horizontal: 0.049.sw, vertical: 0.018.sh),
              //     hintText: 'Search country or code',
              //     // labelText: widget.labelText,
              //     // helperText: 'Search country or code',
              //   ),
              //   spaceBetweenSelectorAndTextField: 0,
              //   textStyle: TypographyStyle.bodyLarge
              //       .copyWith(color: UIColors.secondary200),
              //   inputDecoration: InputDecoration(
              //     border: FormUI.normal,
              //     focusedBorder: FormUI.focus,
              //     enabledBorder: FormUI.enabled,
              //     errorBorder: FormUI.error,
              //     disabledBorder: FormUI.disabled,
              //     hintStyle: TypographyStyle.bodyLarge
              //         .copyWith(color: UIColors.secondary300),
              //     helperStyle: TypographyStyle.bodySmall
              //         .copyWith(color: UIColors.secondary300, fontSize: 15.sp),
              //     filled: true,
              //     fillColor: !widget.enabled
              //         ? (widget.disabledColor ?? UIColors.secondary500)
              //         : focusNode.hasFocus
              //             ? UIColors.secondary600
              //             : UIColors.secondary600,
              //     isDense: true,
              //     contentPadding: EdgeInsets.symmetric(
              //         horizontal: 0.049.sw, vertical: 0.018.sh),
              //     hintText: widget.hintText,
              //     labelText: widget.labelText,
              //     helperText: widget.helperText,
              //   ),
              // ),
              widget.footerNote != null
                  ? Column(
                      children: [
                        SizedBox(
                          height: 0.001.sh,
                        ),
                        RichText(
                          textAlign: TextAlign.start,
                          text: TextSpan(
                            children: [
                              widget.footerNote != null
                                  ? TextSpan(
                                      text: widget.footerNote,
                                      style:
                                          TypographyStyle.bodyMediumn.copyWith(
                                        color: widget.footerNoteColor ??
                                            UIColors.secondary300,
                                        fontSize: 14.sp,
                                      ),
                                    )
                                  : const TextSpan(),
                              widget.footerHighlightNote != null
                                  ? TextSpan(
                                      text: widget.footerHighlightNote,
                                      style:
                                          TypographyStyle.bodyMediumn.copyWith(
                                        color: widget.footerHighlightColor,
                                        fontSize: 14.sp,
                                      ),
                                    )
                                  : const TextSpan()
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 0.01.sh,
                        ),
                      ],
                    )
                  : const SizedBox.shrink()
            ],
          ),
          SizedBox(
            height: 0.020.sh,
          ),
        ],
      ),
    );
  }
}
