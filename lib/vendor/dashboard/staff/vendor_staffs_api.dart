import 'package:ceuk_user_app/core/network/network_handler.dart';
import 'package:flutter/material.dart';

class VendorStaffsApi extends NetworkHandler {
  Future<Map> addStaff(
      {Map<String, dynamic> data, BuildContext context}) async {
    String route = 'vendor/staffs';
    Map<String, dynamic> header = {};
    return await httpPost(
      route: route,
      data: data,
      header: header,
      authRequired: true,
      hasCustomUrl: false,
      alertDialog: true,
      context: context,
    );
  }

  Future<Map> getStaff({BuildContext context}) async {
    String route = 'vendor/staffs';
    Map<String, dynamic> header = {};
    return await httpGet(
      route: route,
      header: header,
      authRequired: true,
      hasCustomUrl: false,
      alertDialog: false,
      context: context,
    );
  }
}
