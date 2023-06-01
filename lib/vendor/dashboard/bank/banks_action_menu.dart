import 'dart:ui';

import 'package:ceuk_user_app/core/design_system/color_shemes.dart';
import 'package:ceuk_user_app/core/design_system/typography_style.dart';
import 'package:ceuk_user_app/core/logics/generalLogics.dart';
import 'package:ceuk_user_app/vendor/dashboard/bank/actionable_option_list_tile.dart';
import 'package:ceuk_user_app/vendor/dashboard/bank/vendor_banks_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GroupsMoreOptionsScreen extends StatefulWidget {
  final Map bankData;
  const GroupsMoreOptionsScreen({Key key, this.bankData}) : super(key: key);

  @override
  State<GroupsMoreOptionsScreen> createState() =>
      _GroupsMoreOptionsScreenState();
}

class _GroupsMoreOptionsScreenState extends State<GroupsMoreOptionsScreen> {
  bool _isLoading = false;
  // VendorDataProvider vendorDataProvider;
  // @override
  // didChangeDependencies() {
  //   super.didChangeDependencies();
  //   vendorDataProvider = Provider.of<VendorDataProvider>(context);
  // }

  Future deletePayment({int id}) async {
    Navigator.pop(
      context,
    );
    setState(() {
      _isLoading = true;
    });
    VendorsBankApi vendorsBankApi = VendorsBankApi();
    var res = await vendorsBankApi.deleteBank(
      id: id,
      context: context,
    );
    if (res != null) {
      // GeneralLogics.setUserDataProvider(userDataProvider, res['user_data']);
      if (context.mounted) {
        Navigator.pop(context);
      }
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => !_isLoading,
      child: ClipRect(
        clipBehavior: Clip.hardEdge,
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 5,
            sigmaY: 5,
          ),
          child: SizedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 0.6.sh),
                _isLoading
                    ? const SizedBox()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 23, vertical: 0.015.sh),
                              child: Text('Close',
                                  textAlign: TextAlign.end,
                                  style: TypographyStyle.bodyMediumn
                                      .copyWith(color: UIColors.white)),
                            ),
                          ),
                        ],
                      ),
                Container(
                  height: 0.25.sh,
                  decoration: BoxDecoration(
                      color: UIColors.secondary600,
                      borderRadius: BorderRadiusDirectional.only(
                          topStart: Radius.circular(30.r),
                          topEnd: Radius.circular(30.r))),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 0.058.sw,
                      vertical: 0.040.sh,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Bank Actions',
                          style: TypographyStyle.bodyMediumn.copyWith(
                            fontFamily: 'FacebookSans',
                            //fontSize: fontSize,
                            color: UIColors.secondary300,
                          ),
                        ),
                        SizedBox(
                          height: 0.019.sh,
                        ),
                        Stack(
                          children: [
                            SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // GestureDetector(
                                  //   onTap: () {
                                  //     Navigator.pushNamed(
                                  //         context, VendorRoutes.updateBank,
                                  //         arguments: <String, dynamic>{
                                  //           'vendorData': widget.bankData
                                  //         }).then(
                                  //         (value) => Navigator.pop(context));
                                  //   },
                                  //   child: ActionableOptionListTile(
                                  //     title: 'Edit Bank',
                                  //     backgroundColor: UIColors.white,
                                  //     fontSize: 16.sp,
                                  //     iconBackgroundColor: const Color.fromARGB(
                                  //         255, 145, 167, 239),
                                  //     iconData: PhosphorIcons.pen,
                                  //   ),
                                  // ),
                                  GestureDetector(
                                    onTap: () async {
                                      await GeneralLogics.showNotice(
                                          context: context,
                                          canDismiss: true,
                                          heading: 'Delete Bank',
                                          msg:
                                              'Are you sure you want to delete this bank?',
                                          type: 'error',
                                          onContinueText: 'Yes, delete',
                                          onContinue: () async {
                                            await deletePayment(
                                                id: widget.bankData['id']);
                                          },
                                          onCancelText: 'No, cancel',
                                          onCancel: () {
                                            Navigator.pop(
                                              context,
                                            );
                                          });
                                    },
                                    child: ActionableOptionListTile(
                                      title: 'Delete Bank',
                                      backgroundColor: UIColors.white,
                                      fontSize: 16.sp,
                                      iconBackgroundColor: UIColors.primary500,
                                      iconData: PhosphorIcons.trash,
                                      iconColor: UIColors.primary100,
                                      titleColor: UIColors.primary100,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            // _isLoading
                            //     ? Center(
                            //         child: Container(
                            //         width: double.infinity,
                            //         color: UIColors.secondary600,
                            //         height: 0.3.sh,
                            //         child: const CupertinoActivityIndicator(),
                            //       ))
                            //     : const SizedBox(),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
