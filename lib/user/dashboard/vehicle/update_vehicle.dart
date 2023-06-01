import 'package:ceuk_user_app/core/design_system/color_shemes.dart';
import 'package:ceuk_user_app/core/logics/formValidationLogics.dart';
import 'package:ceuk_user_app/core/logics/generalLogics.dart';
import 'package:ceuk_user_app/shared/form/action_button.dart';
import 'package:ceuk_user_app/shared/form/text_input.dart';
import 'package:ceuk_user_app/user/dashboard/vehicle/vehicle_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UpdateVehicle extends StatefulWidget {
  const UpdateVehicle({Key key, this.vehicleData}) : super(key: key);
  final Map vehicleData;
  @override
  State<UpdateVehicle> createState() => _UpdateVehicleState();
}

class _UpdateVehicleState extends State<UpdateVehicle> {
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();

  TextEditingController vehiclePlateController = TextEditingController();
  TextEditingController vehicleModelController = TextEditingController();
  TextEditingController driverNameController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    vehiclePlateController.text = widget.vehicleData['plate_number'];
    vehicleModelController.text = widget.vehicleData['model'];
    driverNameController.text = widget.vehicleData['driver_name'];
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
                'Update Vehicle',
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
                        fieldTitle: 'Driver Name',
                        hintText: 'Enter driver name',
                        validator: FormValidationLogics.isEmpty,
                        hasController: true,
                        textController: driverNameController,
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
                                  VehicleApi vehicleApi = VehicleApi();
                                  Map<String, String> data = {
                                    // "plate_number": vehiclePlateController.text,
                                    // "model": vehicleModelController.text,
                                    "driver_name": driverNameController.text
                                  };
                                  setState(() {
                                    _isLoading = true;
                                  });
                                  await vehicleApi
                                      .updateVehicle(
                                          data: data,
                                          id: widget.vehicleData['id'],
                                          context: context)
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

// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:iconsax/iconsax.dart';

// class UpdateVehicle extends StatefulWidget {
//   const UpdateVehicle({Key key}) : super(key: key);

//   @override
//   _UpdateVehicleState createState() => _UpdateVehicleState();
// }

// class _UpdateVehicleState extends State<UpdateVehicle> {
//   int activeIndex = 0;

//   @override
//   void initState() {
//     Timer.periodic(const Duration(seconds: 5), (timer) {
//       setState(() {
//         activeIndex++;

//         if (activeIndex == 4) {
//           activeIndex = 0;
//         }
//       });
//     });

//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: SingleChildScrollView(
//       child: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           children: [
//             const SizedBox(
//               height: 50,
//             ),
//             SizedBox(
//               height: 350,
//               child: Stack(children: [
//                 Positioned(
//                   top: 0,
//                   left: 0,
//                   right: 0,
//                   bottom: 0,
//                   child: AnimatedOpacity(
//                     opacity: activeIndex == 0 ? 1 : 0,
//                     duration: const Duration(
//                       seconds: 1,
//                     ),
//                     curve: Curves.linear,
//                     child: Image.network(
//                       'https://ouch-cdn2.icons8.com/As6ct-Fovab32SIyMatjsqIaIjM9Jg1PblII8YAtBtQ/rs:fit:784:784/czM6Ly9pY29uczgu/b3VjaC1wcm9kLmFz/c2V0cy9zdmcvNTg4/LzNmMDU5Mzc0LTky/OTQtNDk5MC1hZGY2/LTA2YTkyMDZhNWZl/NC5zdmc.png',
//                       height: 400,
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                   top: 0,
//                   left: 0,
//                   right: 0,
//                   bottom: 0,
//                   child: AnimatedOpacity(
//                     opacity: activeIndex == 1 ? 1 : 0,
//                     duration: const Duration(seconds: 1),
//                     curve: Curves.linear,
//                     child: Image.network(
//                       'https://ouch-cdn2.icons8.com/vSx9H3yP2D4DgVoaFPbE4HVf6M4Phd-8uRjBZBnl83g/rs:fit:784:784/czM6Ly9pY29uczgu/b3VjaC1wcm9kLmFz/c2V0cy9zdmcvNC84/MzcwMTY5OS1kYmU1/LTQ1ZmEtYmQ1Ny04/NTFmNTNjMTlkNTcu/c3Zn.png',
//                       height: 400,
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                   top: 0,
//                   left: 0,
//                   right: 0,
//                   bottom: 0,
//                   child: AnimatedOpacity(
//                     opacity: activeIndex == 2 ? 1 : 0,
//                     duration: const Duration(seconds: 1),
//                     curve: Curves.linear,
//                     child: Image.network(
//                       'https://ouch-cdn2.icons8.com/fv7W4YUUpGVcNhmKcDGZp6pF1-IDEyCjSjtBB8-Kp_0/rs:fit:784:784/czM6Ly9pY29uczgu/b3VjaC1wcm9kLmFz/c2V0cy9zdmcvMTUv/ZjUzYTU4NDAtNjBl/Yy00ZWRhLWE1YWIt/ZGM1MWJmYjBiYjI2/LnN2Zw.png',
//                       height: 400,
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                   top: 0,
//                   left: 0,
//                   right: 0,
//                   bottom: 0,
//                   child: AnimatedOpacity(
//                     opacity: activeIndex == 3 ? 1 : 0,
//                     duration: const Duration(seconds: 1),
//                     curve: Curves.linear,
//                     child: Image.network(
//                       'https://ouch-cdn2.icons8.com/AVdOMf5ui4B7JJrNzYULVwT1z8NlGmlRYZTtg1F6z9E/rs:fit:784:767/czM6Ly9pY29uczgu/b3VjaC1wcm9kLmFz/c2V0cy9zdmcvOTY5/L2NlMTY1MWM5LTRl/ZjUtNGRmZi05MjQ3/LWYzNGQ1MzhiOTQ0/Mi5zdmc.png',
//                       height: 400,
//                     ),
//                   ),
//                 )
//               ]),
//             ),
//             const SizedBox(
//               height: 40,
//             ),
//             TextField(
//               cursorColor: Colors.black,
//               decoration: InputDecoration(
//                 contentPadding: const EdgeInsets.all(0.0),
//                 labelText: 'Email',
//                 hintText: 'Username or e-mail',
//                 labelStyle: const TextStyle(
//                   color: Colors.black,
//                   fontSize: 14.0,
//                   fontWeight: FontWeight.w400,
//                 ),
//                 hintStyle: const TextStyle(
//                   color: Colors.grey,
//                   fontSize: 14.0,
//                 ),
//                 prefixIcon: const Icon(
//                   Iconsax.user,
//                   color: Colors.black,
//                   size: 18,
//                 ),
//                 enabledBorder: OutlineInputBorder(
//                   borderSide: BorderSide(color: Colors.grey.shade200, width: 2),
//                   borderRadius: BorderRadius.circular(10.0),
//                 ),
//                 floatingLabelStyle: const TextStyle(
//                   color: Colors.black,
//                   fontSize: 18.0,
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderSide: const BorderSide(color: Colors.black, width: 1.5),
//                   borderRadius: BorderRadius.circular(10.0),
//                 ),
//               ),
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             TextField(
//               cursorColor: Colors.black,
//               decoration: InputDecoration(
//                 contentPadding: const EdgeInsets.all(0.0),
//                 labelText: 'Password',
//                 hintText: 'Password',
//                 hintStyle: const TextStyle(
//                   color: Colors.grey,
//                   fontSize: 14.0,
//                 ),
//                 labelStyle: const TextStyle(
//                   color: Colors.black,
//                   fontSize: 14.0,
//                   fontWeight: FontWeight.w400,
//                 ),
//                 prefixIcon: const Icon(
//                   Iconsax.key,
//                   color: Colors.black,
//                   size: 18,
//                 ),
//                 enabledBorder: OutlineInputBorder(
//                   borderSide: BorderSide(color: Colors.grey.shade200, width: 2),
//                   borderRadius: BorderRadius.circular(10.0),
//                 ),
//                 floatingLabelStyle: const TextStyle(
//                   color: Colors.black,
//                   fontSize: 18.0,
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderSide: const BorderSide(color: Colors.black, width: 1.5),
//                   borderRadius: BorderRadius.circular(10.0),
//                 ),
//               ),
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 TextButton(
//                   onPressed: () {},
//                   child: const Text(
//                     'Forgot Password?',
//                     style: TextStyle(
//                         color: Colors.black,
//                         fontSize: 14.0,
//                         fontWeight: FontWeight.w400),
//                   ),
//                 )
//               ],
//             ),
//             const SizedBox(
//               height: 30,
//             ),
//             MaterialButton(
//               onPressed: () {},
//               height: 45,
//               color: Colors.black,
//               padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(10.0),
//               ),
//               child: Text(
//                 "Login",
//                 style: TextStyle(color: Colors.white, fontSize: 16.0),
//               ),
//             ),
//             const SizedBox(
//               height: 30,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   'Don\'t have an account?',
//                   style: TextStyle(
//                       color: Colors.grey.shade600,
//                       fontSize: 14.0,
//                       fontWeight: FontWeight.w400),
//                 ),
//                 TextButton(
//                   onPressed: () {},
//                   child: const Text(
//                     'Register',
//                     style: TextStyle(
//                         color: Colors.blue,
//                         fontSize: 14.0,
//                         fontWeight: FontWeight.w400),
//                   ),
//                 )
//               ],
//             ),
//           ],
//         ),
//       ),
//     ));
//   }
// }
