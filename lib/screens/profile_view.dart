import 'dart:io';

import 'package:at_your_home_partner/constants/constants.dart';
import 'package:at_your_home_partner/controller/user_controller.dart';
import 'package:at_your_home_partner/model/user_model.dart';
import 'package:at_your_home_partner/screens/edit_profile_view.dart';
import 'package:at_your_home_partner/service/api_url.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileView extends StatefulWidget {
  final UserData userData;

  const ProfileView({super.key, required this.userData});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  UserController controller = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: Get.find<UserController>(),
      initState: (state) {
        Get.find<UserController>();
      },
      builder: (contextCtrl) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: whiteCl,
            body: Column(
              children: [
                Stack(
                  children: [
                    Image.asset(
                      union,
                      height: 174.h,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      top: 32,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.symmetric(horizontal: 14.w),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
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
                                SizedBox(width: 14.w),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.userData.name.toString(),
                                      style: TextStyle(
                                        color: whiteCl,
                                        fontStyle: FontStyle.normal,
                                        fontSize: 16.sp,
                                        fontFamily: semiBold,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      widget.userData.mobile.toString(),
                                      style: TextStyle(
                                        color: whiteCl,
                                        fontStyle: FontStyle.normal,
                                        fontSize: 12.sp,
                                        fontFamily: semiBold,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.to(() => EditProfileView(userData: widget.userData));
                              },
                              child: Image.asset(
                                editOutline,
                                height: 24.h,
                                width: 24.w,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 30,
                      child: Stack(
                        children: [
                          GestureDetector(
                            onTap: () {
                              controller.pickImage(context);
                              setState(() {});
                            },
                            child: Container(
                              height: 70.h,
                              width: 70.w,
                              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                              margin: EdgeInsets.only(top: 12.h),
                              decoration: BoxDecoration(
                                color: lightFillCl,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: const Color(0xFF67B87A),
                                  width: 4,
                                ),
                              ),
                              child: widget.userData.profileImage != ""
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(35),
                                      child: CachedNetworkImage(
                                        errorWidget: (context, url, error) => Image.asset(
                                          clientDemo,
                                          fit: BoxFit.fill,
                                          height: 90.h,
                                          width: 70.w,
                                        ),
                                        fit: BoxFit.fill,
                                        height: 90.h,
                                        width: 70.w,
                                        imageUrl: ApiUrl.imageUrl+widget.userData.profileImage.toString(),
                                        placeholder: (a, b) => const Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                      ),
                                    )
                                  : controller.profileImage.value.path != ""
                                      ? Image.file(
                                          File(controller.profileImage.value.path),
                                          fit: BoxFit.cover,
                                        )
                                      : Image.asset(clientDemo),
                            ),
                          ),
                          Positioned(
                              right: 5,
                              bottom: 0,
                              child: Image.asset(
                                cameraGreenIc,
                                height: 20.h,
                                width: 20.w,
                              ))
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(height: 54.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 13.w),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 42,
                            width: 42,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: whiteCl, shape: BoxShape.circle, boxShadow: [BoxShadow(offset: const Offset(0, 1), blurRadius: 6, spreadRadius: 0, color: blackCl.withOpacity(0.15))]),
                            child: Image.asset(
                              hospitalIc,
                              color: redColor,
                            ),
                          ),
                          SizedBox(width: 16.w),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Business Name",
                                style: TextStyle(
                                  color: const Color(0xFF807E7E),
                                  fontStyle: FontStyle.normal,
                                  fontSize: 12.sp,
                                  fontFamily: semiBold,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(height: 5.h),
                              Text(
                                widget.userData.businessName.toString(),
                                style: TextStyle(
                                  color: blackCl,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 16.sp,
                                  fontFamily: semiBold,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(height: 21.h),
                      const Divider(
                        color: borderColorCont,
                      ),
                      SizedBox(height: 21.h),
                      Row(
                        children: [
                          Container(
                            height: 42,
                            width: 42,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: whiteCl, shape: BoxShape.circle, boxShadow: [BoxShadow(offset: const Offset(0, 1), blurRadius: 6, spreadRadius: 0, color: blackCl.withOpacity(0.15))]),
                            child: Image.asset(
                              plusOutlineIc,
                              color: appBar,
                            ),
                          ),
                          SizedBox(width: 16.w),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Work Experience",
                                style: TextStyle(
                                  color: const Color(0xFF807E7E),
                                  fontStyle: FontStyle.normal,
                                  fontSize: 12.sp,
                                  fontFamily: semiBold,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(height: 5.h),
                              Text(
                                "${widget.userData.experience.toString()} Years",
                                style: TextStyle(
                                  color: blackCl,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 16.sp,
                                  fontFamily: semiBold,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(height: 21.h),
                      const Divider(
                        color: borderColorCont,
                      ),
                      SizedBox(height: 21.h),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 42,
                            width: 42,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: whiteCl, shape: BoxShape.circle, boxShadow: [BoxShadow(offset: const Offset(0, 1), blurRadius: 6, spreadRadius: 0, color: blackCl.withOpacity(0.15))]),
                            child: Image.asset(
                              locationIc,
                              color: appBar,
                            ),
                          ),
                          SizedBox(width: 16.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Address",
                                  style: TextStyle(
                                    color: const Color(0xFF807E7E),
                                    fontStyle: FontStyle.normal,
                                    fontSize: 12.sp,
                                    fontFamily: semiBold,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(height: 5.h),
                                Text(
                                  widget.userData.address.toString(),
                                  style: TextStyle(
                                    color: blackCl,
                                    fontStyle: FontStyle.normal,
                                    fontSize: 16.sp,
                                    fontFamily: semiBold,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 21.h),
                      const Divider(
                        color: borderColorCont,
                      ),
                      SizedBox(height: 21.h),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 42,
                            width: 42,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: whiteCl, shape: BoxShape.circle, boxShadow: [BoxShadow(offset: const Offset(0, 1), blurRadius: 6, spreadRadius: 0, color: blackCl.withOpacity(0.15))]),
                            child: Image.asset(
                              mobileIc,
                              color: appBar,
                            ),
                          ),
                          SizedBox(width: 16.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Alternative Mobile Number",
                                  style: TextStyle(
                                    color: const Color(0xFF807E7E),
                                    fontStyle: FontStyle.normal,
                                    fontSize: 12.sp,
                                    fontFamily: semiBold,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(height: 5.h),
                                Text(
                                  "+91 ${widget.userData.alternateMobile.toString()}",
                                  style: TextStyle(
                                    color: blackCl,
                                    fontStyle: FontStyle.normal,
                                    fontSize: 16.sp,
                                    fontFamily: semiBold,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
