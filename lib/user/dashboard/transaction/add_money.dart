import 'dart:ui';

import 'package:ceuk_user_app/core/design_system/color_shemes.dart';
import 'package:ceuk_user_app/core/design_system/typography_style.dart';
import 'package:ceuk_user_app/core/logics/formValidationLogics.dart';
import 'package:ceuk_user_app/core/logics/generalLogics.dart';
import 'package:ceuk_user_app/core/providers/user_data_provider.dart';
import 'package:ceuk_user_app/shared/form/action_button.dart';
import 'package:ceuk_user_app/shared/form/form_header.dart';
import 'package:ceuk_user_app/shared/form/text_input.dart';
import 'package:ceuk_user_app/user/dashboard/transaction/user_transactions_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class UserAddMoney extends StatefulWidget {
  const UserAddMoney({Key key}) : super(key: key);

  @override
  State<UserAddMoney> createState() => _RequestChannelsScreenState();
}

bool _isLoading = false;
final _formKey = GlobalKey<FormState>();

TextEditingController amountController = TextEditingController();

class _RequestChannelsScreenState extends State<UserAddMoney> {
  UserDataProvider userDataProvider;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    userDataProvider = Provider.of<UserDataProvider>(context);
  }

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      clipBehavior: Clip.hardEdge,
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 5,
          sigmaY: 5,
        ),
        child: SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 0.25.sh,
              ),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 23, vertical: 0.015.sh),
                  child: Text('Close',
                      textAlign: TextAlign.end,
                      style: TypographyStyle.bodyMediumn
                          .copyWith(color: UIColors.white)),
                ),
              ),
              Container(
                height: 0.65.sh,
                decoration: BoxDecoration(
                  color: UIColors.white,
                  borderRadius: BorderRadiusDirectional.only(
                    topStart: Radius.circular(30.r),
                    topEnd: Radius.circular(30.r),
                  ),
                ),
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                      horizontal: 0.058.sw, vertical: 0.040.sh),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        FormHeader(
                          title: 'Add Money',
                          hasCustomTitleSize: true,
                          titleFontSize: 23.sp,
                          description: 'Enter an amount to fund your wallet.',
                        ),

                        TextInputField(
                          fieldTitle: null,
                          hintText: 'Enter amount',
                          validator: FormValidationLogics.isEmpty,
                          hasController: true,
                          textController: amountController,
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
                                    UserTransactionsApi userTransactionsApi =
                                        UserTransactionsApi();
                                    Map<String, String> data = {
                                      "amount": amountController.text,
                                    };
                                    setState(() {
                                      _isLoading = true;
                                    });
                                    await userTransactionsApi
                                        .fundWallet(
                                            data: data, context: context)
                                        .then((value) async {
                                      if (value != null) {
                                        await GeneralLogics.refreshUserData(
                                                userDataProvider:
                                                    userDataProvider,
                                                context: context)
                                            .then((res) {
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
                                        });
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
