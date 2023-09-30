import 'dart:developer';

import 'package:ceuk_user_app/core/design_system/color_shemes.dart';
import 'package:ceuk_user_app/core/logics/formValidationLogics.dart';
import 'package:ceuk_user_app/core/logics/generalLogics.dart';
import 'package:ceuk_user_app/core/providers/vstaff_data_provider.dart';
import 'package:ceuk_user_app/modules/authentication/staff_auth_api.dart';
import 'package:ceuk_user_app/shared/form/action_button.dart';
import 'package:ceuk_user_app/shared/form/form_header.dart';
import 'package:ceuk_user_app/shared/form/new_phone_input.dart';
import 'package:ceuk_user_app/shared/form/password_input.dart';
import 'package:ceuk_user_app/staffs_routes.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class StaffLoginPage extends StatefulWidget {
  const StaffLoginPage({Key key}) : super(key: key);

  @override
  State<StaffLoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<StaffLoginPage> {
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();

  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  StaffDataProvider staffDataProvider;

  @override
  didChangeDependencies() {
    super.didChangeDependencies();
    staffDataProvider = context.read<StaffDataProvider>();
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
                            StaffsRoutes.welcome,
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
                      IntPhoneInputField(
                        fieldTitle: 'Phone',
                        hintText: 'Phone number',
                        onFieldChange: (input) {
                          setState(() {
                            phoneController.text = input.completeNumber
                                .replaceAll(
                                    '${input.countryCode}0', input.countryCode);
                          });
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
                                  StaffsAuthApi authApi = StaffsAuthApi();
                                  Map<String, String> data = {
                                    "phone_number": phoneController.text,
                                    "password": passwordController.text
                                  };
                                  setState(() {
                                    _isLoading = true;
                                  });
                                  await authApi
                                      .loginStaff(data: data, context: context)
                                      .then((value) async {
                                    setState(() {
                                      _isLoading = false;
                                    });
                                    if (value != null) {
                                      // log(value.toString());
                                      GeneralLogics.saveToken(
                                          value['data']['token']);

                                      await authApi
                                          .getStaffData(context: context)
                                          .then((value) {
                                        if (value != null) {
                                          // print(res['data']);
                                          Map data = {'user': value['data']};
                                          GeneralLogics.setStaffData(
                                              staffDataProvider, data);
                                          Navigator.pushNamed(
                                              context, StaffsRoutes.home,
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
              ),
            ),
          )),
    );
  }
}
