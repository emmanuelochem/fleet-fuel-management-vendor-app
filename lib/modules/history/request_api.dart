import 'package:ceuk_user_app/core/network/network_handler.dart';
import 'package:flutter/material.dart';

class RequestApi extends NetworkHandler {
  Future<Map> getRequests(
      {BuildContext context,
      String status = 'pending',
      String perpage = '100',
      String paginate = 'false'}) async {
    String route =
        'errander/requests?paginate=$paginate&perPage=$perpage&status=$status';
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

  Future<Map> completeRequest(
      {Map<String, dynamic> data, int id, BuildContext context}) async {
    String route = 'errander/requests/$id';
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
