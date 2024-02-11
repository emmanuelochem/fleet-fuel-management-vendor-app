import 'package:ceuk_user_app/core/constants/app_constant.dart';
import 'package:ceuk_user_app/core/design_system/color_shemes.dart';
import 'package:ceuk_user_app/core/design_system/typography_style.dart';
import 'package:ceuk_user_app/core/logics/generalLogics.dart';
import 'package:ceuk_user_app/core/providers/vstaff_data_provider.dart';
import 'package:ceuk_user_app/modules/analytics/analytics_page.dart';
import 'package:ceuk_user_app/modules/history/bank_lookup.dart';
import 'package:ceuk_user_app/modules/history/request_api.dart';
import 'package:ceuk_user_app/modules/history/request_history.dart';
import 'package:ceuk_user_app/modules/home/menu_cube_button.dart';
import 'package:ceuk_user_app/modules/profile/staff_support_page.dart';
import 'package:ceuk_user_app/shared/form/optionsDialog.dart';
import 'package:ceuk_user_app/staffs_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

class StaffHomePage extends StatefulWidget {
  const StaffHomePage({Key key}) : super(key: key);

  @override
  _VendorHomeState createState() => _VendorHomeState();
}

class _VendorHomeState extends State<StaffHomePage> {
  StaffDataProvider staffDataProvider;

  @override
  didChangeDependencies() {
    super.didChangeDependencies();
    staffDataProvider = context.read<StaffDataProvider>();
  }

  Future<List> futureData;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureData = requests();
  }

  Future<List> requests() async {
    RequestApi requestApi = RequestApi();
    var res = await requestApi
        .getRequests(
      context: context,
      status: 'pending',
    )
        .then((value) {
      if (value != null) {
        return value['data'];
      } else {
        return null;
      }
    });

    return res;

    // return [
    //   {
    //     "id": 1034,
    //     "user_id": 3,
    //     "vendor_id": null,
    //     "vendor_staff_id": null,
    //     "requestable_type": "App\\Models\\Errander",
    //     "requestable_id": 5,
    //     "amount": 1000,
    //     "code": "78LJJD",
    //     "description": "This is a description",
    //     "status": "pending",
    //     "metre_picture": null,
    //     "created_at": "2024-01-29T05:48:04.000000Z",
    //     "updated_at": "2024-01-29T05:48:04.000000Z",
    //     "product_type_id": 1,
    //     "type": "errander"
    //   }

    // ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        centerTitle: false,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Row(
            children: [
              Container(
                width: 0.045.sh,
                height: 0.045.sh,
                margin: EdgeInsets.only(right: 0.038.sw),
                decoration: BoxDecoration(
                    color: UIColors.secondary600,
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(staffDataProvider.user['image']),
                    )),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Good Evening',
                    style: TypographyStyle.bodySmall.copyWith(fontSize: 13.sp),
                  ),
                  Text(
                    staffDataProvider.user['first_name'] +
                        ' ' +
                        staffDataProvider.user['last_name'],
                    style: TypographyStyle.bodySmall.copyWith(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                      height: 1.2,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        leadingWidth: 0.5.sw,
        actions: [
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  showMaterialModalBottomSheet(
                    context: context,
                    expand: false,
                    isDismissible: false,
                    enableDrag: false,
                    //elevation: 10,
                    backgroundColor: Colors.transparent,
                    builder: (context) => SupportPage(),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.only(right: 10),
                  height: 0.045.sh,
                  width: 0.045.sh,
                  child: Icon(
                    PhosphorIcons.headset,
                    size: 0.025.sh,
                    color: UIColors.secondary200,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  OptionsDialog.messageDialog(context, 'Logout',
                      'Are you sure you want to log out of your account?', () {
                    Navigator.pop(context);
                    GeneralLogics.removeUserData().then((value) {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          StaffsRoutes.login, (Route<dynamic> route) => false);
                    });
                  });
                },
                child: Container(
                  margin: const EdgeInsets.only(right: 20),
                  height: 0.045.sh,
                  width: 0.045.sh,
                  decoration: BoxDecoration(
                      color: UIColors.secondary600, shape: BoxShape.circle),
                  child: Icon(
                    PhosphorIcons.sign_out,
                    size: 0.027.sh,
                    color: UIColors.primary,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
      backgroundColor: UIColors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(0.038.sw),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20.r))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 1.sw,
                    height: 0.17.sh,
                    padding: EdgeInsets.all(0.038.sw),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20.r)),
                      color: UIColors.primary // Color(0xfff1f3f6)
                      ,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Balance",
                          style: TypographyStyle.bodySmall
                              .copyWith(fontSize: 14.sp, color: UIColors.white),
                        ),
                        Text(
                          GeneralLogics.formatCurrency(staffDataProvider
                              .user['wallet']['available_balance']
                              .toString()),
                          style: TypographyStyle.bodyLarge.copyWith(
                              fontSize: 25.sp,
                              fontWeight: FontWeight.w700,
                              color: UIColors.white),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 0.038.sw),
                    child: Row(
                      children: [
                        Expanded(
                            child: HomeCubeButton(
                                title: 'History',
                                icon: PhosphorIcons.currency_ngn,
                                bgColor: UIColors.primary600,
                                textColor: UIColors.secondary,
                                child: const RequestHistory())),
                        SizedBox(width: 0.04.sw),
                        Expanded(
                            child: HomeCubeButton(
                          title: 'Summary',
                          icon: PhosphorIcons.chart_bar,
                          bgColor: UIColors.primary600,
                          textColor: UIColors.secondary,
                          child: const AnalyticsPage(),
                        )),
                        // SizedBox(width: 0.04.sw),
                        // HomeCubeButton(
                        //   icon: PhosphorIcons.headset,
                        //   bgColor: UIColors.secondary600,
                        //   textColor: UIColors.secondary,
                        //   child: const VendorStaffAccount(),
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 1.sw,
              padding: EdgeInsets.symmetric(horizontal: 0.058.sw),
              decoration: BoxDecoration(
                color: UIColors.white,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Pending Requests',
                        style: TypographyStyle.bodyMediumn.copyWith(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Container(
                        // padding: EdgeInsets.symmetric(
                        //   horizontal: 0.03.sw,
                        //   vertical: 0.002.sh,
                        // ),
                        // decoration: BoxDecoration(
                        //   color: UIColors.secondary600,
                        //   borderRadius: BorderRadius.circular(10.r),
                        // ),
                        child: Text(
                          'View All',
                          style: TypographyStyle.bodyMediumn.copyWith(
                            fontSize: 12.sp,
                            color: UIColors.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  FutureBuilder<List>(
                    future: futureData,
                    builder:
                        (BuildContext context, AsyncSnapshot<List> snapshot) {
                      if (snapshot.hasData) {
                        final data = snapshot.data;
                        return ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                showMaterialModalBottomSheet(
                                  context: context,
                                  expand: false,
                                  isDismissible: false,
                                  enableDrag: false,
                                  //elevation: 10,
                                  backgroundColor: Colors.transparent,
                                  builder: (context) =>
                                      BankLookUp(request: data[index]),
                                );
                              },
                              child: Container(
                                width: 1.sw,
                                margin: EdgeInsets.only(bottom: 0.01.sh),
                                padding: EdgeInsets.symmetric(
                                  vertical: 0.016.sh,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.all(0.0.sh),
                                      height: 0.045.sh,
                                      width: 0.045.sh,
                                      decoration: BoxDecoration(
                                        color: UIColors.secondary400,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        PhosphorIcons.arrow_down_left,
                                        size: 0.027.sh,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 0.02.sw,
                                    ),
                                    Expanded(
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  data[index]['product']
                                                          ['name'] +
                                                      ' Purchase',
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TypographyStyle
                                                      .bodySmall
                                                      .copyWith(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 13.sp),
                                                ),
                                                SizedBox(
                                                  height: 0.001.sh,
                                                ),
                                                Text(
                                                  '${AppConstant.formatDate.format(DateTime.parse(data[index]['created_at']))} -  ${AppConstant.formatTime.format(DateTime.parse(data[index]['created_at']))}',
                                                  style: TypographyStyle
                                                      .bodySmall
                                                      .copyWith(
                                                    color:
                                                        UIColors.secondary300,
                                                    fontSize: 11.sp,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Text(
                                            GeneralLogics.formatCurrency(
                                                data[index]['amount']
                                                    .toString()),
                                            style: TypographyStyle.bodySmall
                                                .copyWith(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14.sp),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      } else if (snapshot.hasError) {
                        return Text('Error fetching data: ${snapshot.error}');
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
