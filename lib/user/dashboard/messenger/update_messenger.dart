import 'package:ceuk_user_app/core/design_system/color_shemes.dart';
import 'package:ceuk_user_app/core/logics/formValidationLogics.dart';
import 'package:ceuk_user_app/core/logics/generalLogics.dart';
import 'package:ceuk_user_app/shared/form/action_button.dart';
import 'package:ceuk_user_app/shared/form/text_input.dart';
import 'package:ceuk_user_app/user/dashboard/messenger/messenger_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UpdateMessenger extends StatefulWidget {
  const UpdateMessenger({Key key, this.messengerData}) : super(key: key);
  final Map messengerData;
  @override
  State<UpdateMessenger> createState() => _UpdateMessengerState();
}

class _UpdateMessengerState extends State<UpdateMessenger> {
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();

  TextEditingController vehiclePlateController = TextEditingController();
  TextEditingController vehicleModelController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    vehiclePlateController.text = widget.messengerData['phone_number'];
    vehicleModelController.text = widget.messengerData['email'];
    firstNameController.text = widget.messengerData['first_name'];
    lastNameController.text = widget.messengerData['last_name'];
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
                'Update Messenger',
                style: TextStyle(color: Colors.black, fontSize: 18.sp),
              )),
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
                      // TextInputField(
                      //   fieldTitle: 'Vehicle Plate Number',
                      //   hintText: 'Enter plate number',
                      //   validator: FormValidationLogics.isEmpty,
                      //   hasController: true,
                      //   textController: vehiclePlateController,
                      //   onFieldChange: (input) {
                      //     return;
                      //   },
                      // ),
                      // TextInputField(
                      //   fieldTitle: 'Vehicle Model',
                      //   hintText: 'Enter vehicle model',
                      //   validator: FormValidationLogics.isEmpty,
                      //   hasController: true,
                      //   textController: vehicleModelController,
                      //   onFieldChange: (input) {
                      //     return;
                      //   },
                      // ),
                      TextInputField(
                        fieldTitle: 'Firstname',
                        hintText: 'Enter firstname',
                        validator: FormValidationLogics.isEmpty,
                        hasController: true,
                        textController: firstNameController,
                        onFieldChange: (input) {
                          return;
                        },
                      ),
                      TextInputField(
                        fieldTitle: 'Lastname',
                        hintText: 'Enter lastname',
                        validator: FormValidationLogics.isEmpty,
                        hasController: true,
                        textController: lastNameController,
                        onFieldChange: (input) {
                          return;
                        },
                      ),
                      SizedBox(height: 0.04.sh),
                      // const Spacer(),
                      ActionButton(
                        text: 'Update',
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
                                  Map<String, String> data = {
                                    // "plate_number": vehiclePlateController.text,
                                    "first_name": firstNameController.text,
                                    "last_name": lastNameController.text
                                  };
                                  setState(() {
                                    _isLoading = true;
                                  });
                                  await messengerApi
                                      .updateMessenger(
                                    data: data,
                                    id: widget.messengerData['id'],
                                    context: context,
                                  )
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
              ),
            ),
          )),
    );
  }
}
