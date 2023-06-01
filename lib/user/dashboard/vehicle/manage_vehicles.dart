import 'package:animate_do/animate_do.dart';
import 'package:ceuk_user_app/core/design_system/color_shemes.dart';
import 'package:ceuk_user_app/core/design_system/typography_style.dart';
import 'package:ceuk_user_app/user_routes.dart';
import 'package:ceuk_user_app/shared/form/empty_data_notice.dart';
import 'package:ceuk_user_app/user/dashboard/vehicle/vehicle_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ManageVehicles extends StatefulWidget {
  const ManageVehicles({Key key}) : super(key: key);

  @override
  _ManageVehiclesState createState() => _ManageVehiclesState();
}

class _ManageVehiclesState extends State<ManageVehicles> {
  bool isLoaded = false;

  Future<List> getVehicles() async {
    setState(() {
      isLoaded = false;
    });
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
          'Manage Vehicles',
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
                        hintText: 'Search vehicles',
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
                final vehicleData = querySnapshot.data ?? [];
                // print(list[0]['summary']);
                return vehicleData.isEmpty
                    ? const EmptyDataNotice(
                        message: 'Vehicle not available at the moment.',
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                            SizedBox(
                              height: 0.008.sh,
                            ),
                            SizedBox(
                              height: 0.008.sh,
                            ),
                            // FadeInRight(
                            //   duration: const Duration(milliseconds: 500),
                            //   child: Padding(
                            //     padding: const EdgeInsets.only(
                            //         left: 20.0, bottom: 15.0, top: 10.0),
                            //     child: Text(
                            //       'Active Vehicles',
                            //       style: TextStyle(
                            //           fontSize: 16.sp,
                            //           color: Colors.grey.shade900,
                            //           fontWeight: FontWeight.w500),
                            //     ),
                            //   ),
                            // ),
                            Container(
                              height: 1.sh,
                              padding:
                                  EdgeInsets.symmetric(horizontal: 0.058.sw),
                              child: ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                itemCount: vehicleData.length,
                                itemBuilder: (context, index) {
                                  return FadeInRight(
                                    duration: Duration(
                                        milliseconds: (index * 100) + 500),
                                    child: Container(
                                      margin: EdgeInsets.only(
                                        bottom: 0.020.sh,
                                      ),
                                      child: Row(
                                        children: <Widget>[
                                          Row(
                                            children: [
                                              CircleAvatar(
                                                radius: 27.r,
                                                backgroundColor:
                                                    UIColors.secondary500,
                                                backgroundImage: NetworkImage(
                                                    vehicleData[index]
                                                        ['driver_image']),
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
                                                      color:
                                                          UIColors.secondary300,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          const Spacer(),
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.pushNamed(context,
                                                  UserRoutes.updateVehicle,
                                                  arguments: <String, dynamic>{
                                                    'vehicleData':
                                                        vehicleData[index]
                                                  }).then((value) {
                                                futureData = getVehicles();
                                                setState(() {});
                                              });
                                            },
                                            child: Container(
                                              margin: EdgeInsets.all(0.010.sw),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20.r)),
                                                color: UIColors.primary600,
                                              ),
                                              child: Container(
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 0.058.sw,
                                                    vertical: 0.007.sh),
                                                child: Text(
                                                  'Edit',
                                                  textAlign: TextAlign.center,
                                                  style: TypographyStyle
                                                      .bodySmall
                                                      .copyWith(
                                                    color: UIColors.primary,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
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
