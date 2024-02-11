import 'package:ceuk_user_app/core/design_system/color_shemes.dart';
import 'package:ceuk_user_app/core/design_system/typography_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NumericKeyboard extends StatefulWidget {
  const NumericKeyboard({
    Key key,
    @required this.textEditingController,
    this.inputLength = 4,
    this.disallowedKeys = const [],
  }) : super(key: key);
  final TextEditingController textEditingController;
  final int inputLength;
  final List<String> disallowedKeys;

  @override
  State<NumericKeyboard> createState() => _NumericKeyboardState();
}

class _NumericKeyboardState extends State<NumericKeyboard> {
  List<List<dynamic>> keys;
  @override
  void initState() {
    super.initState();
    keys = [
      ['1', '2', '3'],
      ['4', '5', '6'],
      ['7', '8', '9'],
      [
        '.',
        '0',
        Container(
          height: 0.059.sh,
          // width: 0.168.sw,
          margin: EdgeInsets.only(bottom: 0.017.sh),
          decoration: BoxDecoration(
              // color: UIColors.secondary600,
              borderRadius: BorderRadius.circular(8.r)),
          child: Center(
            child: Icon(
              PhosphorIcons.caret_left_bold,
              size: 24.sp,
              color: UIColors.secondary100,
            ),
          ),
        )
      ],
    ];
    widget.textEditingController.text = '';
  }

  onKeyTap(val) {
    if (widget.disallowedKeys.contains(val)) return;

    if (val == '.' && widget.textEditingController.text.isEmpty ||
        widget.textEditingController.text.length == widget.inputLength) {
      return;
    }
    setState(() {
      widget.textEditingController.text =
          widget.textEditingController.text + val;
    });
  }

  onBackspacePress() {
    if (widget.textEditingController.text.isEmpty) {
      return;
    }

    setState(() {
      widget.textEditingController.text = widget.textEditingController.text
          .substring(0, widget.textEditingController.text.length - 1);
    });
  }

  renderKeyboard() {
    return keys
        .map(
          (row) => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: row.map(
              (number) {
                return KeyboardKey(
                  label: number,
                  value: number,
                  onTap: (val) {
                    if (val is Widget) {
                      onBackspacePress();
                    } else {
                      onKeyTap(val);
                    }
                  },
                );
              },
            ).toList(),
          ),
        )
        .toList();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // widget.textEditingController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        //height: 0.37.sh,
        width: 0.64.sw,
        child: Column(
          children: [
            ...renderKeyboard(),
          ],
        ),
      ),
    );
  }
}

class KeyboardKey extends StatefulWidget {
  final dynamic label;
  final dynamic value;
  final ValueSetter<dynamic> onTap;

  const KeyboardKey({
    Key key,
    @required this.label,
    @required this.value,
    @required this.onTap,
  }) : super(key: key);

  @override
  _KeyboardKeyState createState() => _KeyboardKeyState();
}

class _KeyboardKeyState extends State<KeyboardKey> {
  renderLabel() {
    if (widget.label is Widget) {
      return widget.label;
    }
    return Container(
      height: 0.059.sh,
      //width: 0.168.sw,
      margin: EdgeInsets.only(
        bottom: 0.017.sh,
      ),
      decoration: BoxDecoration(
        //color: UIColors.secondary600,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Center(
        child: Text(
          widget.label,
          textAlign: TextAlign.center,
          style: TypographyStyle.heading4.copyWith(
              color: UIColors.secondary100,
              fontSize: 24.sp,
              fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onTap(widget.value);
      },
      child: Center(
        child: renderLabel(),
      ),
    );
  }
}
