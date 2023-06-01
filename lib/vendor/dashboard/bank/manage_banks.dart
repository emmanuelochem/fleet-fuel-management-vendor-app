import 'package:animate_do/animate_do.dart';
import 'package:ceuk_user_app/core/design_system/color_shemes.dart';
import 'package:ceuk_user_app/shared/form/empty_data_notice.dart';
import 'package:ceuk_user_app/vendor/dashboard/bank/banks_action_menu.dart';
import 'package:ceuk_user_app/vendor/dashboard/bank/vendor_banks_list.dart';
import 'package:ceuk_user_app/vendor/dashboard/bank/vendor_banks_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class VendorsManageBanks extends StatefulWidget {
  const VendorsManageBanks({Key key}) : super(key: key);

  @override
  _ManageMessengersState createState() => _ManageMessengersState();
}

class _ManageMessengersState extends State<VendorsManageBanks> {
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
          'Manage Banks',
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        //leadingWidth: 0,
        automaticallyImplyLeading: true,
        bottom: !isLoaded
            ? const PreferredSize(
                preferredSize: Size.zero,
                child: SizedBox(),
              )
            : PreferredSize(
                preferredSize: Size.fromHeight(0.050.sh),
                child: FadeInDown(
                  duration: const Duration(milliseconds: 500),
                  child: Container(
                    height: 0.040.sh,
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 0.010.sh),
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.grey,
                        ),
                        hintText: 'Search banks',
                        hintStyle: const TextStyle(color: Colors.grey),
                        filled: true,
                        fillColor: UIColors.secondary500,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
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
                        icon: PhosphorIcons.bank,
                        message: 'You have not added a bank.',
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
                                  return FadeInRight(
                                      duration: Duration(
                                          milliseconds: (index * 100) + 500),
                                      child: BanksListTile(
                                        name: vendorData[index]['account_name'],
                                        bankName: vendorData[index]
                                            ['bank_name'],
                                        accountNumber: vendorData[index]
                                            ['account_number'],
                                        onClicked: () async {
                                          await showMaterialModalBottomSheet(
                                            context: context,
                                            expand: false,
                                            isDismissible: true,
                                            enableDrag: false,
                                            backgroundColor: Colors.transparent,
                                            builder: (context) =>
                                                GroupsMoreOptionsScreen(
                                              bankData: vendorData[index],
                                            ),
                                          ).then((value) {
                                            futureData = getBanks();
                                            setState(() {});
                                          });
                                        },
                                      ));
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
