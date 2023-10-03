import 'package:ceuk_user_app/core/network/network_handler.dart';
import 'package:flutter/material.dart';

class UserRequestApi extends NetworkHandler {
  Future<Map> makeRequest(
      {Map<String, dynamic> data, BuildContext context}) async {
    String route = 'requests';
    Map<String, dynamic> header = {};
    return await httpPost(
      route: route,
      data: data,
      header: header,
      authRequired: true,
      hasCustomUrl: false,
      alertDialog: false,
      context: context,
    );
  }

  Future<Map> getAllRequests({
    BuildContext context,
  }) async {
    String route = 'requests';
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

  Future<Map> getSingleRequests({
    BuildContext context,
  }) async {
    String route = 'vehicles';
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

  Future<Map> getProducts({
    BuildContext context,
  }) async {
    String route = 'product-types';
    Map<String, dynamic> header = {};
    return await httpGet(
      route: route,
      header: header,
      authRequired: false,
      hasCustomUrl: false,
      alertDialog: false,
      context: context,
    );
  }
}
