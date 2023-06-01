import 'package:animate_do/animate_do.dart';
import 'package:ceuk_user_app/core/design_system/color_shemes.dart';
import 'package:ceuk_user_app/core/logics/formValidationLogics.dart';
import 'package:ceuk_user_app/shared/form/action_button.dart';
import 'package:ceuk_user_app/shared/form/text_input.dart';
import 'package:ceuk_user_app/shared/form/textarea_input.dart';
import 'package:ceuk_user_app/user/dashboard/request/user_request_api.dart';
import 'package:ceuk_user_app/user_routes.dart';
import 'package:ceuk_user_app/vendor_staff/dashboard/request/staff_request_success_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VehicleSubmitRequestPage extends StatefulWidget {
  final Map data;

  const VehicleSubmitRequestPage({
    Key key,
    @required this.data,
  }) : super(key: key);

  @override
  _SingleRequestPageState createState() => _SingleRequestPageState();
}

class _SingleRequestPageState extends State<VehicleSubmitRequestPage> {
  TextEditingController amountController = TextEditingController();

  final FocusNode _focusNode = FocusNode();
  final TextEditingController _editingController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  bool isFocused = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _focusNode.requestFocus();
    _focusNode.addListener(onFocusChanged);
  }

  void onFocusChanged() {
    setState(() {
      isFocused = _focusNode.hasFocus;
    });
  }

  bool _isLoading = false;

  final TextEditingController optionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: false,
          title: const Text(
            'Fuelling',
            style: TextStyle(color: Colors.black),
          ),
          leading: const BackButton(
            color: Colors.black,
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 0.058.sw),
          child: SizedBox(
            width: double.infinity,
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 0.050.sh,
                  ),
                  FadeInDown(
                    from: 100,
                    duration: const Duration(milliseconds: 1000),
                    child: Container(
                      width: 0.13.sh,
                      height: 0.13.sh,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: UIColors.secondary600,
                          image: DecorationImage(
                              image:
                                  NetworkImage(widget.data['driver_image']))),
                    ),
                  ),
                  SizedBox(
                    height: 0.05.sh,
                  ),
                  FadeInUp(
                      from: 60,
                      delay: const Duration(milliseconds: 500),
                      duration: const Duration(milliseconds: 1000),
                      child: Text(
                        "Request for",
                        style: TextStyle(color: UIColors.secondary),
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  FadeInUp(
                      from: 30,
                      delay: const Duration(milliseconds: 800),
                      duration: const Duration(milliseconds: 1000),
                      child: Text(
                        widget.data['driver_name'],
                        style: TextStyle(
                            fontSize: 24.sp, fontWeight: FontWeight.bold),
                      )),
                  SizedBox(
                    height: 0.050.sh,
                  ),

/*
 keyboardType: const TextInputType.numberWithOptions(
                          signed: true, decimal: true),
                      inputFormatters: [ThousandsFormatter()],
*/
                  FadeInUp(
                    from: 40,
                    delay: const Duration(milliseconds: 800),
                    duration: const Duration(milliseconds: 1000),
                    child: TextInputField(
                      hintText: 'Enter Amount',
                      validator: FormValidationLogics.isEmpty,
                      hasController: true,
                      textController: amountController,
                      hintFontSize: 20.sp,
                      hintFontWeight: FontWeight.w700,
                      centerCursor: true,
                      onFieldChange: (input) {
                        return;
                      },
                    ),
                  ),

                  SizedBox(
                    height: 0.020.sh,
                  ),
                  // note textfield
                  FadeInUp(
                    from: 60,
                    delay: const Duration(milliseconds: 800),
                    duration: const Duration(milliseconds: 1000),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),

                        // // boxShadow:
                      ),
                      child: TextareaInputField(
                        hintText: 'Enter message (Optional)',
                        // validator: FormValidationLogics.isEmpty,
                        hasController: true,
                        textController: optionController,
                        onFieldChange: (input) {
                          return;
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  FadeInUp(
                    duration: const Duration(milliseconds: 1000),
                    child: ActionButton(
                      text: 'Make Request',
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
                                //

                                UserRequestApi userRequestApi =
                                    UserRequestApi();
                                Map<String, dynamic> data = {
                                  "amount": amountController.text,
                                  "vehicle_id": widget.data['id'],
                                  "description": optionController.text,
                                  "type": 'vehicle'
                                };

                                setState(() {
                                  _isLoading = true;
                                });
                                await userRequestApi
                                    .makeRequest(data: data, context: context)
                                    .then((value) async {
                                  if (value != null) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              StaffRequestSuccessPage(
                                            message: value['message'],
                                            onContinue: () {
                                              Navigator.of(context)
                                                  .pushNamedAndRemoveUntil(
                                                      UserRoutes.home,
                                                      (Route<dynamic> route) =>
                                                          false);
                                            },
                                          ),
                                        ));
                                  }
                                });
                                setState(() {
                                  _isLoading = false;
                                });
                              }
                            },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
