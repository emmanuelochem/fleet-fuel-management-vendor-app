import 'package:ceuk_user_app/core/network/network_handler.dart';
import 'package:flutter/material.dart';

class StaffsRequestApi extends NetworkHandler {
  Future<Map> findRequest({String code, BuildContext context}) async {
    String route = 'staff/requests/$code';
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

  Future<Map> confirmRequest(
      {Map<String, dynamic> data,
      String requestId,
      BuildContext context}) async {
    String route = 'staff/requests/$requestId';
    Map<String, dynamic> header = {};
    return await httpPost(
      data: data,
      route: route,
      header: header,
      authRequired: true,
      hasCustomUrl: false,
      alertDialog: false,
      context: context,
    );
  }
}
