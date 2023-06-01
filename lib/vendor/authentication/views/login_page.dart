import 'dart:developer';

import 'package:ceuk_user_app/core/design_system/color_shemes.dart';
import 'package:ceuk_user_app/core/design_system/typography_style.dart';
import 'package:ceuk_user_app/core/logics/formValidationLogics.dart';
import 'package:ceuk_user_app/core/logics/generalLogics.dart';
import 'package:ceuk_user_app/core/providers/vendor_data_provider.dart';
import 'package:ceuk_user_app/shared/form/action_button.dart';
import 'package:ceuk_user_app/shared/form/form_header.dart';
import 'package:ceuk_user_app/shared/form/password_input.dart';
import 'package:ceuk_user_app/shared/form/text_input.dart';
import 'package:ceuk_user_app/vendor/authentication/views/vendor_auth_api.dart';
import 'package:ceuk_user_app/vendor_routes.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();

  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TapGestureRecognizer _tapRecognizer;

  VendorDataProvider vendorDataProvider;

  @override
  didChangeDependencies() {
    super.didChangeDependencies();
    vendorDataProvider = context.read<VendorDataProvider>();
  }

  @override
  void initState() {
    super.initState();
    _tapRecognizer = TapGestureRecognizer()
      ..onTap = () {
        Navigator.pushNamed(
          context,
          VendorRoutes.registerPhone,
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
                            VendorRoutes.welcome,
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
                        title: 'Login',
                        centerTitle: false,
                        // description:
                        //     'Please provide a valid WhatsApp phone number to continue.',
                      ),

                      // NewPhoneInputField(
                      //   fieldTitle: 'Phone',
                      //   hintText: 'Enter phone',
                      //   onFieldChange: (input) {
                      //     phoneController.text = '$input';
                      //     return;
                      //   },
                      // ),
                      TextInputField(
                        fieldTitle: 'Manager phone',
                        hintText: 'Enter manager phone',
                        validator: FormValidationLogics.isEmpty,
                        hasController: true,
                        textController: phoneController,
                        onFieldChange: (input) {
                          return;
                        },
                      ),
                      Stack(
                        children: [
                          Positioned(
                            top: 0,
                            right: 10,
                            child: GestureDetector(
                              onTap: () => Navigator.pushNamed(
                                context,
                                VendorRoutes.resetPassword,
                              ),
                              child: Text(
                                'Forgot Password',
                                style: TypographyStyle.bodySmall.copyWith(
                                  color: Colors.grey.shade900,
                                  fontSize: 15.sp,
                                ),
                              ),
                            ),
                          ),
                          PasswordInputField(
                            fieldTitle: 'Password',
                            hintText: 'Enter password',
                            validator: FormValidationLogics.isEmpty,
                            hasController: true,
                            textController: passwordController,
                            onFieldChange: (input) {},
                          ),
                        ],
                      ),

                      SizedBox(height: 0.04.sh),
                      // const Spacer(),
                      ActionButton(
                        text: 'Login',
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
                                    "manager_phone": phoneController.text,
                                    "password": passwordController.text
                                  };
                                  setState(() {
                                    _isLoading = true;
                                  });
                                  await authApi
                                      .loginVendor(data: data, context: context)
                                      .then((value) async {
                                    setState(() {
                                      _isLoading = false;
                                    });
                                    if (value != null) {
                                      // log(value.toString());
                                      GeneralLogics.saveToken(
                                          value['data']['token']);

                                      await authApi
                                          .getVendorData(context: context)
                                          .then((value) {
                                        if (value != null) {
                                          // print(res['data']);
                                          Map data = {'user': value['data']};
                                          GeneralLogics.setVendorData(
                                              vendorDataProvider, data);
                                          Navigator.pushNamed(
                                              context, VendorRoutes.home,
                                              arguments: <String, dynamic>{
                                                // 'phone_number': phoneController.text
                                              });
                                        } else {}
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
                                text: 'Don\'t have an account? ',
                                style: TextStyle(
                                  fontSize: 17.sp,
                                  fontStyle: FontStyle.normal,
                                  color: UIColors.secondary,
                                  fontFamily: 'CW BR Firma',
                                  height: 1.5,
                                ),
                              ),
                              TextSpan(
                                text: 'register now',
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
