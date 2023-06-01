import 'dart:io';

import 'package:ceuk_user_app/core/design_system/color_shemes.dart';
import 'package:ceuk_user_app/core/design_system/typography_style.dart';
import 'package:ceuk_user_app/core/logics/formValidationLogics.dart';
import 'package:ceuk_user_app/core/logics/generalLogics.dart';
import 'package:ceuk_user_app/shared/form/action_button.dart';
import 'package:ceuk_user_app/shared/form/dropdown_input.dart';
import 'package:ceuk_user_app/shared/form/dropdown_model.dart';
import 'package:ceuk_user_app/shared/form/text_input.dart';
import 'package:ceuk_user_app/user/dashboard/vehicle/vehicle_api.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconsax/iconsax.dart';
import 'package:path/path.dart' as path;

class AddVehicle extends StatefulWidget {
  const AddVehicle({Key key}) : super(key: key);

  @override
  State<AddVehicle> createState() => _AddVehicleState();
}

class _AddVehicleState extends State<AddVehicle> {
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();

  TextEditingController vehiclePlateController = TextEditingController();
  TextEditingController vehicleModelController = TextEditingController();
  TextEditingController driverNameController = TextEditingController();
  TextEditingController categoryController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getCategories();
  }

  List<DropdownModel> categoryList = [];
  getCategories() async {
    setState(() {
      _isLoading = true;
    });
    VehicleApi vehicleApi = VehicleApi();
    var res = await vehicleApi.getCategories(context: context);
    if (res != null) {
      setState(() {
        categoryList = [];
        for (var data in res['data']) {
          categoryList.add(
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

  File imageCamera;
  File vehicleImage;

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
                'Add Vehicle',
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
                  Text('Driver Photo',
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
                    fieldTitle: 'Driver Name',
                    hintText: 'Enter driver name',
                    validator: FormValidationLogics.isEmpty,
                    hasController: true,
                    textController: driverNameController,
                    onFieldChange: (input) {
                      return;
                    },
                  ),

                  DropDownInput(
                    //fieldKey: UniqueKey(),
                    enabled: !_isLoading,
                    fieldTitle: 'Category',
                    hintText: 'Category',
                    sheetTitle: 'Category',
                    showSearch: true,
                    //initialValue: selectedProdType.value,
                    //selectedValue: selectedProdType,
                    searchPlaceholder: 'Search category here',
                    optionsList: categoryList,
                    validator: (val) {
                      if (val == null || val.value.isEmpty) {
                        return 'Category is required';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      setState(() {
                        categoryController.text = value.value;
                        //print(brandController.text);
                      });

                      return value;
                    },
                  ),
                  Text('Vehicle Image',
                      style: TypographyStyle.bodyMediumn
                          .copyWith(fontSize: 15.sp)),
                  SizedBox(
                    height: 0.0055.sh,
                  ),
                  GestureDetector(
                    onTap: () async {
                      var photo = await GeneralLogics.takePicture();
                      setState(() {
                        vehicleImage = photo;
                      });
                    },
                    child: Container(
                      width: 1.sw,
                      height: 0.3.sh,
                      padding: const EdgeInsets.all(50),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        color: UIColors.secondary600,
                        border: Border.all(
                          color: vehicleImage == null
                              ? Colors.transparent
                              : UIColors.secondary600,
                        ),
                        image: vehicleImage != null
                            ? DecorationImage(
                                fit: BoxFit.cover,
                                image: FileImage(vehicleImage),
                              )
                            : null,
                      ),
                      child: vehicleImage != null
                          ? const SizedBox()
                          : Icon(
                              Iconsax.car,
                              size: 48,
                              color: vehicleImage == null
                                  ? UIColors.secondary400
                                  : Colors.transparent,
                            ),
                    ),
                  ),
                  SizedBox(
                    height: 0.02.sh,
                  ),
                  TextInputField(
                    fieldTitle: 'Vehicle Plate Number',
                    hintText: 'Enter plate number',
                    validator: FormValidationLogics.isEmpty,
                    hasController: true,
                    textController: vehiclePlateController,
                    onFieldChange: (input) {
                      return;
                    },
                  ),
                  TextInputField(
                    fieldTitle: 'Vehicle Model',
                    hintText: 'Enter vehicle model',
                    validator: FormValidationLogics.isEmpty,
                    hasController: true,
                    textController: vehicleModelController,
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
                              VehicleApi vehicleApi = VehicleApi();
                              Map<String, dynamic> data = {
                                "plate_number": vehiclePlateController.text,
                                "model": vehicleModelController.text,
                                "driver_name": driverNameController.text,
                                "category_id": categoryController.text,
                                "driver_image": await MultipartFile.fromFile(
                                  imageCamera.path,
                                  filename: path.basename(imageCamera.path),
                                ),
                                "vehicle_image": await MultipartFile.fromFile(
                                  vehicleImage.path,
                                  filename: path.basename(vehicleImage.path),
                                ),
                              };
                              setState(() {
                                _isLoading = true;
                              });

                              if (context.mounted) {
                                await vehicleApi
                                    .addVehicle(data: data, context: context)
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
                                });
                              }

                              setState(() {
                                _isLoading = false;
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
