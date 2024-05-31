import 'package:at_your_home_partner/constants/constants.dart';
import 'package:at_your_home_partner/controller/login_controller.dart';
import 'package:at_your_home_partner/core/common_widgets/custom_buttons.dart';
import 'package:at_your_home_partner/core/common_widgets/custom_input_fields.dart';
import 'package:at_your_home_partner/screens/forgot_password_screen.dart';
import 'package:at_your_home_partner/screens/sign_up_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  LoginController controller = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
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
                        )),
                    SizedBox(height: 49.h),
                    RichText(
                      text: TextSpan(
                        text: "Login Welcome Back ",
                        style: TextStyle(
                          color: Colors.black,
                          fontStyle: FontStyle.normal,
                          fontSize: 20.sp,
                          fontFamily: semiBold,
                          fontWeight: FontWeight.w600,
                        ),
                        children: [
                          TextSpan(
                            text: "to Partner ",
                            style: TextStyle(
                              color: mainColor,
                              fontStyle: FontStyle.normal,
                              fontSize: 20.sp,
                              fontFamily: semiBold,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      "Discover Your Dream Job Here",
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
                      txKeyboardType: TextInputType.text,
                      labelWidget: Row(
                        children: [
                          Image.asset(
                            idIc,
                            height: 16.h,
                            width: 16.w,
                          ),
                          SizedBox(width: 5.w),
                          Text(
                            "Vendor ID",
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
                      hintText: "Enter Vendor ID",
                      controller: controller.vendorId,
                      validator: (v) {
                        if (v!.isEmpty) {
                          return "Enter Vendor ID";
                        }
                        return null;
                      },
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
                    SizedBox(height: 30.h),
                    CustomTextField(
                      txKeyboardType: TextInputType.text,
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
                      controller: controller.password,
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
                    SizedBox(height: 13.h),
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: (){
                          Get.to(()=>const ForgotPasswordScreen());
                        },
                        child: Text(
                          "Forgot Password ?",
                          style: TextStyle(
                            color: cancelBorderCl,
                            fontStyle: FontStyle.normal,
                            fontSize: 12.sp,
                            fontFamily: regular,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 67.h),
                    Container(
                      height: 44,
                      padding: const EdgeInsets.symmetric(horizontal: 17),
                      child: CustomButtonWidget(
                        padding: EdgeInsets.zero,
                        style: CustomButtonStyle.style2,
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                              controller.login();
                          }
                        },
                        text: 'Continue',
                        enabled: controller.mobile.text.isNotEmpty && controller.mobile.text.length >= 10,
                      ),
                    ),
                    SizedBox(height: 67.h),
                    Align(
                      alignment: Alignment.center,
                      child: GestureDetector(
                        onTap: () {
                          Get.to(() => const SignUpScreen());
                        },
                        child: RichText(
                          text: TextSpan(
                            text: "If You Have Don’t Have Account? ",
                            style: TextStyle(
                              color: Colors.black,
                              fontStyle: FontStyle.normal,
                              fontSize: 14.sp,
                              fontFamily: semiBold,
                              fontWeight: FontWeight.w600,
                            ),
                            children: [
                              TextSpan(
                                text: "Sign up",
                                style: TextStyle(
                                  color: mainColor,
                                  decoration: TextDecoration.underline,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 14.sp,
                                  fontFamily: semiBold,
                                  fontWeight: FontWeight.w600,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 70.h),
                    /*  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 17),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          LabeledCheckbox(
                            label: '',
                            value: isCheck!,
                            onChanged: (v) {
                              setState(() {
                                isCheck = v;
                              });
                            },
                          ),
                          SizedBox(width: 6.w),
                          Expanded(
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                style: TextStyle(fontSize: 12.sp, fontFamily: regular, fontWeight: FontWeight.w400, fontStyle: FontStyle.normal, color: greyColorTxt),
                                children: <TextSpan>[
                                  const TextSpan(text: 'By Continuing , you have read and agree to the '),
                                  TextSpan(
                                      text: 'Privacy Policy, ',
                                      style: TextStyle(fontSize: 12.sp, fontFamily: regular, fontWeight: FontWeight.w400, fontStyle: FontStyle.normal, color: mainColor),
                                      recognizer: TapGestureRecognizer()..onTap = () {}),
                                  TextSpan(
                                      text: 'Terms of Use ',
                                      style: TextStyle(fontSize: 12.sp, fontFamily: regular, fontWeight: FontWeight.w400, fontStyle: FontStyle.normal, color: mainColor),
                                      recognizer: TapGestureRecognizer()..onTap = () {}),
                                  const TextSpan(text: ' And '),
                                  TextSpan(
                                      text: 'Terms and condition.',
                                      style: TextStyle(fontSize: 12.sp, fontFamily: regular, fontWeight: FontWeight.w400, fontStyle: FontStyle.normal, color: mainColor),
                                      recognizer: TapGestureRecognizer()..onTap = () {}),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    )*/
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class LabeledCheckbox extends StatelessWidget {
  const LabeledCheckbox({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final bool value;
  final Function(bool) onChanged;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onChanged(!value);
      },
      child: Container(
        height: 16,
        width: 16,
        decoration: BoxDecoration(
          color: value ? mainColor : Colors.transparent,
          border: Border.all(color: mainColor),
          borderRadius: BorderRadius.circular(2),
        ),
        child: value
            ? Center(
                child: Image.asset(
                  doneIc,
                  width: 12,
                  height: 12,
                  color: Colors.white,
                ),
              )
            : const Opacity(
                opacity: 0.0,
                child: Icon(
                  Icons.account_circle,
                  size: 14,
                  color: Colors.white,
                ),
              ),
      ),
    );
  }
}
