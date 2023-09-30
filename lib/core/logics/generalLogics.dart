import 'dart:io';

import 'package:ceuk_user_app/core/design_system/color_shemes.dart';
import 'package:ceuk_user_app/core/providers/user_data_provider.dart';
import 'package:ceuk_user_app/core/providers/vendor_data_provider.dart';
import 'package:ceuk_user_app/core/providers/vstaff_data_provider.dart';
import 'package:ceuk_user_app/modules/authentication/staff_auth_api.dart';
import 'package:ceuk_user_app/staffs_routes.dart';
import 'package:ceuk_user_app/shared/form/action_button.dart';
import 'package:ceuk_user_app/shared/form/notice_dialog.dart';
import 'package:ceuk_user_app/shared/form/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher_string.dart';

class GeneralLogics {
  static Future<void> launchURL(url) async {
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  static Future<File> getGalleryPicture() async {
    final ImagePicker picker = ImagePicker();
// Pick an image.
    final XFile image = await picker.pickImage(source: ImageSource.gallery);
    final file = File(image.path);
    return file;
  }

  static Future<File> takePicture() async {
    final ImagePicker picker = ImagePicker();
// Pick an image.
    final XFile image = await picker.pickImage(source: ImageSource.camera);
    final file = File(image.path);
    return file;
  }

  static void setStaffData(StaffDataProvider staffDataProvider, Map data) {
    staffDataProvider.user = data['user'];
  }

  static Future<void> logoutStaff(BuildContext context) async {
    GeneralLogics.removeUserData().then((value) {
      Navigator.of(context).pushNamedAndRemoveUntil(
          StaffsRoutes.login, (Route<dynamic> route) => false);
    });
  }

  static void setVendorData(VendorDataProvider vendorDataProvider, Map data) {
    vendorDataProvider.user = data['user'];
  }

  static void setUserDataProvider(UserDataProvider userDataProvider, Map data) {
    userDataProvider.user = data['user'];
  }

  static Future<void> logoutFunction({
    BuildContext context,
  }) async {
    GeneralLogics.removeUserData().then((value) {
      Navigator.of(context).pushNamedAndRemoveUntil(
          StaffsRoutes.login, (Route<dynamic> route) => false);
    });
  }

  static Future<void> removeUserData() async {
    const storage = FlutterSecureStorage();
    await storage.delete(key: "token");
    await storage.delete(key: "businessId");
  }

  static Future<void> refreshUserData(
      {UserDataProvider userDataProvider, BuildContext context}) async {
    String token = await GeneralLogics.getToken();
    // print(token);
    if (token == null) {
      if (context.mounted) {
        GeneralLogics.showMessageNew(
            'Your session has expired, please login again.',
            FlushbarType.error,
            context);
        GeneralLogics.logoutFunction(
          context: context,
        );
      }
    } else {
      if (context.mounted) {
        StaffsAuthApi request = StaffsAuthApi();
        await request
            .getStaffData(
          context: context,
        )
            .then((res) async {
          // print(res['data']);

          if (res != null) {
            Map data = {'user': res['data']};
            GeneralLogics.setUserDataProvider(userDataProvider, data);
          } else {
            GeneralLogics.logoutFunction(
              context: context,
            );
          }
        });
      }
    }
  }

  static Future<void> saveToken(String token) async {
    const storage = FlutterSecureStorage();

    await storage.write(key: "token", value: token);
  }

  static Future<String> getToken() async {
    const storage = FlutterSecureStorage();
    return (await storage.read(key: "token"));
  }

  static void showMessageNew(
      String message, FlushbarType type, BuildContext context) {
    FlushBar.showSnackBar(context: context, type: type, message: message);
  }

  static Future<void> showAlertNew(
      BuildContext context, heading, msg, String type) {
    String img;
    switch (type) {
      case 'success':
        img = 'blue_success_check';
        break;

      case 'error':
        img = 'danger_notice';
        break;
      case 'pending':
        img = 'hour_glass';
        break;
      case 'logout':
        img = 'logout_door';
        break;
      case 'settings':
        img = 'admin_settings';
        break;
      case 'sad':
        img = 'sad_emoji';
        break;
      default:
    }
    return showDialog(
        barrierDismissible: true,
        context: context,
        builder: (BuildContext context) => ImportantNoticeDialog(
              dialogBackground: UIColors.white,
              titleFontSize: 25.sp,
              title: '$heading',
              svgFilePath: 'assets/icons/$img.png',
              message: '$msg',
              titleMessageSpace: 0.012.sh,
              iconHeight: 0.081.sh,
              buttonText: 'Ok, close',
              buttonTextColor: UIColors.white,
              buttonSize: ButtonSizes.small,
              buttonBackgroundColor: UIColors.primary,
              buttonShape: ButtonShape.squircle,
              buttonAction: () {
                Navigator.pop(context);
              },
            ));
  }

  static Future<void> showNotice({
    BuildContext context,
    heading,
    msg,
    String type,
    bool canDismiss = true,
    Function onContinue,
    Function onCancel,
    String onCancelText = 'Ok, close',
    String onContinueText = 'Ok, close',
  }) {
    String img;
    switch (type) {
      case 'success':
        img = 'blue_success_check';
        break;

      case 'error':
        img = 'danger_notice';
        break;
      case 'pending':
        img = 'hour_glass';
        break;
      case 'logout':
        img = 'logout_door';
        break;
      case 'settings':
        img = 'admin_settings';
        break;
      case 'sad':
        img = 'sad_emoji';
        break;
      default:
    }
    return showDialog(
        barrierDismissible: canDismiss,
        context: context,
        builder: (BuildContext context) => ImportantNoticeDialog(
              dialogBackground: UIColors.white,
              titleFontSize: 25.sp,
              title: '$heading',
              svgFilePath: 'assets/icons/$img.png',
              message: '$msg',
              titleMessageSpace: 0.012.sh,
              iconHeight: 0.081.sh,
              buttonText: onContinueText,
              buttonTextColor: UIColors.white,
              buttonSize: ButtonSizes.small,
              buttonBackgroundColor: UIColors.primary,
              buttonShape: ButtonShape.squircle,
              buttonAction: onContinue,
              secondButtonBackgroundColor: UIColors.secondary500,
              secondButtonSize: ButtonSizes.small,
              secondButtonTextColor: UIColors.primary,
              secondButtonShape: ButtonShape.squircle,
              secondButtonText: onCancelText,
              secondButtonAction: onCancel,
            ));
  }

  static String formatCurrency(String amount) {
    final formatCurrency = NumberFormat.currency(name: 'NGN', symbol: 'NGN ');
    return formatCurrency
        .format(
          double.tryParse(amount).abs(),
        )
        .replaceAll('.00', '');
  }
}
