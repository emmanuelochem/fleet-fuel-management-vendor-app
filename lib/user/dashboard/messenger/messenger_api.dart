import 'package:ceuk_user_app/core/network/network_handler.dart';
import 'package:flutter/material.dart';

class MessengerApi extends NetworkHandler {
  Future<Map> updateMessenger(
      {Map<String, dynamic> data, int id, BuildContext context}) async {
    String route = 'erranders/$id';
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

  Future<Map> addMessenger(
      {Map<String, dynamic> data, BuildContext context}) async {
    String route = 'erranders';
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

  Future<Map> getMessengers({
    BuildContext context,
  }) async {
    String route = 'erranders';
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
