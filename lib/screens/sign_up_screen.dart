import 'package:at_your_home_partner/constants/constants.dart';
import 'package:at_your_home_partner/controller/login_controller.dart';
import 'package:at_your_home_partner/core/common_widgets/custom_buttons.dart';
import 'package:at_your_home_partner/core/common_widgets/custom_input_fields.dart';
import 'package:at_your_home_partner/model/city_model.dart';
import 'package:at_your_home_partner/model/state_model.dart';
import 'package:at_your_home_partner/screens/upload_doc_screen.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  LoginController controller = Get.put(LoginController());
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: Get.find<LoginController>(),
        initState: (state) {
          Get.find<LoginController>().statesList();
        },
        builder: (contextCtr) {
          return SafeArea(
            child: Scaffold(
              backgroundColor: lightFillCl,
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
                            text: "Sign up Welcome ",
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
                                userOutlineIc,
                                height: 16.h,
                                width: 16.w,
                              ),
                              SizedBox(width: 5.w),
                              Text(
                                "Name",
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
                          hintText: "Enter Full Name",
                          controller: controller.registerName,
                          validator: (v) {
                            if (v!.isEmpty) {
                              return "Enter Full Name";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20.h),
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
                          controller: controller.registerMobile,
                          validator: (v) {
                            if (v!.isEmpty) {
                              return "Enter Number";
                            } else if (v.length < 10) {
                              return "Enter valid Mobile Number";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20.h),
                        CustomTextField(
                          txKeyboardType: TextInputType.emailAddress,
                          controller: contextCtr.email,
                          labelWidget: Row(
                            children: [
                              Image.asset(
                                iconEmail,
                                height: 16.h,
                                width: 16.w,
                              ),
                              SizedBox(width: 5.w),
                              Text(
                                "Email Address",
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
                          hintText: "Enter Email Address",
                          validator: contextCtr.emailValidator,
                        ),
                        SizedBox(height: 20.h),
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
                          controller: controller.registerPassword,
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
                        SizedBox(height: 20.h),
                        CustomTextField(
                          txKeyboardType: TextInputType.text,
                          labelWidget: Row(
                            children: [
                              Image.asset(
                                hospitalIc,
                                height: 16.h,
                                width: 16.w,
                              ),
                              SizedBox(width: 5.w),
                              Text(
                                "Business Name",
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
                          hintText: "Enter Business Name",
                          controller: controller.businessName,
                          validator: (v) {
                            if (v!.isEmpty) {
                              return "Enter Business Name";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20.h),
                        CustomTextField(
                          txKeyboardType: TextInputType.number,
                          labelWidget: Row(
                            children: [
                              Image.asset(
                                plusOutlineIc,
                                height: 16.h,
                                width: 16.w,
                              ),
                              SizedBox(width: 5.w),
                              Text(
                                "Work Experience",
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
                          hintText: "Enter Work Experience",
                          controller: controller.experience,
                          validator: (v) {
                            if (v!.isEmpty) {
                              return "Enter Work Experience";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20.h),
                        Row(
                          children: [
                            Image.asset(
                              cityOutlineIc,
                              height: 16.h,
                              width: 16.w,
                            ),
                            SizedBox(width: 5.w),
                            Text(
                              "State",
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
                        SizedBox(height: 6.h),
                        Obx(
                          () => DropdownButtonHideUnderline(
                            child: DropdownButton2<StateModel?>(
                              buttonStyleData: ButtonStyleData(
                                height: 45,
                                width: double.infinity,
                                padding: const EdgeInsets.only(left: 14, right: 14),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: borderColorCont,
                                  ),
                                  color: Colors.white,
                                ),
                              ),
                              iconStyleData: const IconStyleData(
                                icon: ImageIcon(
                                  AssetImage(arrowDropDown),
                                  size: 12,
                                ),
                                iconSize: 14,
                                iconEnabledColor: Colors.black,
                                iconDisabledColor: Colors.grey,
                              ),
                              dropdownStyleData: DropdownStyleData(
                                padding: const EdgeInsets.symmetric(horizontal: 15),
                                maxHeight: 200,
                                width: MediaQuery.of(context).size.width * 0.90,
                                useSafeArea: true,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14),
                                  color: Colors.white,
                                ),
                                scrollbarTheme: ScrollbarThemeData(
                                  radius: const Radius.circular(40),
                                  thickness: MaterialStateProperty.all(6),
                                  thumbVisibility: MaterialStateProperty.all(true),
                                ),
                              ),
                              menuItemStyleData: const MenuItemStyleData(
                                height: 45,
                                padding: EdgeInsets.only(left: 14, right: 14),
                              ),
                              isDense: true,
                              value: controller.stateModel,
                              hint: const Text(
                                "Select State",
                                style: TextStyle(fontWeight: FontWeight.w400, color: Color.fromRGBO(166, 166, 166, 0.7), fontFamily: regular, fontSize: 12, fontStyle: FontStyle.normal),
                              ),
                              style: const TextStyle(color: Colors.white60, fontSize: 13, fontWeight: FontWeight.bold),
                              isExpanded: true,
                              items: controller.stateList
                                  .map((s) => DropdownMenuItem<StateModel>(
                                        value: s,
                                        child: Text(
                                          " ${s.label}",
                                          style: const TextStyle(
                                            fontFamily: regular,
                                            color: blackCl,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ))
                                  .toList(),
                              onChanged: (StateModel? value) {
                                if (value != null) {
                                  setState(() {
                                    controller.stateModel = value;
                                    controller.stateId.value =controller.stateModel.value.toString();
                                    controller.cityListGet(controller.stateModel.value.toString());
                                  });
                                }
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: 20.h),
                        Row(
                          children: [
                            Image.asset(
                              cityOutlineIc,
                              height: 16.h,
                              width: 16.w,
                            ),
                            SizedBox(width: 5.w),
                            Text(
                              "City / Village",
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
                        SizedBox(height: 6.h),
                        Obx(
                          () => DropdownButtonHideUnderline(
                            child: DropdownButton2<CityModel?>(
                              buttonStyleData: ButtonStyleData(
                                height: 45,
                                width: double.infinity,
                                padding: const EdgeInsets.only(left: 14, right: 14),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: borderColorCont,
                                  ),
                                  color: Colors.white,
                                ),
                              ),
                              iconStyleData: const IconStyleData(
                                icon: ImageIcon(
                                  AssetImage(arrowDropDown),
                                  size: 12,
                                ),
                                iconSize: 14,
                                iconEnabledColor: Colors.black,
                                iconDisabledColor: Colors.grey,
                              ),
                              dropdownStyleData: DropdownStyleData(
                                padding: const EdgeInsets.symmetric(horizontal: 15),
                                maxHeight: 200,
                                width: MediaQuery.of(context).size.width * 0.90,
                                useSafeArea: true,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14),
                                  color: Colors.white,
                                ),
                                scrollbarTheme: ScrollbarThemeData(
                                  radius: const Radius.circular(40),
                                  thickness: MaterialStateProperty.all(6),
                                  thumbVisibility: MaterialStateProperty.all(true),
                                ),
                              ),
                              menuItemStyleData: const MenuItemStyleData(
                                height: 45,
                                padding: EdgeInsets.only(left: 14, right: 14),
                              ),
                              isDense: true,
                              value: controller.cityModel,
                              hint: const Text(
                                "Select City",
                                style: TextStyle(fontWeight: FontWeight.w400, color: Color.fromRGBO(166, 166, 166, 0.7), fontFamily: regular, fontSize: 12, fontStyle: FontStyle.normal),
                              ),
                              style: const TextStyle(color: Colors.white60, fontSize: 13, fontWeight: FontWeight.bold),
                              isExpanded: true,
                              items: controller.cityList
                                  .map((s) => DropdownMenuItem<CityModel>(
                                        value: s,
                                        child: Text(
                                          " ${s.label}",
                                          style: const TextStyle(
                                            fontFamily: regular,
                                            color: blackCl,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ))
                                  .toList(),
                              onChanged: (CityModel? value) {
                                if (value != null) {
                                  setState(() {
                                    controller.cityModel = value;
                                    controller.cityId.value = value.value.toString();
                                  });
                                }
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: 20.h),
                        CustomTextField(
                          txKeyboardType: TextInputType.text,
                          labelWidget: Row(
                            children: [
                              Image.asset(
                                locationIc,
                                height: 16.h,
                                width: 16.w,
                              ),
                              SizedBox(width: 5.w),
                              Text(
                                "Address",
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
                          hintText: "Enter Address",
                          controller: controller.addressLine,
                          validator: (v) {
                            if (v!.isEmpty) {
                              return "Enter Address";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20.h),
                        CustomTextField(
                          txKeyboardType: TextInputType.number,
                          maxLength: 6,
                          labelWidget: Row(
                            children: [
                              Image.asset(
                                pinLineIc,
                                height: 16.h,
                                width: 16.w,
                              ),
                              SizedBox(width: 5.w),
                              Text(
                                "Post Code",
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
                          hintText: "Enter Post Code",
                          controller: controller.pinCode,
                          validator: (v) {
                            if (v!.isEmpty) {
                              return "Enter Post Code";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20.h),
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
                                "Alternative Mobile Number ",
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
                          hintText: "Enter Alternative Number",
                          controller: controller.alternateMobile,
                          validator: (v) {
                            if (v!.isEmpty) {
                              return "Enter Alternative Number";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20.h),
                        CustomTextField(
                          txKeyboardType: TextInputType.text,
                          labelWidget: Row(
                            children: [
                              Image.asset(
                                userNewIc,
                                height: 16.h,
                                width: 16.w,
                              ),
                              SizedBox(width: 5.w),
                              Text(
                                "About Me",
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
                          hintText: "Enter About Me",
                          controller: controller.aboutVendor,
                          maxCheck: 5,
                          validator: (v) {
                            if (v!.isEmpty) {
                              return "Enter About Me";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 50.h),
                        Container(
                          height: 44,
                          padding: const EdgeInsets.symmetric(horizontal: 17),
                          child: CustomButtonWidget(
                            padding: EdgeInsets.zero,
                            style: CustomButtonStyle.style2,
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                Get.to(() => const UploadDocScreen());
                              }
                            },
                            text: 'Continue',
                            enabled: controller.registerMobile.text.isNotEmpty && controller.registerMobile.text.length >= 10,
                          ),
                        ),
                        SizedBox(height: 67.h),
                        Align(
                          alignment: Alignment.center,
                          child: GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: RichText(
                              text: TextSpan(
                                text: "Already Have Account? ",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 14.sp,
                                  fontFamily: semiBold,
                                  fontWeight: FontWeight.w600,
                                ),
                                children: [
                                  TextSpan(
                                    text: "Login",
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
          );
        });
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
