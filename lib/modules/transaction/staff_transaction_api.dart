import 'package:ceuk_user_app/core/network/network_handler.dart';
import 'package:flutter/material.dart';

class StaffTransactionsApi extends NetworkHandler {
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
