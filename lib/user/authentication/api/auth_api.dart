import 'package:ceuk_user_app/core/network/network_handler.dart';
import 'package:flutter/material.dart';

class AuthApi extends NetworkHandler {
  Future<Map> sendPhoneOTP(
      {Map<String, dynamic> data, BuildContext context}) async {
    String route = 'verifications';
    Map<String, dynamic> header = {};
    return await httpPost(
      route: route,
      data: data,
      header: header,
      authRequired: false,
      hasCustomUrl: false,
      alertDialog: false,
      context: context,
    );
  }

  Future<Map> verifyPhoneOTP(
      {Map<String, dynamic> data, BuildContext context}) async {
    String route = 'verifications/verify';
    Map<String, dynamic> header = {};
    return await httpPost(
      route: route,
      data: data,
      header: header,
      authRequired: false,
      hasCustomUrl: false,
      alertDialog: false,
      context: context,
    );
  }

  Future<Map> registerAccount(
      {Map<String, dynamic> data, BuildContext context}) async {
    String route = 'register';
    Map<String, dynamic> header = {};
    return await httpPost(
      route: route,
      data: data,
      header: header,
      authRequired: false,
      hasCustomUrl: false,
      alertDialog: false,
      context: context,
    );
  }

  Future<Map> getUserData({
    BuildContext context,
  }) async {
    String route = 'auth';
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

  Future<Map> login({Map<String, dynamic> data, BuildContext context}) async {
    String route = 'login';
    Map<String, dynamic> header = {};
    return await httpPost(
      route: route,
      data: data,
      header: header,
      authRequired: false,
      hasCustomUrl: false,
      alertDialog: false,
      context: context,
    );
  }

  // Future<Map> geoData({BuildContext context}) async {
  //   String route = 'https://ipapi.co/json/';
  //   Map<String, dynamic> header = {};
  //   return await httpGet(
  //     route: route,
  //     header: header,
  //     authRequired: false,
  //     hasCustomUrl: true,
  //     alertDialog: false,
  //     context: context,
  //   );
  // }

  // Future<Map> setupBusiness(
  //     {Map<String, dynamic> data, BuildContext context}) async {
  //   String route = 'setup/business';
  //   Map<String, dynamic> header = {};
  //   return await httpPost(
  //     route: route,
  //     data: data,
  //     header: header,
  //     authRequired: true,
  //     hasCustomUrl: false,
  //     alertDialog: false,
  //     context: context,
  //   );
  // }

  // Future<Map> emailLogin(
  //     {Map<String, dynamic> data, BuildContext context}) async {
  //   String route = 'verifications';
  //   Map<String, dynamic> header = {};
  //   return await httpPost(
  //     route: route,
  //     data: data,
  //     header: header,
  //     authRequired: false,
  //     hasCustomUrl: false,
  //     alertDialog: false,
  //     context: context,
  //   );
  // }

  // Future<Map> initForgotPassword(
  //     {Map<String, dynamic> data, BuildContext context}) async {
  //   String route = 'send/reset/password/otp';
  //   Map<String, dynamic> header = {};
  //   return await httpPost(
  //     route: route,
  //     data: data,
  //     header: header,
  //     authRequired: false,
  //     hasCustomUrl: false,
  //     alertDialog: false,
  //     context: context,
  //   );
  // }

  // Future<Map> completeForgotPassword(
  //     {Map<String, dynamic> data, BuildContext context}) async {
  //   String route = 'verify/reset/password/otp';
  //   Map<String, dynamic> header = {};
  //   return await httpPost(
  //     route: route,
  //     data: data,
  //     header: header,
  //     authRequired: false,
  //     hasCustomUrl: false,
  //     alertDialog: false,
  //     context: context,
  //   );
  // }
}
