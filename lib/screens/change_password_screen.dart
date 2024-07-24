
import 'package:at_your_home_partner/constants/constants.dart';
import 'package:at_your_home_partner/controller/user_controller.dart';
import 'package:at_your_home_partner/core/common_widgets/custom_buttons.dart';
import 'package:at_your_home_partner/core/common_widgets/custom_input_fields.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  UserController controller = Get.put(UserController());
  final formKey = GlobalKey<FormState>();



  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: Get.find<UserController>(),
        initState: (state) {
          Get.find<UserController>();
        },
        builder: (contextCtr) {
          return SafeArea(
            child: Scaffold(
              backgroundColor: whiteCl,
              appBar: AppBar(
                backgroundColor: appBar,
                automaticallyImplyLeading: false,
                leadingWidth: MediaQuery.of(context).size.width,
                leading: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Image.asset(
                          arrowBackIc,
                          height: 26.h,
                          width: 26.w,
                        ),
                      ),
                      SizedBox(width: 13.w),
                      Text(
                        "Change Password",
                        style: TextStyle(
                          color: whiteCl,
                          fontStyle: FontStyle.normal,
                          fontSize: 18.sp,
                          fontFamily: semiBold,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              body: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 25.h),
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Old Password",
                          style: TextStyle(
                            color: blackCl,
                            fontStyle: FontStyle.normal,
                            fontSize: 16.sp,
                            fontFamily: semiBold,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 24.h),
                        CustomTextField(
                          txKeyboardType: TextInputType.text,
                          isEnabled: true,
                          validator: (v) {
                            if (v!.isEmpty) {
                              return "Enter Password";
                            }
                            return null;
                          },
                          labelWidget: Row(
                            children: [
                              Image.asset(
                                passwordIc,
                                height: 16.h,
                                width: 16.w,
                              ),
                              SizedBox(width: 5.w),
                              Text(
                                "Password",
                                style: TextStyle(
                                  color: mainColor,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 12.sp,
                                  fontFamily: regular,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          hintText: "Enter Old Password",
                          controller: contextCtr.oldPassword,
                        ),
                        SizedBox(height: 24.h),
                        Text(
                          "Create New Password",
                          style: TextStyle(
                            color: blackCl,
                            fontStyle: FontStyle.normal,
                            fontSize: 16.sp,
                            fontFamily: semiBold,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 24.h),
                        CustomTextField(
                          txKeyboardType: TextInputType.text,
                          controller: contextCtr.password,
                          labelWidget: Row(
                            children: [
                              Image.asset(
                                passwordIc,
                                height: 16.h,
                                width: 16.w,
                              ),
                              SizedBox(width: 5.w),
                              Text(
                                "Password",
                                style: TextStyle(
                                  color: mainColor,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 12.sp,
                                  fontFamily: regular,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          hintText: "Enter Password",
                          validator: (v) {
                            if (v!.isEmpty) {
                              return "Enter Password";
                            }
                            return null;
                          },
                          leading1: Image.asset(
                            phEye,
                            height: 20.h,
                            width: 20.w,
                          ),
                        ),
                        SizedBox(height: 12.h),
                        CustomTextField(
                          txKeyboardType: TextInputType.text,
                          controller: contextCtr.confirmPassword,
                          labelWidget: Row(
                            children: [
                              Image.asset(
                                passwordIc,
                                height: 16.h,
                                width: 16.w,
                              ),
                              SizedBox(width: 5.w),
                              Text(
                                "Confirm Password",
                                style: TextStyle(
                                  color: mainColor,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 12.sp,
                                  fontFamily: regular,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          hintText: "Confirm Password",
                          validator: (v) {
                            if (v!.isEmpty) {
                              return "Enter Confirm Password";
                            } else if (contextCtr.password.text != contextCtr.confirmPassword.text) {
                              return "Password MissMatch";
                            }
                            return null;
                          },
                          leading1: Image.asset(
                            phEye,
                            height: 20.h,
                            width: 20.w,
                          ),
                        ),
                        SizedBox(height: 56.h),
                        Container(
                          height: 44,
                          padding: const EdgeInsets.symmetric(horizontal: 17),
                          child: CustomButtonWidget(
                            padding: EdgeInsets.zero,
                            style: CustomButtonStyle.style2,
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                contextCtr.vendorChangePassword();
                              }
                            },
                            text: 'Submit',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
