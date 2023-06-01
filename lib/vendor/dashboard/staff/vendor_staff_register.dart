import 'package:ceuk_user_app/core/design_system/color_shemes.dart';
import 'package:ceuk_user_app/core/design_system/typography_style.dart';
import 'package:ceuk_user_app/core/logics/formValidationLogics.dart';
import 'package:ceuk_user_app/core/logics/generalLogics.dart';
import 'package:ceuk_user_app/core/providers/vendor_data_provider.dart';
import 'package:ceuk_user_app/shared/form/action_button.dart';
import 'package:ceuk_user_app/shared/form/password_input.dart';
import 'package:ceuk_user_app/shared/form/text_input.dart';
import 'package:ceuk_user_app/vendor/dashboard/staff/vendor_staffs_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class VendorAddStaffPage extends StatefulWidget {
  const VendorAddStaffPage({
    Key key,
  }) : super(key: key);

  @override
  State<VendorAddStaffPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<VendorAddStaffPage> {
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();

  TextEditingController fnController = TextEditingController();
  TextEditingController lnController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  VendorDataProvider vendorDataProvider;

  @override
  didChangeDependencies() {
    super.didChangeDependencies();
    vendorDataProvider = context.read<VendorDataProvider>();
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
                          Navigator.pop(
                            context,
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
                  // const FormHeader(
                  //   title: 'Complete profile',
                  //   centerTitle: false,
                  //   description:
                  //       'Please provide a valid information of your company.',
                  // ),

                  Text(
                    'Staff Profile',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      fontSize: 18.sp,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Please provide the valid information of your staff.',
                    textAlign: TextAlign.start,
                    style: TypographyStyle.bodyMediumn.copyWith(
                      fontSize: 15.sp,
                      color: UIColors.secondary300,
                    ),
                  ),

                  const SizedBox(
                    height: 30,
                  ),
                  TextInputField(
                    fieldTitle: 'Firstname',
                    hintText: 'Enter firstname',
                    validator: FormValidationLogics.isEmpty,
                    hasController: true,
                    textController: fnController,
                    onFieldChange: (input) {
                      return;
                    },
                  ),

                  TextInputField(
                    fieldTitle: 'Lastname',
                    hintText: 'Enter lastname',
                    validator: FormValidationLogics.isEmpty,
                    hasController: true,
                    textController: lnController,
                    onFieldChange: (input) {
                      return;
                    },
                  ),

                  TextInputField(
                    fieldTitle: 'Email',
                    hintText: 'Enter email',
                    validator: FormValidationLogics.isEmpty,
                    hasController: true,
                    textController: emailController,
                    onFieldChange: (input) {
                      return;
                    },
                  ),

                  const SizedBox(
                    height: 50,
                  ),
                  Text('Login Information',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          fontSize: 18.sp)),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Please provide a secured information to enable your staff login.',
                    textAlign: TextAlign.start,
                    style: TypographyStyle.bodyMediumn.copyWith(
                      fontSize: 15.sp,
                      color: UIColors.secondary300,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextInputField(
                    fieldTitle: 'Phone No.',
                    hintText: 'Enter phone',
                    validator: FormValidationLogics.isEmpty,
                    hasController: true,
                    textController: phoneController,
                    onFieldChange: (input) {
                      return;
                    },
                  ),

                  PasswordInputField(
                    fieldTitle: 'Password',
                    hintText: 'Enter password',
                    validator: FormValidationLogics.isEmpty,
                    hasController: true,
                    textController: passController,
                    onFieldChange: (input) {},
                  ),

                  SizedBox(height: 0.04.sh),
                  // const Spacer(),
                  ActionButton(
                    text: 'Register Staff',
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
                              VendorStaffsApi vendorStaffsApi =
                                  VendorStaffsApi();
                              Map<String, String> data = {
                                "first_name": fnController.text,
                                "last_name": lnController.text,
                                "email": emailController.text,
                                "phone_number": phoneController.text,
                                "password": passController.text,
                              };
                              setState(() {
                                _isLoading = true;
                              });
                              await vendorStaffsApi
                                  .addStaff(data: data, context: context)
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
