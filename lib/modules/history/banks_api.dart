import 'package:ceuk_user_app/core/network/network_handler.dart';
import 'package:flutter/material.dart';

class BanksApi extends NetworkHandler {
  Future<Map> getProviderBanks({
    BuildContext context,
  }) async {
    String route = 'banks';
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

  Future<Map> verifyBanks({
    BuildContext context,
    Map<String, dynamic> data = const {},
  }) async {
    String route = 'banks/verify';
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
}
