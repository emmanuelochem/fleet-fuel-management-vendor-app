import 'package:ceuk_user_app/core/design_system/color_shemes.dart';
import 'package:ceuk_user_app/core/design_system/typography_style.dart';
import 'package:ceuk_user_app/core/logics/formValidationLogics.dart';
import 'package:ceuk_user_app/core/logics/generalLogics.dart';
import 'package:ceuk_user_app/core/providers/vendor_data_provider.dart';
import 'package:ceuk_user_app/shared/form/dropdown_input.dart';
import 'package:ceuk_user_app/shared/form/dropdown_model.dart';
import 'package:ceuk_user_app/shared/form/textarea_input.dart';
import 'package:ceuk_user_app/vendor/authentication/views/vendor_auth_api.dart';
import 'package:ceuk_user_app/user_routes.dart';
import 'package:ceuk_user_app/shared/form/action_button.dart';
import 'package:ceuk_user_app/shared/form/password_input.dart';
import 'package:ceuk_user_app/shared/form/text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class VendorRegisterPage extends StatefulWidget {
  const VendorRegisterPage({Key key, @required this.phoneNumber})
      : super(key: key);
  final String phoneNumber;
  @override
  State<VendorRegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<VendorRegisterPage> {
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();

  TextEditingController companyController = TextEditingController();
  TextEditingController managerController = TextEditingController();
  TextEditingController managerPhoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController lgaController = TextEditingController();
  TextEditingController pumpsController = TextEditingController();
  TextEditingController brandController = TextEditingController();

  // TextEditingController fnameCtrlr = TextEditingController();

  // TextEditingController lnameCtrlr = TextEditingController();

  VendorDataProvider vendorDataProvider;
  List<DropdownModel> accountFilterList = [];

  @override
  didChangeDependencies() {
    super.didChangeDependencies();
    vendorDataProvider = context.read<VendorDataProvider>();
  }

  @override
  void initState() {
    super.initState();
    getBrands();
  }

  getBrands() async {
    setState(() {
      _isLoading = true;
    });
    VendorAuthApi vendorAuthApi = VendorAuthApi();
    var res = await vendorAuthApi.getBrands(context: context);
    if (res != null) {
      setState(() {
        accountFilterList = [];
        for (var data in res['data']) {
          accountFilterList.add(
            DropdownModel(
              name: data['name'],
              value: data['id'].toString(),
            ),
          );
        }
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
    }
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
                            UserRoutes.welcome,
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
                    'Personal Information',
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
                    'Please provide a valid information of your company.',
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
                    fieldTitle: 'Company name',
                    hintText: 'Enter your company name',
                    validator: FormValidationLogics.isEmpty,
                    hasController: true,
                    textController: companyController,
                    onFieldChange: (input) {
                      return;
                    },
                  ),

                  TextInputField(
                    fieldTitle: 'Manager name',
                    hintText: 'Enter your manager name',
                    validator: FormValidationLogics.isEmpty,
                    hasController: true,
                    textController: managerController,
                    onFieldChange: (input) {
                      return;
                    },
                  ),

                  TextInputField(
                    fieldTitle: 'Manager phone',
                    hintText: 'Enter manager phone',
                    validator: FormValidationLogics.isEmpty,
                    hasController: true,
                    textController: managerPhoneController,
                    onFieldChange: (input) {
                      return;
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

                  const SizedBox(
                    height: 50,
                  ),
                  Text('Station Information',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          fontSize: 18.sp)),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Please provide a valid information of your fueling station.',
                    textAlign: TextAlign.start,
                    style: TypographyStyle.bodyMediumn.copyWith(
                      fontSize: 15.sp,
                      color: UIColors.secondary300,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  DropDownInput(
                    //fieldKey: UniqueKey(),
                    enabled: !_isLoading,
                    fieldTitle: 'Brand',
                    hintText: 'Brand type',
                    sheetTitle: 'Brand Type',
                    showSearch: true,
                    //initialValue: selectedProdType.value,
                    //selectedValue: selectedProdType,
                    searchPlaceholder: 'Search brand here',
                    optionsList: accountFilterList,
                    validator: (val) {
                      if (val == null || val.value.isEmpty) {
                        return 'Brand is required';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      setState(() {
                        brandController.text = value.value;
                        //print(brandController.text);
                      });

                      return value;
                    },
                  ),
                  // TextInputField(
                  //   fieldTitle: 'Brand ID',
                  //   hintText: 'Enter your brand',
                  //   validator: FormValidationLogics.isEmail,
                  //   hasController: true,
                  //   textController: emailController,
                  //   onFieldChange: (input) {
                  //     return;
                  //   },
                  // ),
                  TextInputField(
                    fieldTitle: 'No. of pumps',
                    hintText: 'Enter no. of pumps',
                    validator: FormValidationLogics.isEmpty,
                    hasController: true,
                    textController: pumpsController,
                    onFieldChange: (input) {
                      return;
                    },
                  ),

                  TextareaInputField(
                    fieldTitle: 'Office Address',
                    hintText: 'Enter your address',
                    validator: FormValidationLogics.isEmpty,
                    hasController: true,
                    textController: addressController,
                    onFieldChange: (input) {
                      return;
                    },
                  ),
                  TextInputField(
                    fieldTitle: 'Local Government Area',
                    hintText: 'Enter LGA',
                    validator: FormValidationLogics.isEmpty,
                    hasController: true,
                    textController: lgaController,
                    onFieldChange: (input) {
                      return;
                    },
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
                              VendorAuthApi vendorAuthApi = VendorAuthApi();

                              Map<String, String> data = {
                                "company_name": companyController.text,
                                "manager_name": managerController.text,
                                "manager_phone": managerPhoneController.text,
                                "address": addressController.text,
                                "lga": lgaController.text,
                                "password": passwordController.text,
                                "no_of_pumps": pumpsController.text,
                                "brand_id": brandController.text
                              };
                              //log(data.toString());
                              setState(() {
                                _isLoading = true;
                              });
                              await vendorAuthApi
                                  .registerVendor(data: data, context: context)
                                  .then((value) async {
                                setState(() {
                                  _isLoading = false;
                                });
                                if (value != null) {
                                  //log(value.toString());

                                  await vendorAuthApi
                                      .getVendorData(context: context)
                                      .then((value) {
                                    if (value != null) {
                                      // print(res['data']);
                                      GeneralLogics.saveToken(
                                          value['data']['token']);
                                      GeneralLogics.setVendorData(
                                          vendorDataProvider, value['data']);
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
