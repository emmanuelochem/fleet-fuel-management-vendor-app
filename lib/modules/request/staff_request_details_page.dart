import 'package:ceuk_user_app/core/design_system/color_shemes.dart';
import 'package:ceuk_user_app/core/design_system/typography_style.dart';
import 'package:ceuk_user_app/core/logics/generalLogics.dart';
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
      backgroundColor: UIColors.secondary600,
      appBar: const GeneralAppBar(title: 'Request Details'),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 0.058.sw, vertical: 0.020.sh),
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
                    : Container(
                        decoration: BoxDecoration(
                            color: UIColors.white,
                            borderRadius: BorderRadius.circular(10.r)),
                        padding: EdgeInsets.symmetric(
                            horizontal: 0.058.sw, vertical: 0.10.sw),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              width: 1.sw,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    width: 0.10.sh,
                                    height: 0.10.sh,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: UIColors.secondary600,
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(widget
                                                        .requestData['type'] ==
                                                    'vehicle'
                                                ? widget.requestData[
                                                        'requestable']
                                                    ['vehicle_image']
                                                : widget.requestData[
                                                    'requestable']['image']))),
                                  ),
                                  SizedBox(
                                    height: 0.013.sw,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        widget.requestData['type'] == 'vehicle'
                                            ? ReCase(widget.requestData[
                                                        'requestable']
                                                    ['driver_name'])
                                                .sentenceCase
                                            : '${ReCase(widget.requestData['requestable']['first_name']).sentenceCase} ${ReCase(widget.requestData['requestable']['last_name']).sentenceCase}',
                                        style: TypographyStyle.heading5
                                            .copyWith(
                                                color: UIColors.secondary200,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 18.sp),
                                      ),
                                      SizedBox(
                                        height: 0.001.sh,
                                      ),
                                      Text(
                                        widget.requestData['type'] == 'errander'
                                            ? 'Messenger'
                                            : 'Vehicle Driver',
                                        style: TypographyStyle.bodySmall
                                            .copyWith(
                                                color: UIColors.secondary200,
                                                fontSize: 12.sp),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 0.026.sh,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: DoctorInfoBlock(
                                        title: 'Amount',
                                        desc: GeneralLogics.formatCurrency(
                                            widget.requestData['amount']
                                                .toString()),
                                        icon: PhosphorIcons.currency_ngn,
                                      ),
                                    ),
                                    Expanded(
                                      child: DoctorInfoBlock(
                                        title: 'Product',
                                        desc:
                                            '${widget.requestData['product']['name']}',
                                        icon: PhosphorIcons.gas_pump,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: DoctorInfoBlock(
                                        title: 'Status',
                                        desc: '${widget.requestData['status']}',
                                        icon: PhosphorIcons.timer,
                                      ),
                                    ),
                                    Expanded(
                                      child: DoctorInfoBlock(
                                        title: 'Reference',
                                        desc:
                                            '${widget.requestData['reference']}',
                                        icon: PhosphorIcons.receipt,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: DoctorInfoBlock(
                                        title: 'Plate Number.',
                                        desc: widget.requestData['type'] ==
                                                'errander'
                                            ? ''
                                            : widget.requestData['requestable']
                                                ['plate_number'],
                                        icon: PhosphorIcons.barcode,
                                      ),
                                    ),
                                    Expanded(
                                      child: DoctorInfoBlock(
                                        title: 'Vehicle Model',
                                        desc: widget.requestData['type'] ==
                                                'errander'
                                            ? ''
                                            : widget.requestData['requestable']
                                                ['model'],
                                        icon: PhosphorIcons.car,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: DoctorInfoBlock(
                                        title: 'Business Name',
                                        desc:
                                            '${widget.requestData['user']['first_name'] + ' ' + widget.requestData['user']['last_name']}',
                                        icon: PhosphorIcons.user,
                                      ),
                                    ),
                                    Expanded(
                                      child: DoctorInfoBlock(
                                        title: 'Business Email',
                                        desc:
                                            '${widget.requestData['user']['email']}',
                                        icon: PhosphorIcons.envelope,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: DoctorInfoBlock(
                                        title: 'Business Contact',
                                        desc:
                                            '${widget.requestData['user']['phone_number']}',
                                        icon: PhosphorIcons.phone,
                                      ),
                                    ),
                                    Expanded(
                                      child: DoctorInfoBlock(
                                        title: widget.requestData['type'] ==
                                                'errander'
                                            ? 'Messenger Contact'
                                            : 'Driver Contact',
                                        desc: widget.requestData['type'] ==
                                                'vehicle'
                                            ? widget.requestData['requestable']
                                                ['driver_phone_number']
                                            : widget.requestData['requestable']
                                                ['phone_number'],
                                        icon: PhosphorIcons.envelope,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: widget.requestData['status'] == 'approved'
                                  ? 0
                                  : 0.026.sh,
                            ),
                            widget.requestData['status'] == 'approved'
                                ? const SizedBox()
                                : ActionButton(
                                    isLoading: _isLoading,
                                    text: 'Confirm Request',
                                    backgroundColor: UIColors.primary,
                                    textColor: UIColors.white,
                                    shape: ButtonShape.squircle,
                                    size: ButtonSizes.medium,
                                    onPressed: () async {
                                      await showMaterialModalBottomSheet(
                                        context: context,
                                        expand: false,
                                        isDismissible: true,
                                        enableDrag: false,
                                        backgroundColor: Colors.transparent,
                                        builder: (context) =>
                                            StaffPumpSalesSnapshot(
                                          requestId: widget.requestData['id']
                                              .toString(),
                                        ),
                                      ).then((value) {
                                        //futureData = getBanks();
                                        // setState(() {});
                                      });
                                    },
                                  ),
                          ],
                        ),
                      );
              }
            }),
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
              // Icon(
              //   icon,
              //   color: UIColors.secondary100,
              //   size: 18.sp,
              // ),
              // SizedBox(
              //   width: 0.020.sh,
              // ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      title,
                      style: TypographyStyle.bodyMediumn.copyWith(
                        color: UIColors.secondary100,
                        fontSize: 14.sp,
                      ),
                    ),
                    SizedBox(
                      height: 0.002.sh,
                    ),
                    Text(
                      (desc == '') ? '---' : desc,
                      softWrap: true,
                      overflow: TextOverflow.visible,
                      style: TypographyStyle.bodySmall.copyWith(
                        color: UIColors.secondary300,
                        fontSize: 12.sp,
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
