import 'package:at_your_home_partner/constants/constants.dart';
import 'package:at_your_home_partner/controller/login_controller.dart';
import 'package:at_your_home_partner/core/common_widgets/custom_buttons.dart';
import 'package:at_your_home_partner/core/common_widgets/custom_input_fields.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreateNewPasswordScreen extends StatefulWidget {
  const CreateNewPasswordScreen({super.key});

  @override
  State<CreateNewPasswordScreen> createState() => _CreateNewPasswordScreenState();
}

class _CreateNewPasswordScreenState extends State<CreateNewPasswordScreen> {
  final formKey = GlobalKey<FormState>();
  LoginController controller = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: Get.find<LoginController>(),
      initState: (state){
        Get.find<LoginController>();
      },
      builder: (contextCtr) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: lightFillCl,
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 11.h, width: MediaQuery.of(context).size.width),
                      Align(
                        alignment: Alignment.center,
                        child: Image.asset(
                          appLogo,
                          width: 66.w,
                          height: 59.h,
                        ),
                      ),
                      SizedBox(height: 70.h),
                      Align(alignment: Alignment.center, child: Image.asset(createPassImg, height: 154.h, width: 155.w, fit: BoxFit.cover)),
                      SizedBox(height: 35.h),
                      Text(
                        "Create New Password",
                        style: TextStyle(
                          color: Colors.black,
                          fontStyle: FontStyle.normal,
                          fontSize: 20.sp,
                          fontFamily: semiBold,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 30.h),
                      CustomTextField(
                        txKeyboardType: TextInputType.text,
                        controller: contextCtr.passwordNew,
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
                          } else if (contextCtr.passwordNew.text != contextCtr.confirmPassword.text) {
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
                      SizedBox(height: 70.h),
                      Container(
                        height: 44,
                        padding: const EdgeInsets.symmetric(horizontal: 17),
                        child: CustomButtonWidget(
                          padding: EdgeInsets.zero,
                          style: CustomButtonStyle.style2,
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                               controller.updatePassword();
                            }
                          },
                          text: 'Send OTP',
                          enabled: controller.mobile.text.isNotEmpty && controller.mobile.text.length >= 10,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }
    );
  }
}
