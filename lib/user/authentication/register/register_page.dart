import 'dart:developer';

import 'package:ceuk_user_app/core/design_system/color_shemes.dart';
import 'package:ceuk_user_app/core/logics/formValidationLogics.dart';
import 'package:ceuk_user_app/core/logics/generalLogics.dart';
import 'package:ceuk_user_app/core/providers/user_data_provider.dart';
import 'package:ceuk_user_app/user/authentication/api/auth_api.dart';
import 'package:ceuk_user_app/user_routes.dart';
import 'package:ceuk_user_app/shared/form/action_button.dart';
import 'package:ceuk_user_app/shared/form/form_header.dart';
import 'package:ceuk_user_app/shared/form/password_input.dart';
import 'package:ceuk_user_app/shared/form/text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key key, @required this.phoneNumber}) : super(key: key);
  final String phoneNumber;
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();

  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController fnameCtrlr = TextEditingController();

  TextEditingController lnameCtrlr = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  UserDataProvider userDataProvider;

  @override
  didChangeDependencies() {
    super.didChangeDependencies();
    userDataProvider = context.read<UserDataProvider>();
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
          body: SingleChildScrollView(
            padding:
                EdgeInsets.symmetric(vertical: 0.04.sh, horizontal: 0.05.sw),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const FormHeader(
                    title: 'Complete profile',
                    centerTitle: false,
                    // description:
                    //     'Please provide a valid WhatsApp phone number to continue.',
                  ),
                  TextInputField(
                    fieldTitle: 'Firstname',
                    hintText: 'Enter your firstname',
                    validator: FormValidationLogics.isEmpty,
                    hasController: true,
                    textController: fnameCtrlr,
                    onFieldChange: (input) {
                      return;
                    },
                  ),
                  TextInputField(
                    fieldTitle: 'Lastname',
                    hintText: 'Enter your lastname',
                    validator: FormValidationLogics.isEmpty,
                    hasController: true,
                    textController: lnameCtrlr,
                    onFieldChange: (input) {
                      return;
                    },
                  ),
                  TextInputField(
                    fieldTitle: 'Email',
                    hintText: 'Enter your email address',
                    validator: FormValidationLogics.isEmail,
                    hasController: true,
                    textController: emailController,
                    onFieldChange: (input) {
                      return;
                    },
                  ),

                  PasswordInputField(
                    fieldTitle: 'Password',
                    hintText: 'Enter password',
                    validator: FormValidationLogics.isEmpty,
                    hasController: true,
                    textController: passwordController,
                    onFieldChange: (input) {},
                  ),

                  SizedBox(height: 0.04.sh),
                  // const Spacer(),
                  ActionButton(
                    text: 'Register',
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
                              AuthApi authApi = AuthApi();
                              Map<String, String> data = {
                                "first_name": fnameCtrlr.text,
                                "last_name": lnameCtrlr.text,
                                "email": emailController.text,
                                "phone_number": widget.phoneNumber.toString(),
                                "password": passwordController.text
                              };
                              //log(data.toString());
                              setState(() {
                                _isLoading = true;
                              });
                              await authApi
                                  .registerAccount(data: data, context: context)
                                  .then((value) async {
                                setState(() {
                                  _isLoading = false;
                                });
                                if (value != null) {
                                  //log(value.toString());

                                  await authApi
                                      .getUserData(context: context)
                                      .then((value) {
                                    if (value != null) {
                                      // print(res['data']);
                                      GeneralLogics.saveToken(
                                          value['data']['token']);
                                      GeneralLogics.setUserDataProvider(
                                          userDataProvider, value['data']);
                                      Navigator.pushNamed(
                                          context, UserRoutes.home,
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
                ],
              ),
            ),
          )),
    );
  }
}
