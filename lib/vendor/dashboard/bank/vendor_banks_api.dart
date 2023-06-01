import 'package:ceuk_user_app/core/network/network_handler.dart';
import 'package:flutter/material.dart';

class VendorsBankApi extends NetworkHandler {
  Future<Map> addBanks({
    BuildContext context,
    Map<String, dynamic> data = const {},
  }) async {
    String route = 'vendor/banks';
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

  Future<Map> getBanks({
    BuildContext context,
  }) async {
    String route = 'vendor/banks';
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

  Future<Map> getBank({
    BuildContext context,
    int id,
  }) async {
    String route = 'vendor/banks/$id';
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

  Future<Map> updateBank(
      {Map<String, dynamic> data, int id, BuildContext context}) async {
    String route = 'vendor/banks/$id';
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

  Future<Map> deleteBank({int id, BuildContext context}) async {
    String route = 'vendor/banks/$id';
    Map<String, dynamic> header = {};
    return await httpDelete(
      route: route,
      data: {},
      header: header,
      authRequired: true,
      hasCustomUrl: false,
      alertDialog: false,
      context: context,
    );
  }
}
