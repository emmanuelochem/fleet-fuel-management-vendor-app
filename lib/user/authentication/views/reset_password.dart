import 'package:ceuk_user_app/core/design_system/color_shemes.dart';
import 'package:ceuk_user_app/core/design_system/typography_style.dart';
import 'package:ceuk_user_app/core/logics/formValidationLogics.dart';
import 'package:ceuk_user_app/user_routes.dart';
import 'package:ceuk_user_app/shared/form/action_button.dart';
import 'package:ceuk_user_app/shared/form/back_button.dart';
import 'package:ceuk_user_app/shared/form/form_header.dart';
import 'package:ceuk_user_app/shared/form/number_input_field.dart';
import 'package:ceuk_user_app/shared/form/password_input.dart';
import 'package:ceuk_user_app/shared/form/snack_bar.dart';
import 'package:ceuk_user_app/shared/form/text_input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_overlay/loading_overlay.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();

  final otpController = TextEditingController();

  final passwordController = TextEditingController();

  final phoneController = TextEditingController();

  bool _isLoading = false;

  final bool _obscureT = true;

  bool _emailSent = false;

  Widget confirmModal() {
    return Container(
      padding: MediaQuery.of(context).viewInsets,
      child: SingleChildScrollView(
        child: Container(
          height: 0.8.sh,
          padding: EdgeInsets.symmetric(vertical: 0.05.sh, horizontal: 0.06.sh),
          child: Column(
            children: <Widget>[
              const Text('Complete Password Reset',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      fontSize: 18)),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'A six (6) digits pin has been sent to your  email, kindly input the pin and your new password below.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 25),
              TextFormField(
                controller: otpController,
                maxLength: 6,
                validator: FormValidationLogics.isOTP,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  counterText: '',
                  //
                  labelText: 'Enter Pin',
                ),
              ),
              const SizedBox(
                height: 25,
              ),

              ///Form
              const SizedBox(
                height: 20,
              ),
              const SizedBox(
                height: 10,
              ),
              ActionButton(
                text: 'Reset Password',
                backgroundColor: Colors.grey.shade900,
                textColor: UIColors.white,
                shape: ButtonShape.squircle,
                size: ButtonSizes.large,
                isLoading: _isLoading,
                onPressed: _isLoading
                    ? () => null
                    : () async {
                        FocusScopeNode currentFocus = FocusScope.of(context);

                        if (!currentFocus.hasPrimaryFocus) {
                          currentFocus.unfocus();
                        }

                        if (_formKey.currentState.validate()) {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              UserRoutes.login,
                              (Route<dynamic> route) => false);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  backgroundColor: Colors.red,
                                  content: Text('Email fields is required.')));
                          setState(() {
                            _isLoading = false;
                          });
                        }
                        // Navigator.pushNamed(context, '/reset-password');
                      },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: const GoBack(),
          iconTheme: const IconThemeData(color: Colors.black),
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.transparent,
          actions: const [],
        ),
        body: LoadingOverlay(
          isLoading: _isLoading,
          opacity: 0.8,
          color: Colors.black87,
          progressIndicator: const CupertinoActivityIndicator(
            animating: true,
            color: Colors.white,
          ),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 0.050.sw,
                  vertical: 0.030.sh,
                ),
                child: Visibility(
                  visible: !_emailSent,
                  replacement: _completeReset(context),
                  child: _initReset(context),
                ),
              ),
            ),
          ),
        ));
  }

  Column _initReset(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const FormHeader(
            title: 'Lost Password',
            description:
                'Please provide your account email address below to receive an OTP for password reset.',
          ),
          SizedBox(
            height: 0.019.sh,
          ),
          TextInputField(
            fieldTitle: 'Email Address',
            hintText: 'Enter your email address',
            validator: FormValidationLogics.isEmail,
            hasController: true,
            textController: emailController,
            onFieldChange: (input) {
              return;
            },
          ),
          SizedBox(
            height: 0.040.sh,
          ),
          ActionButton(
              text: 'Continue',
              backgroundColor: Colors.grey.shade900,
              textColor: UIColors.white,
              shape: ButtonShape.squircle,
              size: ButtonSizes.large,
              isLoading: _isLoading,
              onPressed: () async {
                FocusScopeNode currentFocus = FocusScope.of(context);

                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }
                if (_formKey.currentState.validate()) {
                } else {
                  FlushBar.showSnackBar(
                    message: 'Email address is required',
                    context: context,
                    type: FlushbarType.error,
                  );
                  setState(() {
                    _isLoading = false;
                    _emailSent = false;
                  });
                }
              }),
        ]);
  }

  Column _completeReset(BuildContext context) {
    return Column(
      children: <Widget>[
        FormHeader(
          title: 'Complete Password Reset',
          description:
              'Please provide the OTP sent to ${emailController.text.toString()} below alongside your new password.',
        ),
        const SizedBox(height: 25),
        Stack(
          children: [
            Positioned(
              top: 0,
              right: 10,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _emailSent = false;
                    _isLoading = false;
                  });
                },
                child: Text(
                  'Resend OTP',
                  style: TypographyStyle.bodySmall.copyWith(
                    color: Colors.grey.shade900,
                    fontSize: 15.sp,
                  ),
                ),
              ),
            ),
            NumberInputField(
              fieldTitle: 'Enter OTP',
              hintText: 'Enter your OTP',
              validator: FormValidationLogics.isOTP,
              hasController: true,
              textController: otpController,
              onFieldChange: (input) {
                return;
              },
            ),
          ],
        ),
        const SizedBox(
          height: 25,
        ),
        PasswordInputField(
          fieldTitle: 'New Password',
          hintText: 'Enter new Password',
          validator: FormValidationLogics.isEmpty,
          hasController: true,
          textController: passwordController,
          onFieldChange: (input) {},
        ),
        const SizedBox(
          height: 20,
        ),
        const SizedBox(
          height: 10,
        ),
        ActionButton(
          text: 'Change Password',
          backgroundColor: Colors.grey.shade900,
          textColor: UIColors.white,
          shape: ButtonShape.squircle,
          size: ButtonSizes.large,
          isLoading: _isLoading,
          onPressed: _isLoading
              ? () => null
              : () async {
                  FocusScopeNode currentFocus = FocusScope.of(context);

                  if (!currentFocus.hasPrimaryFocus) {
                    currentFocus.unfocus();
                  }

                  if (_formKey.currentState.validate()) {
                  } else {
                    FlushBar.showSnackBar(
                      message: 'Email fields is required.',
                      context: context,
                      type: FlushbarType.error,
                    );
                    setState(() {
                      _isLoading = false;
                    });
                  }
                },
        ),
      ],
    );
  }
}
