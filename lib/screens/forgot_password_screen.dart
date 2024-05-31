import 'package:at_your_home_partner/constants/constants.dart';
import 'package:at_your_home_partner/controller/login_controller.dart';
import 'package:at_your_home_partner/core/common_widgets/custom_buttons.dart';
import 'package:at_your_home_partner/core/common_widgets/custom_input_fields.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final formKey = GlobalKey<FormState>();
  LoginController controller = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
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
                  Align(alignment: Alignment.center, child: Image.asset(forgotPasswordImg, height: 154.h, width: 155.w, fit: BoxFit.cover)),
                  SizedBox(height: 35.h),
                  Text(
                    "Forgot Password",
                    style: TextStyle(
                      color: Colors.black,
                      fontStyle: FontStyle.normal,
                      fontSize: 20.sp,
                      fontFamily: semiBold,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    "Please Enter Your Mobile Number To Receive a Verification Code",
                    style: TextStyle(
                      color: greyColorTxt,
                      fontStyle: FontStyle.normal,
                      fontSize: 14.sp,
                      fontFamily: regular,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 30.h),
                  CustomTextField(
                    txKeyboardType: TextInputType.number,
                    maxLength: 10,
                    labelWidget: Row(
                      children: [
                        Image.asset(
                          mobileIc,
                          height: 16.h,
                          width: 16.w,
                        ),
                        SizedBox(width: 5.w),
                        Text(
                          "Mobile Number",
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
                    hintText: "Enter Number",
                    controller: controller.mobile,
                    validator: (v) {
                      if (v!.isEmpty) {
                        return "Enter Number";
                      } else if (v.length < 10) {
                        return "Enter valid Mobile Number";
                      }
                      return null;
                    },
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
                           controller.forgotPassword();
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
}
