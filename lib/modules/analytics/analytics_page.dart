import 'package:ceuk_user_app/core/constants/app_constant.dart';
import 'package:ceuk_user_app/core/design_system/color_shemes.dart';
import 'package:ceuk_user_app/core/logics/generalLogics.dart';
import 'package:ceuk_user_app/modules/analytics/analytics_api.dart';
import 'package:ceuk_user_app/modules/analytics/analytics_bar_chart.dart';
import 'package:ceuk_user_app/modules/analytics/analytics_card.dart';
import 'package:ceuk_user_app/modules/analytics/analytics_filter_button.dart';
import 'package:ceuk_user_app/shared/form/dropdown_model.dart';
import 'package:ceuk_user_app/shared/widgets/general_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AnalyticsPage extends StatefulWidget {
  const AnalyticsPage({Key key}) : super(key: key);

  @override
  _AnalyticsPageState createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage> {
  int activeDay = 3;

  List<DropdownModel> filterList = AppConstant.analyticsFilterOptions;
  @override
  void initState() {
    super.initState();
    timeline = filterList[4].value;
    runFilter(period: timeline);
  }

  String timeline;

  bool _isLoading = true;

  Future runFilter({String period = 'year'}) async {
    setState(() {
      _isLoading = true;
      timeline = period;
      rawPayload = {};
    });

    AnalyticsApi api = AnalyticsApi();
    var res = await api.getAnalytics(
      timeline: timeline,
      context: context,
    );
    if (res != null) {
      if (res['data'] == null) return;
    }
    setState(() {
      rawPayload = res['data'];
      _isLoading = false;
    });
  }

  Map rawPayload = {};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UIColors.secondary600,
      appBar: const GeneralAppBar(
        title: 'Sales Summary',
        leading: true,
      ),
      body: SingleChildScrollView(
        key: UniqueKey(),
        padding: EdgeInsets.only(
          left: 0.058.sw,
          right: 0.058.sw,
          top: 0.020.sh,
          bottom: 0.016.sh,
        ),
        child:
            // _isLoading
            //     ? Center(
            //         child: CupertinoActivityIndicator(
            //           animating: true,
            //           color: UIColors.primary,
            //         ),
            //       )
            //     :
            Column(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 0.02.sh),
              padding: EdgeInsets.all(0.02.sh),
              // height: !showGraph ? null : 0.59.sh,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: UIColors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10.r))),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: AnalyticsFilterButton(
                          data: filterList[0],
                          activeValue: timeline,
                          callback: (response) {
                            runFilter(period: response.value);
                            return;
                          },
                        ),
                      ),
                      SizedBox(width: 0.020.sw),
                      Expanded(
                        child: AnalyticsFilterButton(
                          data: filterList[1],
                          activeValue: timeline,
                          callback: (response) {
                            runFilter(period: response.value);
                            return;
                          },
                        ),
                      ),
                      SizedBox(width: 0.020.sw),
                      Expanded(
                        child: AnalyticsFilterButton(
                          data: filterList[2],
                          activeValue: timeline,
                          callback: (response) {
                            runFilter(period: response.value);
                            return;
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 0.010.sh),
                  Row(
                    children: [
                      Expanded(
                        child: AnalyticsFilterButton(
                          data: filterList[3],
                          activeValue: timeline,
                          callback: (response) {
                            runFilter(period: response.value);
                            return;
                          },
                        ),
                      ),
                      SizedBox(width: 0.020.sw),
                      Expanded(
                        child: AnalyticsFilterButton(
                          data: filterList[4],
                          activeValue: timeline,
                          callback: (response) {
                            runFilter(period: response.value);
                            return;
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            AnalyticsBarChartBlock(
              isLoading: rawPayload.isEmpty,
              payload: rawPayload.isEmpty ? [] : rawPayload['analytics'],
            ),
            GridView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 0.02.sh,
                  crossAxisSpacing: 0.02.sh,
                  mainAxisExtent: 140,
                ),
                children: [
                  AnalyticsCard(
                    isLoading: rawPayload.isEmpty,
                    icon: PhosphorIcons.currency_ngn,
                    isActive: true,
                    name: 'Total Income',
                    value: rawPayload.isEmpty
                        ? ''
                        : GeneralLogics.formatCurrency(
                            rawPayload['metrics']['total_income'].toString(),
                          ),
                  ),
                  AnalyticsCard(
                    isLoading: rawPayload.isEmpty,
                    icon: PhosphorIcons.gas_pump,
                    isActive: false,
                    name: 'Total Sales',
                    value: rawPayload.isEmpty
                        ? ''
                        : rawPayload['metrics']['total_request'].toString(),
                  ),
                ]),
          ],
        ),
      ),
    );
  }
}
