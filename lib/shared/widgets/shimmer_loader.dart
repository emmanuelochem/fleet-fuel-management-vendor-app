import 'package:ceuk_user_app/core/design_system/color_shemes.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoader extends StatelessWidget {
  final double width;
  final double height;
  final double marginBottom;
  final ShapeBorder shapeBorder;

  const ShimmerLoader.rectangular(
      {Key key,
      this.width = double.infinity,
      @required this.height,
      this.marginBottom = 0})
      : shapeBorder = const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        super(key: key);

  const ShimmerLoader.circular(
      {Key key,
      this.width = double.infinity,
      this.marginBottom = 0,
      @required this.height,
      this.shapeBorder = const CircleBorder()})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        margin: EdgeInsets.only(bottom: marginBottom ?? 0),
        child: Shimmer.fromColors(
          baseColor: UIColors.secondary500,
          highlightColor: UIColors.secondary600,
          period: const Duration(seconds: 2),
          child: Container(
            width: width,
            height: height,
            decoration: ShapeDecoration(
              color: UIColors.secondary300,
              shape: shapeBorder,
            ),
          ),
        ),
      );
}
