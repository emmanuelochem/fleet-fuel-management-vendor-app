import 'package:ceuk_user_app/core/design_system/color_shemes.dart';
import 'package:ceuk_user_app/core/design_system/typography_style.dart';
import 'package:ceuk_user_app/shared/form/empty_data_notice.dart';
import 'package:ceuk_user_app/vendor/dashboard/staff/vendor_staffs_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VendorsStaffsPage extends StatefulWidget {
  const VendorsStaffsPage({Key key}) : super(key: key);

  @override
  _VendorStaffPageState createState() => _VendorStaffPageState();
}

class _VendorStaffPageState extends State<VendorsStaffsPage> {
  bool isLoaded = false;

  Future<List> getBanks() async {
    setState(() {
      isLoaded = false;
    });
    VendorStaffsApi vendorStaffsApi = VendorStaffsApi();
    var res = await vendorStaffsApi
        .getStaff(
      context: context,
    )
        .then((value) {
      if (value != null) {
        setState(() {
          if (value['data'].isNotEmpty) {
            isLoaded = true;
          }
        });
        return value['data'];
      } else {
        return null;
      }
    });
    return res;
  }

  Future<List> futureData;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureData = getBanks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UIColors.secondary600,
      appBar: AppBar(
        backgroundColor: UIColors.white,
        elevation: 0,
        centerTitle: false,
        title: const Text(
          'Staffs',
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<List>(
            future: futureData,
            builder: (BuildContext context, AsyncSnapshot<List> querySnapshot) {
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
                final vendorData = querySnapshot.data ?? [];
                // print(list[0]['summary']);
                return vendorData.isEmpty
                    ? const EmptyDataNotice(
                        icon: PhosphorIcons.users_three,
                        message: 'You have not added any of your staffs.',
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                            SizedBox(
                              height: 0.016.sh,
                            ),
                            Container(
                              height: 1.sh,
                              padding:
                                  EdgeInsets.symmetric(horizontal: 0.058.sw),
                              child: ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                itemCount: vendorData.length,
                                itemBuilder: (context, index) {
                                  return PayeeContainer(
                                      staff: vendorData[index]);
                                },
                              ),
                            ),
                          ]);
              }
            }),
      ),
    );
  }
}

class PayeeContainer extends StatelessWidget {
  const PayeeContainer({Key key, this.staff}) : super(key: key);
  final Map staff;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 0.01.sh),
      padding: EdgeInsets.symmetric(horizontal: 0.020.sh, vertical: 0.016.sh),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10.r)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: UIColors.secondary300,
              shape: BoxShape.circle,
              //borderRadius: BorderRadius.circular(10.r),
              image: const DecorationImage(
                image: NetworkImage(
                    'https://cdn.pixabay.com/photo/2017/11/02/14/26/model-2911329_960_720.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            width: 0.016.sh,
          ),
          Flexible(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '${staff['first_name']} ${staff['last_name']}',
                    style: TypographyStyle.bodySmall
                        .copyWith(fontWeight: FontWeight.bold, fontSize: 14.sp),
                  ),
                  Text(
                    staff['phone_number'],
                    style: TypographyStyle.bodySmall.copyWith(
                      color: UIColors.secondary300,
                      fontSize: 12.sp,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
