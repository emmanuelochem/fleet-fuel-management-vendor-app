import 'package:animate_do/animate_do.dart';
import 'package:ceuk_user_app/core/design_system/color_shemes.dart';
import 'package:ceuk_user_app/shared/form/empty_data_notice.dart';
import 'package:ceuk_user_app/user/dashboard/request/vehicle_submit_request_page.dart';
import 'package:ceuk_user_app/user/dashboard/vehicle/vehicle_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VehicleRequestPage extends StatefulWidget {
  const VehicleRequestPage({Key key}) : super(key: key);

  @override
  _RequestPageState createState() => _RequestPageState();
}

class _RequestPageState extends State<VehicleRequestPage> {
  bool isLoaded = false;

  Future<List> getVehicles() async {
    VehicleApi vehicleApi = VehicleApi();
    var res = await vehicleApi
        .getVehicles(
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
        title: const Text(
          'Vehicles Request',
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
                        icon: PhosphorIcons.car,
                        message: 'Vehicle not available at the moment.',
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                            SizedBox(
                              height: 0.008.sh,
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
                                        Map newData = vehicleData[index];

                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    VehicleSubmitRequestPage(
                                                        data: newData)));
                                      },
                                      child: Container(
                                        margin:
                                            const EdgeInsets.only(bottom: 20),
                                        child: Row(
                                          children: <Widget>[
                                            Row(
                                              children: [
                                                Container(
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  height: 0.060.sh,
                                                  width: 0.060.sh,
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color:
                                                          UIColors.secondary600,
                                                      image: DecorationImage(
                                                          image: NetworkImage(
                                                              vehicleData[index]
                                                                  [
                                                                  'driver_image']))),
                                                ),
                                                SizedBox(
                                                  width: 0.02.sh,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      '${vehicleData[index]['driver_name']}',
                                                      style: TextStyle(
                                                          fontSize: 16.sp,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                    SizedBox(
                                                      height: 0.003.sh,
                                                    ),
                                                    Text(
                                                      '${vehicleData[index]['model']} (${vehicleData[index]['plate_number']})',
                                                      style: TextStyle(
                                                        fontSize: 11.sp,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: UIColors
                                                            .secondary300,
                                                      ),
                                                    ),
                                                  ],
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
