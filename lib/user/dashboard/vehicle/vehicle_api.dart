import 'package:ceuk_user_app/core/network/network_handler.dart';
import 'package:flutter/material.dart';

class VehicleApi extends NetworkHandler {
  Future<Map> updateVehicle(
      {Map<String, dynamic> data, int id, BuildContext context}) async {
    String route = 'vehicles/$id';
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

  Future<Map> addVehicle(
      {Map<String, dynamic> data, BuildContext context}) async {
    String route = 'vehicles';
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

  Future<Map> getVehicles({
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

  Future<Map> getCategories({
    BuildContext context,
  }) async {
    String route = 'categories';
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
