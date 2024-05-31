
import 'package:at_your_home_partner/constants/constants.dart';
import 'package:at_your_home_partner/controller/login_controller.dart';
import 'package:at_your_home_partner/core/common_widgets/custom_buttons.dart';
import 'package:at_your_home_partner/service/api_logs.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';


class OTPScreen extends StatefulWidget {
  final String mobileNo;
  const OTPScreen({super.key, required this.mobileNo});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(loginBg),
            fit: BoxFit.fill,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
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
                  Align(alignment: Alignment.center, child: Image.asset(otpImg, height: 154.h, width: 155.w, fit: BoxFit.cover)),
                  SizedBox(height: 35.h),
                  Text(
                    "OTP Verification ",
                    style: TextStyle(
                      color: Colors.black,
                      fontStyle: FontStyle.normal,
                      fontSize: 20.sp,
                      fontFamily: semiBold,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: RichText(
                        text: TextSpan(
                            text: "Please enter the verification code sent to your mobile number ",
                            style: TextStyle(
                              color: greyColorTxt,
                              fontStyle: FontStyle.normal,
                              fontSize: 14.sp,
                              fontFamily: regular,
                              fontWeight: FontWeight.w400,
                            ),
                            children: [
                              TextSpan(
                                text: "+91 ${widget.mobileNo}",
                                style: TextStyle(
                                  color: blackCl,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 14.sp,
                                  fontFamily: semiBold,
                                  fontWeight: FontWeight.w600,
                                ),
                              )
                            ]),
                      )),
                  SizedBox(height: 46.h),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(horizontal: 25.w),
                    height: 48,
                    child: PinCodeTextField(
                      cursorColor: mainColor,
                      keyboardType: TextInputType.number,
                      obscureText: false,
                      obscuringCharacter: "*",
                      textStyle: const TextStyle(
                        color: mainColor,
                        fontSize: 14,
                        fontFamily: regular,
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.normal,
                      ),
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(16.dm),
                        fieldHeight: 48.h,
                        fieldWidth: 50.w,
                        disabledColor: borderColorCont,
                        fieldOuterPadding: const EdgeInsets.symmetric(horizontal: 6),
                        selectedFillColor: lightFillCl,
                        inactiveFillColor: lightFillCl,
                        activeFillColor: lightFillCl,
                        activeColor: mainColor,
                        inactiveColor: borderColorCont,
                        errorBorderColor: borderColorCont,
                        selectedColor: mainColor,
                        activeBorderWidth: 1,
                        selectedBorderWidth: 1,
                        disabledBorderWidth: 1,
                        inactiveBorderWidth: 1,
                        errorBorderWidth: 1,
                        borderWidth: 1,
                      ),
                      appContext: context,
                      length: 4,
                      onChanged: (String value) {
                        controller.otp = value;
                        Log.console(value);
                      },
                    ),
                  ),
                  SizedBox(height: 101.h),
                  Container(
                    height: 44,
                    padding: const EdgeInsets.symmetric(horizontal: 17),
                    child: CustomButtonWidget(
                      padding: EdgeInsets.zero,
                      style: CustomButtonStyle.style2,
                      onPressed: () {
                        controller.verifyOtp();
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
  }
}
