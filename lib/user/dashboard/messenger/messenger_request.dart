import 'package:animate_do/animate_do.dart';
import 'package:ceuk_user_app/core/design_system/color_shemes.dart';
import 'package:ceuk_user_app/core/design_system/typography_style.dart';
import 'package:ceuk_user_app/shared/form/empty_data_notice.dart';
import 'package:ceuk_user_app/user/dashboard/messenger/messenger_api.dart';
import 'package:ceuk_user_app/user/dashboard/request/messenger_submit_request_page.dart';

import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

class MessengerRequest extends StatefulWidget {
  const MessengerRequest({Key key}) : super(key: key);

  @override
  _MessengerRequestState createState() => _MessengerRequestState();
}

class _MessengerRequestState extends State<MessengerRequest> {
  bool isLoaded = false;

  Future<List> getVehicles() async {
    MessengerApi messengerApi = MessengerApi();
    var res = await messengerApi
        .getMessengers(
      context: context,
    )
        .then((value) {
      if (value != null) {
        setState(() {
          isLoaded = true;
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
    futureData = getVehicles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        title: Text(
          'Messengers',
          style: TypographyStyle.heading5
              .copyWith(fontWeight: FontWeight.w500, color: UIColors.secondary),
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
                preferredSize: const Size.fromHeight(50),
                child: FadeInDown(
                  duration: const Duration(milliseconds: 500),
                  child: Container(
                    height: 40,
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 10),
                        prefixIcon: Icon(
                          Icons.search,
                          color: UIColors.secondary300,
                        ),
                        hintText: 'Search vehicles',
                        hintStyle: TextStyle(color: UIColors.secondary300),
                        filled: true,
                        fillColor: UIColors.secondary600,
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
                final vehicleData = querySnapshot.data ?? [];
                // print(list[0]['summary']);
                return vehicleData.isEmpty
                    ? const EmptyDataNotice(
                        icon: PhosphorIcons.person,
                        message: 'Messengers not available at the moment.',
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                            SizedBox(
                              height: 0.03.sh,
                            ),
                            FadeInRight(
                              duration: const Duration(milliseconds: 500),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 20.0, bottom: 15.0, top: 10.0),
                                child: Text(
                                  'All Messengers',
                                  style: TextStyle(
                                      fontSize: 13.sp,
                                      color: Colors.grey.shade900,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                            Container(
                              height: MediaQuery.of(context).size.height - 200,
                              padding: const EdgeInsets.only(left: 20),
                              child: ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                itemCount: vehicleData.length,
                                itemBuilder: (context, index) {
                                  return FadeInRight(
                                    duration: Duration(
                                        milliseconds: (index * 100) + 500),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    MessengerSubmitRequestPage(
                                                      data: vehicleData[index],
                                                    )));
                                      },
                                      child: Container(
                                        margin:
                                            const EdgeInsets.only(bottom: 20),
                                        child: Row(
                                          children: <Widget>[
                                            Row(
                                              children: [
                                                Container(
                                                    padding: EdgeInsets.all(
                                                        0.010.sh),
                                                    height: 0.070.sh,
                                                    width: 0.070.sh,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color:
                                                          UIColors.secondary600,
                                                    ),
                                                    child: vehicleData[index]
                                                                ['image'] ==
                                                            null
                                                        ? Icon(
                                                            Iconsax.user,
                                                            size: 0.02.sh,
                                                          )
                                                        : Image.asset(
                                                            vehicleData[index]
                                                                ['image'],
                                                          )),
                                                SizedBox(
                                                  width: 0.02.sh,
                                                ),
                                                Text(
                                                  '${vehicleData[index]['full_name']}',
                                                  style: TextStyle(
                                                      fontSize: 14.sp,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ],
                                            ),
                                            const Spacer(),
                                            IconButton(
                                              icon: const Icon(
                                                Icons.arrow_forward_ios,
                                                color: Colors.black,
                                                size: 15,
                                              ),
                                              onPressed: () {},
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
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
