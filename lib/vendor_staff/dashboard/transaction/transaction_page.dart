import 'package:ceuk_user_app/core/design_system/color_shemes.dart';
import 'package:ceuk_user_app/core/design_system/typography_style.dart';
import 'package:ceuk_user_app/shared/form/empty_data_notice.dart';
import 'package:ceuk_user_app/vendor/dashboard/bank/vendor_banks_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VendorsTransactionPage extends StatefulWidget {
  const VendorsTransactionPage({Key key}) : super(key: key);

  @override
  _ManageMessengersState createState() => _ManageMessengersState();
}

class _ManageMessengersState extends State<VendorsTransactionPage> {
  bool isLoaded = false;

  Future<List> getBanks() async {
    setState(() {
      isLoaded = false;
    });
    VendorsBankApi vendorsBankApi = VendorsBankApi();
    var res = await vendorsBankApi
        .getBanks(
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
          'Transactions',
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
                        icon: PhosphorIcons.list_checks,
                        message: 'You have not performed any transaction.',
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
                                  return const Transaction(
                                    receptient: "Adegoke Johnson",
                                    transactionAmout: "5000.00",
                                    transactionDate: "26 Jun 2019",
                                    transactionInfo: "Errander",
                                    transactionType: TransactionType.sent,
                                  );
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

enum TransactionType { sent, received, pending }

class Transaction extends StatelessWidget {
  final TransactionType transactionType;
  final String transactionAmout, transactionInfo, transactionDate, receptient;
  const Transaction(
      {Key key,
      this.transactionType,
      this.transactionAmout,
      this.transactionInfo,
      this.transactionDate,
      this.receptient})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    String transactionName;
    IconData transactionIconData;
    Color color;
    switch (transactionType) {
      case TransactionType.sent:
        transactionName = "Sent";
        transactionIconData = PhosphorIcons.arrow_up;
        color = UIColors.primary300;
        break;
      case TransactionType.received:
        transactionName = "Received";
        transactionIconData = PhosphorIcons.arrow_down;
        color = Colors.green;
        break;
      case TransactionType.pending:
        transactionName = "Pending";
        transactionIconData = PhosphorIcons.pause_thin;
        color = UIColors.secondary300;
        break;
    }
    return Container(
      margin: EdgeInsets.only(bottom: 0.01.sh),
      padding: EdgeInsets.symmetric(horizontal: 0.020.sh, vertical: 0.016.sh),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10.r)),
      child: Row(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: color, borderRadius: BorderRadius.circular(100)),
            child: Icon(
              transactionIconData,
              size: 0.033.sh,
              color: Colors.white,
            ),
          ),
          SizedBox(width: 0.034.sw),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      receptient,
                      style: TypographyStyle.bodySmall.copyWith(
                          fontWeight: FontWeight.bold, fontSize: 14.sp),
                    ),
                    Text(
                      "NGN $transactionAmout",
                      style: TypographyStyle.bodySmall.copyWith(
                          fontWeight: FontWeight.bold, fontSize: 13.sp),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "$transactionInfo - $transactionDate",
                      style: TypographyStyle.bodySmall.copyWith(
                          color: UIColors.secondary300, fontSize: 12.sp),
                    ),
                    Text(
                      transactionName,
                      style: TypographyStyle.bodySmall.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 12.sp,
                        color: color,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
