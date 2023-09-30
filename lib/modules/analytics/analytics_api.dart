import 'package:ceuk_user_app/core/network/network_handler.dart';
import 'package:flutter/material.dart';

class AnalyticsApi extends NetworkHandler {
  Future<Map> getAnalytics(
      {BuildContext context, String timeline = 'year'}) async {
    String route = 'analytics?type=$timeline';
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
