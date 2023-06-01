import 'dart:developer';

import 'package:ceuk_user_app/core/design_system/color_shemes.dart';
import 'package:ceuk_user_app/user/authentication/api/auth_api.dart';
import 'package:ceuk_user_app/user_routes.dart';
import 'package:ceuk_user_app/shared/form/action_button.dart';
import 'package:ceuk_user_app/shared/form/form_header.dart';
import 'package:ceuk_user_app/shared/form/pin_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RegisterOTP extends StatefulWidget {
  const RegisterOTP({
    Key key,
    this.phoneNumber,
  }) : super(key: key);
  final String phoneNumber;

  @override
  State<RegisterOTP> createState() => _RegisterOTPState();
}

class _RegisterOTPState extends State<RegisterOTP> {
  final GlobalKey<FormState> _formKey1 = GlobalKey<FormState>();
  TextEditingController textEditingController = TextEditingController();

  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    // log(widget.phoneData.toString());
    // log(widget.accountData.toString());
    return WillPopScope(
        onWillPop: () async => !_isLoading,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
              backgroundColor: Colors.transparent,
              iconTheme: const IconThemeData(color: Colors.black),
              centerTitle: true,
              actions: const [],
              leading: Center(
                child: IconButton(
                    icon: SvgPicture.asset(
                      'assets/icons/navigator_back.svg',
                      height: 0.016.sh,
                    ),
                    onPressed: _isLoading
                        ? null
                        : () {
                            Navigator.pop(context);
                          }),
              ),
              automaticallyImplyLeading: false,
              elevation: 0),
          body: Container(
            child: SingleChildScrollView(
              padding:
                  EdgeInsets.symmetric(vertical: 0.04.sh, horizontal: 0.05.sw),
              child: Form(
                  key: _formKey1,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const FormHeader(
                          centerTitle: true,
                          centerDescription: true,
                          title: 'Enter the code sent to your phone.',
                          description:
                              'A four digits code has been sent to your phone via SMS, please provide the code to continue.',
                        ),
                        PinInputFields(
                          controller: textEditingController,
                          inputLength: 6,
                          enableKeyboard: true,
                          hideText: false,
                          callback: (value) {
                            if (value.length == 6) {
                              setState(() {});
                            }
                            return value;
                          },
                        ),
                        SizedBox(
                          height: 0.060.sh,
                        ),
                        ActionButton(
                          text: 'Proceed',
                          shape: ButtonShape.squircle,
                          size: ButtonSizes.large,
                          textColor: UIColors.white,
                          backgroundColor: UIColors.primary,
                          fontSize: 16.sp,
                          isLoading: _isLoading,
                          onPressed: _isLoading ||
                                  textEditingController.text.length < 6
                              ? null
                              : () async {
                                  if (_formKey1.currentState.validate()) {
                                    Map<String, dynamic> data = {
                                      "receiver": widget.phoneNumber.toString(),
                                      //"receiver": "+2347030976216",
                                      "code": textEditingController.text,
                                      "ref": "PHONE"
                                    };
                                    log(data.toString());

                                    AuthApi authApi = AuthApi();

                                    setState(() {
                                      _isLoading = true;
                                    });
                                    await authApi
                                        .verifyPhoneOTP(
                                            data: data, context: context)
                                        .then((value) {
                                      setState(() {
                                        _isLoading = false;
                                      });
                                      if (value != null) {
                                        //log(value.toString());
                                        Navigator.pushNamedAndRemoveUntil(
                                            context,
                                            UserRoutes.registerInfo,
                                            (route) => true,
                                            arguments: <String, dynamic>{
                                              'phone_number':
                                                  widget.phoneNumber.toString()
                                            });
                                      } else {
                                        log(value.toString());
                                      }
                                    });
                                  } else {
                                    setState(() {
                                      _isLoading = false;
                                    });
                                  }
                                },
                        ),
                        SizedBox(
                          height: 0.023.sh,
                        ),
                      ])),
            ),
          ),
        ));
  }
}
