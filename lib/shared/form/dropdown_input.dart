import 'package:ceuk_user_app/core/design_system/color_shemes.dart';
import 'package:ceuk_user_app/core/design_system/form_schemes.dart';
import 'package:ceuk_user_app/core/design_system/typography_style.dart';
import 'package:ceuk_user_app/shared/form/dropdown_buttomsheet.dart';
import 'package:ceuk_user_app/shared/form/dropdown_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

typedef ValueCallback = DropdownModel Function(DropdownModel);

class DropDownInput extends StatefulWidget {
  DropDownInput(
      {Key key,
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
      this.sideNoteColor,
      this.footerNote,
      this.footerNoteColor,
      this.footerHighlightNote,
      this.footerHighlightColor,
      this.enabled = true,
      @required this.optionsList,
      @required this.sheetTitle,
      this.showSearch = false,
      this.searchPlaceholder,
      this.initialValue})
      : super(key: key);

  final Key fieldKey;
  final int maxLength;
  final String hintText;
  final String labelText;
  final String helperText;
  final ValueCallback onSaved;
  final FormFieldValidator<DropdownModel> validator;
  final ValueChanged<String> onFieldSubmitted;
  final String fieldTitle;
  final String sideNote;
  final Color sideNoteColor;
  final String footerNote;
  Color footerNoteColor;
  final String footerHighlightNote;
  final Color footerHighlightColor;
  final bool enabled;
  final String sheetTitle;
  final List<DropdownModel> optionsList;
  final bool showSearch;
  final String searchPlaceholder;
  final String initialValue;

  @override
  State<DropDownInput> createState() => _DropDownInputState();
}

class _DropDownInputState extends State<DropDownInput> {
  DropdownModel selectedValue;

  FocusNode focusNode;
  @override
  void initState() {
    focusNode = FocusNode();
    focusNode.addListener(() {
      setState(() {});
    });
    super.initState();

    autoSelect();
  }

  autoSelect() {
    if (widget.initialValue != null && widget.initialValue.trim() != '') {
      for (var element in widget.optionsList) {
        if (element.value.trim().toLowerCase() ==
            widget.initialValue.trim().toLowerCase()) {
          selectedValue = element;
        }
      }
    }
  }

  @override
  void didUpdateWidget(covariant DropDownInput oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    autoSelect();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: !widget.enabled
          ? null
          : () async {
              DropdownModel response =
                  await showMaterialModalBottomSheet<DropdownModel>(
                context: context,
                expand: false,
                isDismissible: false,
                enableDrag: false,
                //elevation: 10,
                backgroundColor: Colors.transparent,
                builder: (context) => DropdownBottomsheet(
                  title: widget.sheetTitle.toString(),
                  optionList: widget.optionsList,
                  showSearch: widget.showSearch,
                  searchPlaceholder: widget.searchPlaceholder,
                ),
              );
              if (response != null) {
                setState(() {
                  selectedValue = response;
                });
                widget.onSaved(response);
              }
            },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              widget.fieldTitle == null
                  ? const SizedBox()
                  : Text(widget.fieldTitle,
                      style: TypographyStyle.bodyMediumn
                          .copyWith(fontSize: 15.sp)),
              widget.sideNote != null
                  ? Padding(
                      padding: EdgeInsets.only(left: 0.012.sw),
                      child: Text(widget.sideNote,
                          style: TypographyStyle.bodySmall.copyWith(
                            color:
                                widget.sideNoteColor ?? UIColors.secondary300,
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
              AbsorbPointer(
                child: DropdownButtonFormField<DropdownModel>(
                  isDense: true,
                  isExpanded: true,
                  focusNode: focusNode,
                  onSaved: widget.onSaved,
                  validator: widget.validator,
                  style: TypographyStyle.bodyLarge
                      .copyWith(color: UIColors.secondary200),
                  decoration: InputDecoration(
                    border: FormUI.normal,
                    focusedBorder: FormUI.focus,
                    enabledBorder: FormUI.enabled,
                    errorBorder: FormUI.error,
                    disabledBorder: FormUI.disabled,
                    hintStyle: TypographyStyle.bodyLarge
                        .copyWith(color: UIColors.secondary300),
                    helperStyle: TypographyStyle.bodySmall.copyWith(
                        color: UIColors.secondary300, fontSize: 15.sp),
                    filled: true,
                    fillColor: !widget.enabled
                        ? UIColors.secondary500
                        : focusNode.hasFocus
                            ? UIColors.white
                            : UIColors.secondary600,
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: 0.049.sw, vertical: 0.018.sh),
                    hintText: widget.hintText,
                    labelText: widget.labelText,
                    helperText: widget.helperText,
                  ),
                  elevation: 0,
                  value: selectedValue,
                  onChanged: (DropdownModel newValue) =>
                      setState(() => selectedValue = newValue),
                  items: widget.optionsList
                      .map<DropdownMenuItem<DropdownModel>>(
                          (DropdownModel value) =>
                              DropdownMenuItem<DropdownModel>(
                                value: value,
                                child: Row(
                                  children: [
                                    value.icon != null
                                        ? Padding(
                                            padding: EdgeInsets.only(
                                                right: 0.024.sw),
                                            child: Image.asset(
                                              value.icon,
                                              height: 0.025.sh,
                                              width: 0.025.sh,
                                            ),
                                          )
                                        : const SizedBox.shrink(),
                                    Expanded(
                                      child: Text(
                                        value.name ?? '---',
                                        softWrap: true,
                                        overflow: TextOverflow.ellipsis,
                                        style: TypographyStyle.bodyMediumn
                                            .copyWith(fontSize: 14.sp),
                                      ),
                                    ),
                                  ],
                                ),
                              ))
                      .toList(),
                  icon: Icon(PhosphorIcons.caret_down,
                      size: 0.024.sh, color: UIColors.secondary300),
                  iconSize: 23.sp,
                ),
              ),

              //
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
