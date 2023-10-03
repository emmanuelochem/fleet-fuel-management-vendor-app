import 'package:ceuk_user_app/core/constants/app_constant.dart';
import 'package:ceuk_user_app/core/design_system/color_shemes.dart';
import 'package:ceuk_user_app/core/design_system/typography_style.dart';
import 'package:ceuk_user_app/core/logics/generalLogics.dart';
import 'package:ceuk_user_app/modules/transaction/staff_transaction_api.dart';
import 'package:ceuk_user_app/modules/transaction/transaction_details.dart';
import 'package:ceuk_user_app/shared/form/empty_data_notice.dart';
import 'package:ceuk_user_app/shared/widgets/general_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class StaffTransactionPage extends StatefulWidget {
  const StaffTransactionPage({Key key}) : super(key: key);

  @override
  _ManageMessengersState createState() => _ManageMessengersState();
}

class _ManageMessengersState extends State<StaffTransactionPage> {
  bool isLoaded = false;

  Future<List> getBanks() async {
    setState(() {
      isLoaded = false;
    });
    StaffTransactionsApi vendorsBankApi = StaffTransactionsApi();
    var res = await vendorsBankApi
        .getTransactions(
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
      appBar: const GeneralAppBar(
        title: 'Transactions',
        leading: false,
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
                                  return Transaction(
                                      transaction: vendorData[index]);
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

class Transaction extends StatelessWidget {
  const Transaction({Key key, this.transaction}) : super(key: key);

  final Map transaction;
  @override
  Widget build(BuildContext context) {
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
              UserTransactionDetailsScreen(history: transaction),
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 0.01.sh),
        padding: EdgeInsets.symmetric(
          horizontal: 0.020.sh,
          vertical: 0.016.sh,
        ),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10.r)),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(0.005.sh),
              height: 0.040.sh,
              width: 0.040.sh,
              decoration: BoxDecoration(
                  color: (transaction['type'] == 'credit' &&
                          transaction['status'] == 'success')
                      ? Colors.green
                      : (transaction['type'] == 'credit' &&
                              transaction['status'] == 'pending')
                          ? Colors.amber
                          : (transaction['type'] == 'debit' &&
                                  transaction['status'] == 'success')
                              ? UIColors.primary300
                              : (transaction['type'] == 'debit' &&
                                      transaction['status'] == 'pending')
                                  ? Colors.amber
                                  : UIColors.primary300,
                  borderRadius: BorderRadius.circular(100)),
              child: Icon(
                (transaction['type'] == 'credit' &&
                        transaction['status'] == 'success')
                    ? PhosphorIcons.arrow_down
                    : (transaction['type'] == 'credit' &&
                            transaction['status'] == 'pending')
                        ? PhosphorIcons.arrow_down
                        : (transaction['type'] == 'debit' &&
                                transaction['status'] == 'success')
                            ? PhosphorIcons.arrow_up
                            : (transaction['type'] == 'debit' &&
                                    transaction['status'] == 'pending')
                                ? PhosphorIcons.arrow_up
                                : PhosphorIcons.x,
                size: 0.027.sh,
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
                      Expanded(
                        child: Text(
                          transaction['type'] == 'credit'
                              ? 'Wallet funding'
                              : transaction['description'],
                          overflow: TextOverflow.ellipsis,
                          style: TypographyStyle.bodySmall.copyWith(
                              fontWeight: FontWeight.bold, fontSize: 13.sp),
                        ),
                      ),
                      Text(
                        GeneralLogics.formatCurrency(
                            transaction['amount'].toString()),
                        style: TypographyStyle.bodySmall.copyWith(
                            fontWeight: FontWeight.bold, fontSize: 12.sp),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        " ${AppConstant.formatDate.format(DateTime.parse(transaction['created_at']))}",
                        style: TypographyStyle.bodySmall.copyWith(
                          color: UIColors.secondary300,
                          fontSize: 11.sp,
                        ),
                      ),
                      Text(
                        (transaction['type'] == 'credit' &&
                                transaction['status'] == 'success')
                            ? 'Credit'
                            : (transaction['type'] == 'credit' &&
                                    transaction['status'] == 'pending')
                                ? 'Pending credit'
                                : (transaction['type'] == 'debit' &&
                                        transaction['status'] == 'success')
                                    ? 'Debit'
                                    : (transaction['type'] == 'debit' &&
                                            transaction['status'] == 'pending')
                                        ? 'Pending debit'
                                        : transaction['type'],
                        style: TypographyStyle.bodySmall.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 11.sp,
                          color: (transaction['type'] == 'credit' &&
                                  transaction['status'] == 'success')
                              ? Colors.green
                              : (transaction['type'] == 'credit' &&
                                      transaction['status'] == 'pending')
                                  ? Colors.amber
                                  : (transaction['type'] == 'debit' &&
                                          transaction['status'] == 'success')
                                      ? UIColors.primary300
                                      : (transaction['type'] == 'debit' &&
                                              transaction['status'] ==
                                                  'pending')
                                          ? Colors.amber
                                          : UIColors.primary300,
                        ),
                      ),
                    ],
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
