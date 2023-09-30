import 'package:ceuk_user_app/core/design_system/color_shemes.dart';
import 'package:ceuk_user_app/core/design_system/typography_style.dart';
import 'package:ceuk_user_app/modules/request/staff_pump_snapshot.dart';
import 'package:ceuk_user_app/shared/form/action_button.dart';
import 'package:ceuk_user_app/shared/form/empty_data_notice.dart';
import 'package:ceuk_user_app/shared/widgets/general_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconly/iconly.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:recase/recase.dart';

class RequestDetailsPage extends StatefulWidget {
  const RequestDetailsPage({Key key, @required this.requestData})
      : super(key: key);
  final Map<String, dynamic> requestData;

  @override
  _RequestDetailsPageState createState() => _RequestDetailsPageState();
}

class _RequestDetailsPageState extends State<RequestDetailsPage> {
  final bool _isLoading = false;
  bool isLoaded = false;
  Map appointmentMapData;
  Future<Map> getAppointment() async {
    setState(() {
      isLoaded = false;
    });
    // AppointmentApi appointmentApi = AppointmentApi();
    // var res = await appointmentApi
    //     .getAppointmentById(
    //         context: context, appointmentId: widget.appointmentId)
    //     .then((value) {
    //   if (value != null) {
    //     setState(() {
    //       isLoaded = true;
    //       appointmentMapData = value['data'];
    //     });
    //     return value['data'];
    //   } else {
    //     return null;
    //   }
    // });
    // return res;
  }

  Future<Map> futureData;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //futureData = getAppointment();
  }

  @override
  Widget build(BuildContext context) {
    DateFormat formatDate = DateFormat('yMMMMd');
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const GeneralAppBar(title: 'Request Summary'),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 0.058.sw, vertical: 0.10.sw),
        child: FutureBuilder(
            future: futureData,
            builder: (context, querySnapshot) {
              if (querySnapshot.hasError) {
                return const Text('Error occured');
              }
              if (querySnapshot.connectionState == ConnectionState.waiting) {
                return SizedBox(
                  height: 0.7.sh,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: UIColors.primary,
                    ),
                  ),
                );
              } else {
                Map appointmentData = querySnapshot.data ?? {};
                // print(list[0]['summary']);
                return appointmentData.isNotEmpty
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          EmptyDataNotice(
                            icon: IconlyLight.close_square,
                            message:
                                'Request Information not available at the moment.',
                          ),
                        ],
                      )
                    : SizedBox(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Profile",
                                  style: TypographyStyle.heading5
                                      .copyWith(fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  height: 0.02.sh,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      height: 0.15.sh,
                                      width: 0.15.sh,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                              widget.requestData['requestable']
                                                  ['image']),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 0.042.sw,
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            '${ReCase(widget.requestData['requestable']['first_name']).sentenceCase} ${ReCase(widget.requestData['requestable']['last_name']).sentenceCase}',
                                            style: TypographyStyle.heading5
                                                .copyWith(
                                                    color:
                                                        UIColors.secondary200,
                                                    fontWeight:
                                                        FontWeight.w600),
                                          ),
                                          SizedBox(
                                            height: 0.005.sh,
                                          ),
                                          Text(
                                            widget.requestData['requestable']
                                                ['email'],
                                            style: TypographyStyle.bodySmall
                                                .copyWith(
                                                    color:
                                                        UIColors.secondary200,
                                                    fontWeight:
                                                        FontWeight.w500),
                                          ),
                                          SizedBox(
                                            height: 0.005.sh,
                                          ),
                                          Text(
                                            widget.requestData['requestable']
                                                ['phone_number'],
                                            style: TypographyStyle.bodySmall
                                                .copyWith(
                                                    color:
                                                        UIColors.secondary200,
                                                    fontWeight:
                                                        FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 26,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Request Information",
                                  style: TypographyStyle.heading5
                                      .copyWith(fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  height: 0.02.sh,
                                ),
                                DoctorInfoBlock(
                                  title: 'Amount No.',
                                  desc: "NGN ${widget.requestData['amount']}",
                                  icon: PhosphorIcons.currency_ngn,
                                ),
                                DoctorInfoBlock(
                                  title: 'Product',
                                  desc:
                                      '${widget.requestData['product']['name']}',
                                  icon: PhosphorIcons.gas_pump,
                                ),
                                DoctorInfoBlock(
                                  title: 'Status',
                                  desc: '${widget.requestData['status']}',
                                  icon: PhosphorIcons.timer,
                                ),
                                DoctorInfoBlock(
                                  title: 'Reference',
                                  desc: '${widget.requestData['reference']}',
                                  icon: PhosphorIcons.receipt,
                                ),
                              ],
                            ),
                            // widget.requestData['type'] == 'errander'
                            //     ? const SizedBox()
                            //     : Column(
                            //         crossAxisAlignment:
                            //             CrossAxisAlignment.start,
                            //         children: [
                            //           SizedBox(
                            //             height: 0.03.sh,
                            //           ),
                            //           Text(
                            //             "Vehicle Information",
                            //             style: TypographyStyle.heading5
                            //                 .copyWith(
                            //                     fontWeight: FontWeight.w600),
                            //           ),
                            //           SizedBox(
                            //             height: 0.02.sh,
                            //           ),
                            //           const DoctorInfoBlock(
                            //             title: 'Plate No.',
                            //             desc: 'ABJ-683-BRW',
                            //             icon: PhosphorIcons.barcode,
                            //           ),
                            //           const DoctorInfoBlock(
                            //             title: 'Brand & Name',
                            //             desc: 'Benz - C300',
                            //             icon: PhosphorIcons.car,
                            //           ),
                            //         ],
                            //       ),

                            SizedBox(
                              height: 0.03.sh,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Company Information",
                                  style: TypographyStyle.heading5
                                      .copyWith(fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  height: 0.02.sh,
                                ),
                                DoctorInfoBlock(
                                  title: 'Name',
                                  desc:
                                      '${widget.requestData['user']['first_name'] + ' ' + widget.requestData['user']['last_name']}',
                                  icon: PhosphorIcons.user,
                                ),
                                DoctorInfoBlock(
                                  title: 'Email',
                                  desc:
                                      '${widget.requestData['user']['email']}',
                                  icon: PhosphorIcons.envelope,
                                ),
                                DoctorInfoBlock(
                                  title: 'Phone',
                                  desc:
                                      '${widget.requestData['user']['phone_number']}',
                                  icon: PhosphorIcons.phone,
                                ),
                                // const DoctorInfoBlock(
                                //   title: 'Office Address',
                                //   desc: 'Plot 660a, 24 RD, Gwagwalada',
                                //   icon: PhosphorIcons.map_pin,
                                // ),

                                SizedBox(
                                  height: 0.1.sh,
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
              }
            }),
      ),
      bottomSheet: isLoaded
          ? const SizedBox()
          : Container(
              //height: 0.1.sh,
              decoration: BoxDecoration(
                  color: UIColors.white,
                  border: Border(
                    top: BorderSide(color: UIColors.secondary500),
                  )),
              padding: EdgeInsets.symmetric(
                  horizontal: 0.048.sw, vertical: 0.028.sw),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ActionButton(
                    isLoading: _isLoading,
                    text: 'Confirm Request',
                    backgroundColor: UIColors.primary,
                    textColor: UIColors.white,
                    shape: ButtonShape.capsule,
                    size: ButtonSizes.large,
                    onPressed: () async {
                      await showMaterialModalBottomSheet(
                        context: context,
                        expand: false,
                        isDismissible: true,
                        enableDrag: false,
                        backgroundColor: Colors.transparent,
                        builder: (context) => StaffPumpSalesSnapshot(
                          requestId: widget.requestData['id'].toString(),
                        ),
                      ).then((value) {
                        //futureData = getBanks();
                        // setState(() {});
                      });
                    },
                  ),
                ],
              ),
            ),
    );
  }
}

class DoctorInfoBlock extends StatelessWidget {
  const DoctorInfoBlock({
    Key key,
    @required this.title,
    @required this.desc,
    @required this.icon,
  }) : super(key: key);

  final String title;
  final String desc;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: 0.02.sh,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Icon(
                icon,
                color: UIColors.secondary100,
              ),
              SizedBox(
                width: 0.020.sh,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      title,
                      style: TypographyStyle.bodyMediumn.copyWith(
                        color: UIColors.secondary100,
                        fontSize: 16.sp,
                      ),
                    ),
                    SizedBox(
                      height: 0.003.sh,
                    ),
                    Text(
                      (desc == '') ? '---' : desc,
                      softWrap: true,
                      overflow: TextOverflow.visible,
                      style: TypographyStyle.bodySmall.copyWith(
                        color: UIColors.secondary300,
                        fontSize: 14.sp,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
