import 'dart:ui';

import 'package:ceuk_user_app/core/design_system/color_shemes.dart';
import 'package:ceuk_user_app/core/design_system/typography_style.dart';
import 'package:ceuk_user_app/core/logics/formValidationLogics.dart';
import 'package:ceuk_user_app/core/providers/vstaff_data_provider.dart';
import 'package:ceuk_user_app/shared/form/action_button.dart';
import 'package:ceuk_user_app/shared/form/form_header.dart';
import 'package:ceuk_user_app/shared/form/text_input.dart';
import 'package:ceuk_user_app/staffs_routes.dart';
import 'package:ceuk_user_app/vendor_staff/dashboard/request/staff_request_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class StaffSearchRequest extends StatefulWidget {
  const StaffSearchRequest({Key key}) : super(key: key);

  @override
  State<StaffSearchRequest> createState() => _RequestChannelsScreenState();
}

bool _isLoading = false;
final _formKey = GlobalKey<FormState>();

TextEditingController amountController = TextEditingController();

class _RequestChannelsScreenState extends State<StaffSearchRequest> {
  StaffDataProvider staffDataProvider;

  @override
  didChangeDependencies() {
    super.didChangeDependencies();
    staffDataProvider = context.read<StaffDataProvider>();
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
                          title: 'Find Request',
                          hasCustomTitleSize: true,
                          titleFontSize: 23.sp,
                          description:
                              'Enter the request code sent to the customer.',
                        ),

                        TextInputField(
                          fieldTitle: null,
                          hintText: 'Enter code',
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
                          text: 'Continue',
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
                                    StaffsRequestApi staffsRequestApi =
                                        StaffsRequestApi();
                                    String code = amountController.text;
                                    setState(() {
                                      _isLoading = true;
                                    });

                                    await staffsRequestApi
                                        .findRequest(
                                            code: code, context: context)
                                        .then((value) async {
                                      if (value != null) {
                                        Navigator.pop(context);
                                        Navigator.pushNamed(context,
                                            StaffsRoutes.requestDetails,
                                            arguments: <String, dynamic>{
                                              'requestData': value['data']
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
