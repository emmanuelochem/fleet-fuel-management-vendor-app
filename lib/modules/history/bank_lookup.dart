import 'package:ceuk_user_app/core/design_system/color_shemes.dart';
import 'package:ceuk_user_app/core/design_system/typography_style.dart';
import 'package:ceuk_user_app/core/logics/formValidationLogics.dart';
import 'package:ceuk_user_app/core/network/api.dart';
import 'package:ceuk_user_app/core/providers/vstaff_data_provider.dart';
import 'package:ceuk_user_app/modules/history/banks_api.dart';
import 'package:ceuk_user_app/modules/history/request_processing.dart';
import 'package:ceuk_user_app/shared/form/action_button.dart';
import 'package:ceuk_user_app/shared/form/dropdown_input.dart';
import 'package:ceuk_user_app/shared/form/dropdown_model.dart';
import 'package:ceuk_user_app/shared/form/text_input.dart';
import 'package:ceuk_user_app/shared/widgets/general_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

class BankLookUp extends StatefulWidget {
  const BankLookUp({Key key, @required this.request}) : super(key: key);

  final Map request;

  @override
  State<BankLookUp> createState() => _BankLookUpState();
}

class _BankLookUpState extends State<BankLookUp> {
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();

  TextEditingController bankNameController = TextEditingController();
  TextEditingController bankCodeController = TextEditingController();
  TextEditingController accountNumberController = TextEditingController();
  TextEditingController accountNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getBanks();
  }

  StaffDataProvider staffDataProvider;
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    staffDataProvider = Provider.of<StaffDataProvider>(context);
  }

  List<DropdownModel> banksList = [];
  getBanks() async {
    setState(() {
      _isLoading = true;
    });
    Apis apis = Apis();
    var res = await apis.bank.getProviderBanks(context: context);
    if (res != null) {
      setState(() {
        banksList = [];
        for (var data in res['data']) {
          banksList.add(
            DropdownModel(
              name: data['bankName'],
              value: data['bankCode'].toString(),
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

  Map bankData = {};
  bool _isVerified = false;
  verifyBanks(Map data) async {
    setState(() {
      bankData = {};
      _isLoading = true;
      _isVerified = false;
    });
    BanksApi banksApi = BanksApi();
    var res = await banksApi.verifyBanks(data: data, context: context);
    if (res != null) {
      setState(() {
        bankData = res['data'];
        _isLoading = false;
        _isVerified = true;
      });
    } else {
      setState(() {
        _isLoading = false;
        _isVerified = false;
      });
    }
  }

  Future processPayment(Map data) async {
    Map<String, dynamic> newData = {
      "step": "1",
      "fund_recipients": data['bank'],
    };
    setState(() {
      _isLoading = true;
    });
    Apis apis = Apis();
    var resp = await apis.request.completeRequest(
      data: newData,
      id: data['request']['id'],
      context: context,
    );
    if (resp != null) {
      //log(value['data'].toString());
      await showMaterialModalBottomSheet(
        context: context,
        expand: false,
        isDismissible: false,
        enableDrag: false,
        //elevation: 10,
        backgroundColor: Colors.transparent,
        builder: (context) => RequestProcessingScreen(
          data: data,
        ),
      );
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => !_isLoading,
      child: Scaffold(
          backgroundColor: UIColors.secondary600,
          appBar: const GeneralAppBar(title: 'Transfer to Bank Account'),
          body: SingleChildScrollView(
            padding:
                EdgeInsets.symmetric(vertical: 0.02.sh, horizontal: 0.05.sw),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 1.sw,
                    padding: EdgeInsets.all(0.012.sh),
                    decoration: BoxDecoration(
                      color: UIColors.primary600,
                      borderRadius: BorderRadius.circular(5.r),
                    ),
                    child: Text(
                      'Transfer charges may apply',
                      textAlign: TextAlign.center,
                      style: TypographyStyle.bodyMediumn.copyWith(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: UIColors.primary200,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 0.03.sh,
                  ),
                  SizedBox(
                    height: 0.007.sh,
                  ),
                  Container(
                    width: 1.sw,
                    padding: EdgeInsets.all(0.048.sw),
                    decoration: BoxDecoration(
                      color: UIColors.white,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Recepient Account',
                          style: TypographyStyle.bodyMediumn.copyWith(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: UIColors.secondary200,
                          ),
                        ),
                        SizedBox(
                          height: 0.01.sh,
                        ),
                        TextInputField(
                          fieldTitle: null,
                          hintText: 'Enter 10 digits Account Number',
                          hintFontSize: 14.sp,
                          validator: FormValidationLogics.isEmpty,
                          hasController: true,
                          textController: accountNumberController,
                        ),
                        DropDownInput(
                          enabled: !_isLoading,
                          fieldTitle: null,
                          hintText: 'Select bank',
                          sheetTitle: 'Select bank',
                          showSearch: true,
                          searchPlaceholder: 'Search bank here',
                          optionsList: banksList,
                          validator: (val) {
                            if (val == null || val.value.isEmpty) {
                              return 'Bank is required';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            setState(() {
                              bankNameController.text = value.name;

                              bankCodeController.text = value.value;
                              //print(brandController.text);
                            });

                            return value;
                          },
                        ),
                        (bankData.isNotEmpty && _isVerified)
                            ? Container(
                                //height: 0.080.sh,
                                margin: EdgeInsets.only(bottom: 0.01.sh),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 0.032.sw,
                                  vertical: 0.012.sh,
                                ),
                                decoration: BoxDecoration(
                                    color: UIColors.primary600,
                                    borderRadius: BorderRadius.circular(15.r)),
                                child: Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 0.008.sh,
                                        vertical: 0.008.sh,
                                      ),
                                      decoration: BoxDecoration(
                                        color: UIColors.primary500,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        PhosphorIcons.user,
                                        color: UIColors.primary200,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 0.033.sw,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            (bankData['accountName'])
                                                .toUpperCase(),
                                            style: TypographyStyle.bodyMediumn
                                                .copyWith(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w600,
                                              color: UIColors.primary200,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 0.0015.sh,
                                          ),
                                          Text(
                                            accountNumberController.text,
                                            style: TypographyStyle.bodySmall
                                                .copyWith(
                                              fontSize: 11.sp,
                                              fontWeight: FontWeight.w400,
                                              color: UIColors.primary300,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : const SizedBox.shrink(),
                        SizedBox(height: 0.02.sh),
                        // const Spacer(),
                        ActionButton(
                          text: !_isVerified ? 'Verify Bank' : 'Pay',
                          backgroundColor: UIColors.primary,
                          textColor: UIColors.white,
                          shape: ButtonShape.squircle,
                          size: ButtonSizes.large,
                          isLoading: _isLoading,
                          onPressed: _isLoading
                              ? null
                              : !_isVerified
                                  ? () async {
                                      if (_formKey.currentState.validate()) {
                                        Map<String, String> data = {
                                          "code": bankCodeController.text,
                                          "account_number":
                                              accountNumberController.text,
                                        };
                                        await verifyBanks(data);
                                      }
                                    }
                                  : () async {
                                      FocusScopeNode currentFocus =
                                          FocusScope.of(context);
                                      if (!currentFocus.hasPrimaryFocus) {
                                        currentFocus.unfocus();
                                      }

                                      if (_formKey.currentState.validate()) {
                                        Map<String, String> bank = {
                                          "bank_name": bankNameController.text,
                                          "code": bankData['bankCode'],
                                          "account_number":
                                              bankData['accountNumber'],
                                          "account_name":
                                              bankData['accountName']
                                        };
                                        Map payload = {
                                          "request": widget.request,
                                          "bank": bank
                                        };

                                        await processPayment(payload);
                                      }
                                    },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
