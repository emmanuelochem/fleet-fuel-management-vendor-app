import 'package:ceuk_user_app/core/design_system/color_shemes.dart';
import 'package:ceuk_user_app/core/design_system/typography_style.dart';
import 'package:ceuk_user_app/core/logics/formValidationLogics.dart';
import 'package:ceuk_user_app/core/logics/generalLogics.dart';
import 'package:ceuk_user_app/core/providers/user_data_provider.dart';
import 'package:ceuk_user_app/shared/form/action_button.dart';
import 'package:ceuk_user_app/shared/form/password_input.dart';
import 'package:ceuk_user_app/shared/form/text_input.dart';
import 'package:ceuk_user_app/user/authentication/api/auth_api.dart';
import 'package:ceuk_user_app/user_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class UserRegisterPage extends StatefulWidget {
  const UserRegisterPage({
    Key key,
  }) : super(key: key);

  @override
  State<UserRegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<UserRegisterPage> {
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();

  TextEditingController fnController = TextEditingController();
  TextEditingController lnController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  UserDataProvider userDataProvider;

  @override
  void initState() {
    super.initState();
    phoneController.text = '';
  }

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
                    'Profile',
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
                    'Please provide a valid information',
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
                    'Please provide a secured information to enable you login.',
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
                                "first_name": fnController.text,
                                "last_name": lnController.text,
                                "email": emailController.text,
                                "phone_number": phoneController.text,
                                "password": passController.text
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
                                  //log(value.toString());
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
