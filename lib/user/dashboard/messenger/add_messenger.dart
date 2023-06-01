import 'dart:io';

import 'package:ceuk_user_app/core/design_system/color_shemes.dart';
import 'package:ceuk_user_app/core/design_system/typography_style.dart';
import 'package:ceuk_user_app/core/logics/formValidationLogics.dart';
import 'package:ceuk_user_app/core/logics/generalLogics.dart';
import 'package:ceuk_user_app/shared/form/action_button.dart';
import 'package:ceuk_user_app/shared/form/email_input_field.dart';
import 'package:ceuk_user_app/shared/form/new_phone_input.dart';
import 'package:ceuk_user_app/shared/form/text_input.dart';
import 'package:ceuk_user_app/user/dashboard/messenger/messenger_api.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconsax/iconsax.dart';
import 'package:path/path.dart' as path;

class AddMessenger extends StatefulWidget {
  const AddMessenger({Key key}) : super(key: key);

  @override
  State<AddMessenger> createState() => _AddMessengerState();
}

class _AddMessengerState extends State<AddMessenger> {
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  TextEditingController fnController = TextEditingController();
  TextEditingController lnController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  File imageCamera;

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
                'Add Messenger',
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
                  Text('Photo',
                      style: TypographyStyle.bodyMediumn.copyWith(
                        fontSize: 15.sp,
                      )),
                  SizedBox(
                    height: 0.0055.sh,
                  ),
                  SizedBox(
                    width: 1.sw,
                    child: GestureDetector(
                      onTap: () async {
                        var photo = await GeneralLogics.takePicture();
                        setState(() {
                          imageCamera = photo;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(26),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: UIColors.secondary600,
                          border: Border.all(
                            color: imageCamera == null
                                ? Colors.transparent
                                : UIColors.secondary600,
                          ),
                          image: imageCamera != null
                              ? DecorationImage(
                                  fit: BoxFit.cover,
                                  image: FileImage(imageCamera),
                                )
                              : null,
                        ),
                        child: Icon(
                          Iconsax.user,
                          size: 0.04.sh,
                          color: imageCamera == null
                              ? UIColors.secondary400
                              : Colors.transparent,
                        ),
                      ),
                    ),
                  ),

                  TextInputField(
                    fieldTitle: 'Firstname',
                    hintText: 'Enter firstname name',
                    validator: FormValidationLogics.isEmpty,
                    hasController: true,
                    textController: fnController,
                    onFieldChange: (input) {
                      return;
                    },
                  ),

                  TextInputField(
                    fieldTitle: 'Lastname',
                    hintText: 'Enter lastname name',
                    validator: FormValidationLogics.isEmpty,
                    hasController: true,
                    textController: lnController,
                    onFieldChange: (input) {
                      return;
                    },
                  ),

                  EmailInputField(
                    fieldTitle: 'Email',
                    hintText: 'Enter email address',
                    validator: FormValidationLogics.isEmpty,
                    hasController: true,
                    textController: emailController,
                    onFieldChange: (input) {
                      return;
                    },
                  ),
                  NewPhoneInputField(
                    fieldTitle: 'Phone',
                    hintText: 'Enter phone',
                    onFieldChange: (input) {
                      phoneNumberController.text = '+234$input';
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
                              MessengerApi messengerApi = MessengerApi();
                              Map<String, dynamic> data = {
                                "first_name": fnController.text,
                                "last_name": lnController.text,
                                "phone_number": phoneNumberController.text,
                                "email": emailController.text,
                                "image": await MultipartFile.fromFile(
                                  imageCamera.path,
                                  filename: path.basename(imageCamera.path),
                                ),
                              };
                              setState(() {
                                _isLoading = true;
                              });
                              await messengerApi
                                  .addMessenger(data: data, context: context)
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
                                //log(value.toString());
                              });
                            } else {
                              //validation error
                            }
                          },
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
