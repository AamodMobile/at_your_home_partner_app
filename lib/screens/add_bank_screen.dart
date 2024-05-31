import 'package:at_your_home_partner/constants/constants.dart';
import 'package:at_your_home_partner/controller/add_bank_controller.dart';
import 'package:at_your_home_partner/core/common_widgets/custom_buttons.dart';
import 'package:at_your_home_partner/core/common_widgets/custom_input_fields.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddBankScreen extends StatefulWidget {
  const AddBankScreen({super.key});

  @override
  State<AddBankScreen> createState() => _AddBankScreenState();
}

class _AddBankScreenState extends State<AddBankScreen> {
  AddBankController controller = Get.put(AddBankController());

  @override
  void initState() {
    controller.bankListGet();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                  "Add Bank Account",
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
          padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 32.h),
          child: SingleChildScrollView(
            child: Column(
              children: [
                CustomTextField(
                  txKeyboardType: TextInputType.text,
                  controller: controller.holderName,
                  labelWidget: Row(
                    children: [
                      Image.asset(
                        userOutlineIc,
                        height: 16.h,
                        width: 16.w,
                      ),
                      SizedBox(width: 5.w),
                      Text(
                        "Account Holder Name",
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
                  validator: (v) {
                    if (v!.isEmpty) {
                      return "Enter Full Name";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.h),
                CustomTextField(
                  txKeyboardType: TextInputType.text,
                  controller: controller.bankName,
                  labelWidget: Row(
                    children: [
                      Image.asset(
                        bankIC,
                        height: 16.h,
                        width: 16.w,
                      ),
                      SizedBox(width: 5.w),
                      Text(
                        "Bank Name",
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
                  hintText: "Enter Bank Name",
                  validator: (v) {
                    if (v!.isEmpty) {
                      return "Enter Bank Name";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.h),
                CustomTextField(
                  txKeyboardType: TextInputType.text,
                  controller: controller.ifscCode,
                  labelWidget: Row(
                    children: [
                      Image.asset(
                        pinLineIc,
                        height: 16.h,
                        width: 16.w,
                      ),
                      SizedBox(width: 5.w),
                      Text(
                        "IFSC Code",
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
                  hintText: "Enter IFSC Code",
                  validator: (v) {
                    if (v!.isEmpty) {
                      return "Enter IFSC Code";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.h),
                CustomTextField(
                  txKeyboardType: TextInputType.text,
                  controller: controller.accountNo,
                  labelWidget: Row(
                    children: [
                      Image.asset(
                        bankIC,
                        height: 16.h,
                        width: 16.w,
                      ),
                      SizedBox(width: 5.w),
                      Text(
                        "Account Number",
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
                  hintText: "Enter Account Number",
                  validator: (v) {
                    if (v!.isEmpty) {
                      return "Enter Account Number";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.h),
                CustomTextField(
                  txKeyboardType: TextInputType.text,
                  controller: controller.accountCNo,
                  labelWidget: Row(
                    children: [
                      Image.asset(
                        bankIC,
                        height: 16.h,
                        width: 16.w,
                      ),
                      SizedBox(width: 5.w),
                      Text(
                        "Confirm Account Number",
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
                  hintText: "Confirm Account Number",
                  validator: (v) {
                    if (v!.isEmpty) {
                      return "Confirm Account Number";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.h),
                CustomTextField(
                  txKeyboardType: TextInputType.text,
                  controller: controller.branch,
                  labelWidget: Row(
                    children: [
                      Image.asset(
                        bankIC,
                        height: 16.h,
                        width: 16.w,
                      ),
                      SizedBox(width: 5.w),
                      Text(
                        "Branch",
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
                  hintText: "Branch",
                  validator: (v) {
                    if (v!.isEmpty) {
                      return "Branch";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 60.h),
                Container(
                  height: 44,
                  padding: const EdgeInsets.symmetric(horizontal: 17),
                  child: CustomButtonWidget(
                    padding: EdgeInsets.zero,
                    style: CustomButtonStyle.style2,
                    onPressed: () {
                      controller.vendorAddBank();
                    },
                    text: 'Submit',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
