import 'package:ceuk_user_app/core/design_system/color_shemes.dart';
import 'package:ceuk_user_app/core/design_system/typography_style.dart';
import 'package:ceuk_user_app/core/logics/generalLogics.dart';
import 'package:ceuk_user_app/shared/form/action_button.dart';
import 'package:ceuk_user_app/shared/form/notice_dialog.dart';
import 'package:ceuk_user_app/shared/widgets/shimmer_loader.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:numeral/fun.dart';

class AnalyticsBarChartBlock extends StatefulWidget {
  const AnalyticsBarChartBlock({
    this.payload = const [],
    this.isLoading = false,
    Key key,
  }) : super(key: key);
  final bool isLoading;
  final List payload;

  @override
  State<StatefulWidget> createState() => AnalyticsBarChartBlockState();
}

class AnalyticsBarChartBlockState extends State<AnalyticsBarChartBlock> {
  List<BarChartGroupData> showingBarGroups;

  num vertMax = 1;
  List periods = [];
  List values = [];
  num totalSum = 0;

  @override
  void initState() {
    super.initState();

    if ((widget.payload).isNotEmpty) {
      for (final item in widget.payload) {
        periods.add(item['period']);
        values.add(item['total_amount']);
      }
      showingBarGroups = List.generate(
        widget.payload.length,
        (index) => makeGroupData(
          index,
          values[index],
        ),
      );

      vertMax = double.parse([
        values.reduce((curr, next) => curr > next ? curr : next)
      ].reduce((curr, next) => curr > next ? curr : next).toString());

      totalSum = values.reduce((a, b) => a + b);
    }
  }

  bool showGraph = false;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 0.02.sh),
        padding: EdgeInsets.all(0.02.sh),
        // height: !showGraph ? null : 0.59.sh,
        width: double.infinity,
        decoration: BoxDecoration(
            color: UIColors.white,
            borderRadius: BorderRadius.all(Radius.circular(10.r))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                widget.isLoading
                    ? ShimmerLoader.rectangular(
                        width: 0.3.sw,
                        height: 0.014.sh,
                        marginBottom: 0.01.sh,
                      )
                    : Text(
                        'Sales Overview',
                        style: TypographyStyle.bodyLarge.copyWith(
                            fontSize: 14.sp,
                            height: 1.5,
                            color: UIColors.secondary100,
                            fontWeight: FontWeight.w600),
                      ),
                widget.isLoading
                    ? ShimmerLoader.rectangular(
                        width: 0.5.sw,
                        height: 0.009.sh,
                      )
                    : Text(
                        'Your sales breakdown.',
                        style: TypographyStyle.bodySmall.copyWith(
                            fontSize: 10.sp,
                            height: 1.5,
                            color: UIColors.secondary200),
                      ),
              ],
            ),
            SizedBox(height: 0.015.sh),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        widget.isLoading
                            ? ShimmerLoader.rectangular(
                                width: 0.3.sw,
                                height: 0.009.sh,
                                marginBottom: 0.01.sh,
                              )
                            : Text(
                                'Total Sales Sum',
                                style: TypographyStyle.bodySmall.copyWith(
                                    fontSize: 11.sp,
                                    height: 1.5,
                                    color: UIColors.secondary200),
                              ),
                        widget.isLoading
                            ? ShimmerLoader.rectangular(
                                width: 0.2.sw,
                                height: 0.014.sh,
                                marginBottom: 0.01.sh,
                              )
                            : Text(
                                GeneralLogics.formatCurrency(
                                  totalSum.toString(),
                                ),
                                style: TypographyStyle.bodyLarge.copyWith(
                                  fontSize: 15.sp,
                                  height: 1.5,
                                  color: UIColors.secondary100,
                                  fontWeight: FontWeight.w600,
                                ),
                              )
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (widget.isLoading) return;
                        setState(() {
                          showGraph = !showGraph;
                        });
                      },
                      child: widget.isLoading
                          ? ShimmerLoader.rectangular(
                              width: 0.1.sh,
                              height: 0.012.sh,
                            )
                          : Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  PhosphorIcons.chart_bar,
                                  size: 14,
                                  color: UIColors.primary100,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  '${!showGraph ? 'Show' : 'Hide'} graph',
                                  style: TypographyStyle.captionMedium
                                      .copyWith(color: UIColors.primary100),
                                )
                              ],
                            ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (widget.isLoading) return;
                        showDialog<void>(
                          context: context,
                          barrierDismissible: false, // user must tap button!
                          builder: (BuildContext context) {
                            return ImportantNoticeDialog(
                              title: 'Sales Summary',
                              message:
                                  'This is your earnings breakdown aver a specified period.',
                              buttonText: 'I Understand',
                              buttonAction: () {
                                Navigator.pop(context);
                              },
                              buttonShape: ButtonShape.squircle,
                              buttonSize: ButtonSizes.large,
                              buttonBackgroundColor: UIColors.primary,
                              buttonTextColor: UIColors.white,
                              dialogBackground: UIColors.white,
                            );
                          },
                        );
                      },
                      child: widget.isLoading
                          ? ShimmerLoader.rectangular(
                              width: 0.1.sh,
                              height: 0.012.sh,
                            )
                          : Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  PhosphorIcons.question,
                                  size: 14,
                                  color: UIColors.primary100,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  'What is this?',
                                  style: TypographyStyle.captionMedium
                                      .copyWith(color: UIColors.primary100),
                                )
                              ],
                            ),
                    )
                  ],
                ),
                SizedBox(
                  height: !showGraph ? 0 : 0.035.sh,
                ),
                !showGraph
                    ? const SizedBox()
                    : widget.payload.isEmpty
                        ? Center(
                            child: Column(
                              children: [
                                Icon(
                                  PhosphorIcons.chart_bar,
                                  size: 0.20.sw,
                                  color: UIColors.secondary400,
                                ),
                                Text(
                                  'You have not made any sales.',
                                  textAlign: TextAlign.center,
                                  style: TypographyStyle.bodyMediumn.copyWith(
                                    fontSize: 12.sp,
                                    color: UIColors.secondary300,
                                  ),
                                )
                              ],
                            ),
                          )
                        : SizedBox(
                            height: 0.30.sh,
                            child: BarChart(
                              BarChartData(
                                maxY: vertMax,
                                minY: 0,
                                //baselineY: 20,
                                titlesData: FlTitlesData(
                                  show: true,
                                  rightTitles: AxisTitles(
                                    sideTitles: SideTitles(showTitles: false),
                                  ),
                                  topTitles: AxisTitles(
                                    sideTitles: SideTitles(showTitles: false),
                                  ),
                                  bottomTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                      showTitles: true,
                                      getTitlesWidget: bottomTitles,
                                    ),
                                  ),
                                  leftTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                      showTitles: false,
                                      reservedSize: 10,
                                      getTitlesWidget: leftTitles,
                                    ),
                                  ),
                                ),

                                borderData: FlBorderData(
                                  show: true,
                                  border: Border.all(
                                      color: UIColors.secondary400, width: 0.5),
                                ),
                                barGroups: showingBarGroups,
                                gridData: FlGridData(show: true),
                              ),
                            ),
                          ),
              ],
            ),
          ],
        ));
  }

  Widget leftTitles(double value, TitleMeta meta) {
    TextStyle style = TextStyle(
      // fontFamily: 'Cairo',
      fontSize: 8.sp,
    );
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 0,
      child: Text(numeral(value, fractionDigits: 2), style: style),
    );
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    final titles = periods;

    final Widget text = Text(
      titles[value.toInt()],
      style: TextStyle(
        // fontFamily: 'Cairo',
        fontSize: 8.sp,
      ),
    );

    return SideTitleWidget(
      axisSide: meta.axisSide,
      // space: 0.019.sh,
      angle: 200,
      child: text,
    );
  }

  BarChartGroupData makeGroupData(
    dynamic x,
    dynamic y1,
  ) {
    return BarChartGroupData(
      //groupVertically: true,
      barsSpace: 0,
      x: int.parse(x.toString()),
      barRods: [
        BarChartRodData(
          toY: double.parse(y1.toString()),
          color: UIColors.primary,
          width: 11,
          borderRadius: BorderRadius.circular(0),
        ),
      ],
    );
  }
}
