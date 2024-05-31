import 'package:at_your_home_partner/constants/constants.dart';
import 'package:at_your_home_partner/controller/user_controller.dart';
import 'package:at_your_home_partner/core/common_widgets/custom_buttons.dart';
import 'package:at_your_home_partner/core/common_widgets/custom_input_fields.dart';
import 'package:at_your_home_partner/model/user_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditProfileView extends StatefulWidget {
  final UserData userData;

  const EditProfileView({super.key, required this.userData});

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  TextEditingController name = TextEditingController();
  TextEditingController businessName = TextEditingController();
  TextEditingController experience = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController postCode = TextEditingController();
  TextEditingController atNumber = TextEditingController();
  UserController controller = Get.put(UserController());

  @override
  void initState() {
    name.text = widget.userData.name.toString();
    businessName.text = widget.userData.businessName.toString();
    experience.text = widget.userData.experience.toString();
    address.text = widget.userData.address.toString();
    postCode.text = widget.userData.pincode.toString();
    atNumber.text = widget.userData.alternateMobile.toString();
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
                  "Edit Profile",
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
          padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 26.h),
          child: SingleChildScrollView(
            child: Column(
              children: [
                CustomTextField(
                  txKeyboardType: TextInputType.text,
                  controller: name,
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
                  controller: businessName,
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
                  controller: experience,
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
                  validator: (v) {
                    if (v!.isEmpty) {
                      return "Enter Work Experience";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.h),
                CustomTextField(
                  txKeyboardType: TextInputType.text,
                  controller: address,
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
                  controller: postCode,
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
                  controller: atNumber,
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
                  validator: (v) {
                    if (v!.isEmpty) {
                      return "Enter Alternative Number";
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
                      controller.updateProfile(
                        name.text,
                        address.text,
                        postCode.text,
                        experience.text,
                        businessName.text,
                        atNumber.text,
                      ).then((v) {
                        setState(() {});
                      });
                    },
                    text: 'Update',
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
