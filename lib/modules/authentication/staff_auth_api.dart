import 'package:ceuk_user_app/core/network/network_handler.dart';
import 'package:flutter/material.dart';

class StaffsAuthApi extends NetworkHandler {
  Future<Map> getStaffData({
    BuildContext context,
  }) async {
    String route = 'errander/auth';
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

  Future<Map> loginStaff(
      {Map<String, dynamic> data, BuildContext context}) async {
    String route = 'errander/login';
    Map<String, dynamic> header = {};
    return await httpPost(
      route: route,
      data: data,
      header: header,
      authRequired: false,
      hasCustomUrl: false,
      alertDialog: false,
      context: context,
    );
  }
}
