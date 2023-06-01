import 'dart:developer';

import 'package:ceuk_user_app/core/logics/generalLogics.dart';
import 'package:ceuk_user_app/core/network/network_config.dart';
import 'package:ceuk_user_app/core/network/network_interceptor.dart';
import 'package:ceuk_user_app/core/network/network_logger.dart';
import 'package:ceuk_user_app/shared/form/snack_bar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class NetworkHandler {
  //Config Url
  String apiUrl = NetworkConfig().baseUrl;

  Future httpGet({
    @required String route,
    Map<String, dynamic> header,
    bool authRequired = true,
    bool hasCustomUrl = false,
    bool alertDialog = false,
    bool successSnacbar = false,
    @required BuildContext context,
  }) async {
    route = hasCustomUrl ? route : apiUrl + route;
    Dio dio = Dio(
      BaseOptions(
        baseUrl: apiUrl,
        connectTimeout: 60000,
        receiveTimeout: 60000,
        responseType: ResponseType.json,
        // headers: {
        //   'Accept': 'application/json',
        //   'Connection': 'keep-alive',
        //   'Content-Type': 'application/json',
        // },
      ),
    )..interceptors.addAll([
        AuthorizationInterceptor(auth: authRequired),
        LoggerInterceptor(),
      ]);
    //try {
    return await dio
        .get(
      route,
      options: Options(
        followRedirects: false,
        validateStatus: (status) {
          return status <= 500;
        },
      ),
    )
        .timeout(const Duration(seconds: 60), onTimeout: () {
      GeneralLogics.showMessageNew(
        'Your request timed out, try again',
        FlushbarType.error,
        context,
      );
      GeneralLogics.showAlertNew(
        context,
        'Request Failed',
        'Your request timed out, try again',
        'sad',
      );
      return null;
    }).then((response) {
      if (response != null) {
        // if (response.statusCode == 400 ||
        //     response.statusCode == 401 ||
        //     response.statusCode == 404) {
        //   GeneralLogics.logoutFunction(context);
        // } else {
        if (response.statusCode == 200 &&
            response.data["status"] == "success") {
          if (alertDialog) {
            GeneralLogics.showAlertNew(context, 'Request successful',
                response.data["message"], 'success');
          }
          if (successSnacbar) {
            GeneralLogics.showMessageNew(
                response.data["message"], FlushbarType.success, context);
          }
          return response.data;
        } else if (hasCustomUrl == true) {
          return response.data;
        } else {
          GeneralLogics.showAlertNew(
              context, 'Request Failed', response.data["message"], 'sad');
          return null;
        }
        //}
      }
      GeneralLogics.showAlertNew(
          context,
          'Unexpected Error',
          "An error occured, please check your internet connection and try again later.",
          'error');
      return null;
    }).catchError((error) {
      GeneralLogics.showMessageNew(
          'An error occured, please check your internet connection and try again later.',
          FlushbarType.error,
          context);
      return null;
    });
    // } on DioError catch (err) {
    //   final errorMessage = DioException.fromDioError(err).toString();
    //   throw errorMessage;
    // } catch (e) {
    //   log(e);
    //   throw e.toString();
    // }
  }

  Future httpPost({
    @required String route,
    Map<String, dynamic> header,
    @required Map<String, dynamic> data,
    bool authRequired = true,
    bool hasCustomUrl = false,
    bool alertDialog = false,
    bool successSnacbar = false,
    @required BuildContext context,
  }) async {
    route = hasCustomUrl ? route : apiUrl + route;
    Dio dio = Dio(
      BaseOptions(
        baseUrl: apiUrl,
        connectTimeout: 60000,
        receiveTimeout: 60000,
        responseType: ResponseType.json,
        // headers: {
        //   'Accept': 'application/json',
        //   'Connection': 'keep-alive',
        //   'Content-Type': 'application/json',
        // },
      ),
    )..interceptors.addAll([
        AuthorizationInterceptor(auth: authRequired),
        LoggerInterceptor(),
      ]);
    FormData formData = FormData.fromMap(data);
    //try {
    return await dio
        .post(
      route,
      data: formData,
      options: Options(
        followRedirects: false,
        validateStatus: (status) {
          return status <= 500;
        },
      ),
    )
        .timeout(const Duration(seconds: 60), onTimeout: () {
      // GeneralLogics.showMessageNew(
      //     'Your request timed out, try again', FlushbarType.error, context);
      GeneralLogics.showAlertNew(context, 'Request Failed',
          'Your request timed out, try again', 'sad');
      return null;
    }).then((response) {
      //log(response.toString());
      if (response != null) {
        if (response.statusCode == 200 &&
            response.data["status"] == "success") {
          if (alertDialog) {
            // NikeAlertDialog(message: response.data["message"]);
            GeneralLogics.showAlertNew(context, 'Request successful',
                response.data["message"], 'success');
          }
          if (successSnacbar) {
            GeneralLogics.showMessageNew(
                response.data["message"], FlushbarType.success, context);
          }
          return response.data;
        }
        // GeneralLogics.showMessageNew(
        //     response.data["message"], FlushbarType.error, context);
        GeneralLogics.showAlertNew(
            context, 'Request Failed', response.data["message"], 'sad');
        return null;
      }
      // print(response.toString());
      GeneralLogics.showAlertNew(
          context,
          'Unexpected Error',
          "An error occured, please check your internet connection and try again later.",
          'error');
      return null;
    }).catchError((error) {
      GeneralLogics.showMessageNew(
          'An error occured, please check your internet connection and try again later.',
          FlushbarType.error,
          context);
      return null;
    });
    // } on DioError catch (err) {
    //   final errorMessage = DioException.fromDioError(err).toString();
    //   throw errorMessage;
    // } catch (e) {
    //   log(e);
    //   throw e.toString();
    // }
  }

  Future httpDelete({
    @required String route,
    Map<String, dynamic> header,
    @required Map<String, dynamic> data,
    bool authRequired = true,
    bool hasCustomUrl = false,
    bool alertDialog = false,
    bool successSnacbar = false,
    @required BuildContext context,
  }) async {
    route = hasCustomUrl ? route : apiUrl + route;
    Dio dio = Dio(
      BaseOptions(
        baseUrl: apiUrl,
        connectTimeout: 60000,
        receiveTimeout: 60000,
        responseType: ResponseType.json,
        // headers: {
        //   'Accept': 'application/json',
        //   'Connection': 'keep-alive',
        //   'Content-Type': 'application/json',
        // },
      ),
    )..interceptors.addAll([
        AuthorizationInterceptor(auth: authRequired),
        LoggerInterceptor(),
      ]);
    FormData formData = FormData.fromMap(data);
    // try {
    return await dio
        .delete(
      route,
      data: formData,
      options: Options(
        followRedirects: false,
        validateStatus: (status) {
          return status <= 500;
        },
      ),
    )
        .timeout(const Duration(seconds: 60), onTimeout: () {
      GeneralLogics.showMessageNew(
          'Your request timed out, try again', FlushbarType.error, context);
      GeneralLogics.showAlertNew(context, 'Request Failed',
          'Your request timed out, try again', 'sad');
      return null;
    }).then((response) {
      if (response != null) {
        if (response.statusCode == 200 &&
            response.data["status"] == "success") {
          if (alertDialog) {
            GeneralLogics.showAlertNew(context, 'Request successful',
                response.data["message"], 'success');
          }
          if (successSnacbar) {
            GeneralLogics.showMessageNew(
                response.data["message"], FlushbarType.success, context);
          }
          return response.data;
        }
        GeneralLogics.showAlertNew(
            context, 'Request Failed', response.data["message"], 'sad');
        return null;
      }
      GeneralLogics.showAlertNew(
          context,
          'Unexpected Error',
          "An error occured, please check your internet connection and try again later.",
          'error');
      return null;
    }).catchError((error) {
      GeneralLogics.showMessageNew(
          'An error occured, please check your internet connection and try again later.',
          FlushbarType.error,
          context);
      return null;
    });
    //   return response.data;
    // } on DioError catch (err) {
    //   final errorMessage = DioException.fromDioError(err).toString();
    //   throw errorMessage;
    // } catch (e) {
    //   log(e);
    //   throw e.toString();
    // }
  }

  Future httpPatch(
      {@required String route,
      Map<String, dynamic> header,
      @required Map<String, dynamic> data,
      bool authRequired = true,
      bool hasCustomUrl = false,
      bool alertDialog = false,
      bool successSnacbar = false,
      @required BuildContext context}) async {
    route = hasCustomUrl ? route : apiUrl + route;
    Dio dio = Dio(
      BaseOptions(
        baseUrl: apiUrl,
        connectTimeout: 60000,
        receiveTimeout: 60000,
        responseType: ResponseType.json,
        // headers: {
        //   'Accept': 'application/json',
        //   'Connection': 'keep-alive',
        //   'Content-Type': 'application/json',
        // },
      ),
    )..interceptors.addAll([
        AuthorizationInterceptor(auth: authRequired),
        LoggerInterceptor(),
      ]);
    FormData formData = FormData.fromMap(data);
    log(data.toString());
    //try {
    return await dio
        .patch(
      route,
      data: formData,
      options: Options(
        followRedirects: false,
        validateStatus: (status) {
          return status <= 500;
        },
      ),
    )
        .timeout(const Duration(seconds: 60), onTimeout: () {
      GeneralLogics.showMessageNew(
          'Your request timed out, try again', FlushbarType.error, context);
      GeneralLogics.showAlertNew(context, 'Request Failed',
          'Your request timed out, try again', 'sad');
      return null;
    }).then((response) {
      if (response != null) {
        if (response.statusCode == 200 &&
            response.data["status"] == "success") {
          if (alertDialog) {
            GeneralLogics.showAlertNew(context, 'Request successful',
                response.data["message"], 'success');
          }
          if (successSnacbar) {
            GeneralLogics.showMessageNew(
                response.data["message"], FlushbarType.success, context);
          }
          return response.data;
        }
        GeneralLogics.showAlertNew(
            context, 'Request Failed', response.data["message"], 'sad');
        return null;
      }
      GeneralLogics.showAlertNew(
          context,
          'Unexpected Error',
          "An error occured, please check your internet connection and try again later.",
          'error');
      return null;
    }).catchError((error) {
      GeneralLogics.showMessageNew(
          'An error occured, please check your internet connection and try again later.',
          FlushbarType.error,
          context);
      return null;
    });
    //   return response.data;
    // } on DioError catch (err) {
    //   final errorMessage = DioException.fromDioError(err).toString();
    //   throw errorMessage;
    // } catch (e) {
    //   log(e);
    //   throw e.toString();
    // }
  }

  Future httpGetBinary({
    @required String route,
    Map<String, dynamic> header,
    bool authRequired = true,
    bool hasCustomUrl = false,
    bool alertDialog = false,
    bool successSnacbar = false,
    @required BuildContext context,
  }) async {
    route = hasCustomUrl ? route : apiUrl + route;
    var authToken = await GeneralLogics.getToken();
    Dio dio = Dio(
      BaseOptions(
        baseUrl: apiUrl,
        connectTimeout: 60000,
        receiveTimeout: 60000,
        responseType: ResponseType.bytes,
        headers: {
          'Accept': 'application/pdf',
          'Connection': 'keep-alive',
          'Authorization': 'Bearer $authToken',
          'Content-Type': 'application/pdf',
        },
      ),
    );
    //try {
    return await dio
        .get(
      route,
      options: Options(
        followRedirects: false,
        validateStatus: (status) {
          return status <= 500;
        },
      ),
    )
        .timeout(const Duration(seconds: 60), onTimeout: () {
      GeneralLogics.showMessageNew(
        'Your request timed out, try again',
        FlushbarType.error,
        context,
      );
      GeneralLogics.showAlertNew(
        context,
        'Request Failed',
        'Your request timed out, try again',
        'sad',
      );
      return null;
    }).then((response) {
      if (response != null) {
        // if (response.statusCode == 400 ||
        //     response.statusCode == 401 ||
        //     response.statusCode == 404) {
        //   GeneralLogics.logoutFunction(context);
        // } else {
        if (response.statusCode == 200) {
          return response.data;
        } else if (hasCustomUrl == true) {
          return response.data;
        } else {
          GeneralLogics.showAlertNew(
              context, 'Request Failed', response.data["message"], 'sad');
          return null;
        }
        //}
      }
      GeneralLogics.showAlertNew(
          context,
          'Unexpected Error',
          "An error occured, please check your internet connection and try again later.",
          'error');
      return null;
    }).catchError((error) {
      GeneralLogics.showMessageNew(
          'An error occured, please check your internet connection and try again later.',
          FlushbarType.error,
          context);
      return null;
    });
    // } on DioError catch (err) {
    //   final errorMessage = DioException.fromDioError(err).toString();
    //   throw errorMessage;
    // } catch (e) {
    //   log(e);
    //   throw e.toString();
    // }
  }
}
