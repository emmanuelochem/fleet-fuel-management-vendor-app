import 'package:ceuk_user_app/core/network/network_handler.dart';
import 'package:flutter/material.dart';

class UserTransactionsApi extends NetworkHandler {
  Future<Map> fundWallet({
    BuildContext context,
    Map<String, dynamic> data = const {},
  }) async {
    String route = 'wallets';
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

  Future<Map> cashoutFunds({
    BuildContext context,
    Map<String, dynamic> data = const {},
  }) async {
    String route = 'cashout';
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

  Future<Map> getTransactions({
    BuildContext context,
    Map<String, dynamic> data = const {},
  }) async {
    String route = 'transactions';
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
