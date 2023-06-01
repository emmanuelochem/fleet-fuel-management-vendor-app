import 'dart:io';
import 'dart:typed_data';

import 'package:ceuk_user_app/core/design_system/color_shemes.dart';
import 'package:ceuk_user_app/core/logics/formValidationLogics.dart';
import 'package:ceuk_user_app/core/logics/generalLogics.dart';
import 'package:ceuk_user_app/shared/form/action_button.dart';
import 'package:ceuk_user_app/shared/form/email_input_field.dart';
import 'package:ceuk_user_app/shared/form/text_input.dart';
import 'package:ceuk_user_app/vendor/dashboard/bank/vendor_banks_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class VendorAddBank extends StatefulWidget {
  const VendorAddBank({Key key}) : super(key: key);

  @override
  State<VendorAddBank> createState() => _AddMessengerState();
}

class _AddMessengerState extends State<VendorAddBank> {
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();

  TextEditingController bankNameController = TextEditingController();
  TextEditingController accountNumberController = TextEditingController();
  TextEditingController accountNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  File imageCamera;
  Uint8List imageGallery;
  bool uploadingGallery = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => !_isLoading,
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
              backgroundColor: Colors.transparent,
              iconTheme: const IconThemeData(color: Colors.black),
              centerTitle: false,
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
              elevation: 0,
              title: Text(
                'Add Bank',
                style: TextStyle(color: Colors.black, fontSize: 18.sp),
              )),
          body: SingleChildScrollView(
            padding:
                EdgeInsets.symmetric(vertical: 0.04.sh, horizontal: 0.05.sw),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextInputField(
                    fieldTitle: 'Bank name',
                    hintText: 'Enter firstname name',
                    validator: FormValidationLogics.isEmpty,
                    hasController: true,
                    textController: bankNameController,
                    onFieldChange: (input) {
                      return;
                    },
                  ),

                  TextInputField(
                    fieldTitle: 'Account Number',
                    hintText: 'Enter lastname name',
                    validator: FormValidationLogics.isEmpty,
                    hasController: true,
                    textController: accountNumberController,
                    onFieldChange: (input) {
                      return;
                    },
                  ),

                  EmailInputField(
                    fieldTitle: 'Account Name',
                    hintText: 'Enter email address',
                    validator: FormValidationLogics.isEmpty,
                    hasController: true,
                    textController: accountNameController,
                    onFieldChange: (input) {
                      return;
                    },
                  ),

                  SizedBox(height: 0.04.sh),
                  // const Spacer(),
                  ActionButton(
                    text: 'Submit',
                    backgroundColor: UIColors.primary,
                    textColor: UIColors.white,
                    shape: ButtonShape.squircle,
                    size: ButtonSizes.large,
                    isLoading: _isLoading,
                    onPressed: _isLoading
                        ? null
                        : () async {
                            FocusScopeNode currentFocus =
                                FocusScope.of(context);
                            if (!currentFocus.hasPrimaryFocus) {
                              currentFocus.unfocus();
                            }

                            if (_formKey.currentState.validate()) {
                              VendorsBankApi vendorsBankApi = VendorsBankApi();
                              Map<String, String> data = {
                                "bank_name": bankNameController.text,
                                "account_number": accountNumberController.text,
                                "account_name": accountNameController.text
                              };
                              setState(() {
                                _isLoading = true;
                              });
                              await vendorsBankApi
                                  .addBanks(data: data, context: context)
                                  .then((value) async {
                                if (value != null) {
                                  GeneralLogics.showNotice(
                                    context: context,
                                    canDismiss: false,
                                    heading: 'Okay, Got It!',
                                    msg: value['message'],
                                    type: 'success',
                                    onContinue: () {
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                    },
                                  );
                                }
                                setState(() {
                                  _isLoading = false;
                                });
                              });
                            } else {}
                          },
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
