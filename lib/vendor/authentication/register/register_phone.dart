import 'dart:developer';

import 'package:ceuk_user_app/core/design_system/color_shemes.dart';
import 'package:ceuk_user_app/vendor/authentication/views/vendor_auth_api.dart';
import 'package:ceuk_user_app/user_routes.dart';
import 'package:ceuk_user_app/shared/form/action_button.dart';
import 'package:ceuk_user_app/shared/form/form_header.dart';
import 'package:ceuk_user_app/shared/form/new_phone_input.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RegisterPhone extends StatefulWidget {
  const RegisterPhone({Key key}) : super(key: key);

  @override
  State<RegisterPhone> createState() => _RegisterPhoneState();
}

class _RegisterPhoneState extends State<RegisterPhone> {
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();

  TextEditingController phoneController = TextEditingController();
  TapGestureRecognizer _tapRecognizer;

  @override
  void initState() {
    super.initState();
    _tapRecognizer = TapGestureRecognizer()
      ..onTap = () {
        Navigator.pushNamed(
          context,
          UserRoutes.login,
        );
      };
  }

  @override
  Widget build(BuildContext context) {
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
                          Navigator.pushNamed(
                            context,
                            UserRoutes.welcome,
                          );
                        }),
            ),
            automaticallyImplyLeading: false,
            elevation: 0,
          ),
          body: Container(
            child: SingleChildScrollView(
              padding:
                  EdgeInsets.symmetric(vertical: 0.04.sh, horizontal: 0.05.sw),
              child: SizedBox(
                height: 0.77.sh,
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const FormHeader(
                        title: 'Create an account',
                        centerTitle: false,
                        // description:
                        //     'Please provide a valid WhatsApp phone number to continue.',
                      ),

                      NewPhoneInputField(
                        fieldTitle: 'Phone',
                        hintText: 'Enter phone',
                        onFieldChange: (input) {
                          phoneController.text = '+234$input';
                          return;
                        },
                      ),
                      // Stack(
                      //   children: [
                      //     Positioned(
                      //       top: 0,
                      //       right: 10,
                      //       child: GestureDetector(
                      //         onTap: () => Navigator.pushNamed(
                      //           context,
                      //           UserRoutes.resetPassword,
                      //         ),
                      //         child: Text(
                      //           'Forgot Password',
                      //           style: TypographyStyle.bodySmall.copyWith(
                      //             color: UIColors.primaryMain,
                      //             fontSize: 15.sp,
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //     PasswordInputField(
                      //       fieldTitle: 'Password',
                      //       hintText: 'Enter password',
                      //       validator: FormValidationLogics.isEmpty,
                      //       hasController: true,
                      //       textController: passwordController,
                      //       onFieldChange: (input) {},
                      //     ),
                      //   ],
                      // ),

                      SizedBox(height: 0.02.sh),
                      // const Spacer(),
                      ActionButton(
                        text: 'Continue',
                        backgroundColor: UIColors.primary,
                        textColor: UIColors.white,
                        shape: ButtonShape.squircle,
                        size: ButtonSizes.large,
                        isLoading: _isLoading,
                        onPressed: _isLoading
                            ? null
                            : () async {
                                if (!FocusScope.of(context).hasPrimaryFocus) {
                                  FocusScope.of(context).unfocus();
                                }
                                if (_formKey.currentState.validate()) {
                                  VendorAuthApi authApi = VendorAuthApi();
                                  Map<String, String> data = {
                                    "phone_number": phoneController.text
                                  };
                                  setState(() {
                                    _isLoading = true;
                                  });
                                  await authApi
                                      .sendPhoneOTP(
                                          data: data, context: context)
                                      .then((value) {
                                    setState(() {
                                      _isLoading = false;
                                    });
                                    if (value != null) {
                                      //log(value.toString());
                                      Navigator.pushNamed(
                                          context, UserRoutes.registerOtp,
                                          arguments: <String, dynamic>{
                                            'phone_number': phoneController.text
                                          });
                                    } else {
                                      log(value.toString());
                                    }
                                  });
                                } else {
                                  //validation error
                                }
                              },
                      ),
                      SizedBox(height: 0.04.sh),

                      SizedBox(
                        width: 1.sw,
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Already have an account? ',
                                style: TextStyle(
                                  fontSize: 17.sp,
                                  fontStyle: FontStyle.normal,
                                  color: UIColors.secondary,
                                  fontFamily: 'CW BR Firma',
                                  height: 1.5,
                                ),
                              ),
                              TextSpan(
                                text: 'login now',
                                recognizer: _tapRecognizer,
                                style: TextStyle(
                                  fontSize: 17.sp,
                                  fontStyle: FontStyle.normal,
                                  color: Colors.grey.shade900,
                                  fontFamily: 'CW BR Firma',
                                  height: 1.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )),
    );
  }
}
