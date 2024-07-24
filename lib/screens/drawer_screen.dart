import 'dart:io';

import 'package:at_your_home_partner/constants/constants.dart';
import 'package:at_your_home_partner/controller/user_controller.dart';
import 'package:at_your_home_partner/screens/change_password_screen.dart';
import 'package:at_your_home_partner/screens/cms_screen.dart';
import 'package:at_your_home_partner/screens/feedback_screen.dart';
import 'package:at_your_home_partner/screens/login_screen.dart';
import 'package:at_your_home_partner/screens/my_income_screen.dart';
import 'package:at_your_home_partner/screens/my_service_screen.dart';
import 'package:at_your_home_partner/screens/profile_view.dart';
import 'package:at_your_home_partner/service/api_url.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({super.key});

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  UserController controller = Get.put(UserController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.95,
      backgroundColor: Colors.transparent,
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
            width: MediaQuery.of(context).size.width * 0.88,
            decoration: const BoxDecoration(
              color: whiteCl,
            ),
            child: SingleChildScrollView(child:
            Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                    Get.to(() => ProfileView(
                          userData: controller.userData.value,
                        ));
                  },
                  child: Container(
                    height: 100.h,
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 18.h),
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(image: DecorationImage(image: AssetImage(profileBg), fit: BoxFit.fill)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Stack(
                          children: [
                            Container(
                              height: 70.h,
                              width: 70.w,
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                              margin: EdgeInsets.only(top: 12.h),
                              decoration: BoxDecoration(
                                color: lightFillCl,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: const Color(0xFF67B87A),
                                  width: 4,
                                ),
                              ),
                              child: controller.userData.value.profileImage != ""
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
                                        imageUrl: ApiUrl.imageUrl + controller.userData.value.profileImage.toString(),
                                        placeholder: (a, b) => const Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                      ),
                                    )
                                  : Image.asset(clientDemo),
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
                        SizedBox(width: 17.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              controller.userData.value.name.toString(),
                              style: TextStyle(
                                color: blackCl,
                                fontStyle: FontStyle.normal,
                                fontSize: 16.sp,
                                fontFamily: semiBold,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "+91 ${controller.userData.value.mobile}",
                              style: TextStyle(
                                color: blackCl,
                                fontStyle: FontStyle.normal,
                                fontSize: 14.sp,
                                fontFamily: semiBold,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 30.h),
                contColumn(
                  function: () {
                    Get.back();
                    Get.to(() => const MyServiceScreen());
                  },
                  assetImg: injectionIc,
                  tittle: "My Service",
                  isHide: false,
                ),
                contColumn(
                  function: () {
                    Get.back();
                    Get.to(() => const MyIncomeScreen());
                  },
                  assetImg: walletD,
                  tittle: "My Income",
                  isHide: false,
                ),
                contColumn(
                  function: () {
                    Get.back();
                    Get.to(() => const FeedbackScreen());
                  },
                  assetImg: walletD,
                  tittle: "Feedback",
                  isHide: false,
                ),
                contColumn(
                  function: () {
                    Get.back();
                    Get.to(() => const ChangePasswordScreen());
                  },
                  assetImg: passwordIc,
                  tittle: "Change Password",
                  isHide: false,
                ),
                contColumn(
                  function: () {
                    shareApp();
                  },
                  assetImg: fluentShareIc,
                  tittle: "Share App",
                  isHide: false,
                ),
                contColumn(
                  function: () {
                    Get.back();
                    Get.to(() => const CmsScreen(tittle: "About Us"));
                  },
                  assetImg: aboutIc,
                  tittle: "About Us",
                  isHide: false,
                ),
                contColumn(
                  function: () {
                    Get.back();
                    Get.to(() => const CmsScreen(tittle: "Terms and Conditions"));
                  },
                  assetImg: fileIc,
                  tittle: "Terms and Conditions",
                  isHide: false,
                ),
                contColumn(
                  function: () {
                    Get.back();
                    Get.to(() => const CmsScreen(tittle: "Privacy Policy"));
                  },
                  assetImg: fileIc,
                  tittle: "Privacy Policy",
                  isHide: false,
                ),
                contColumn(
                  function: () {
                    Get.back();
                    deleteAccount();
                  },
                  assetImg: deleteIc,
                  tittle: "Delete Account",
                  isHide: false,
                ),
                contColumn(
                  function: () {
                    Get.back();
                    logoutDialog();
                  },
                  assetImg: logoutFillIc,
                  tittle: "Logout",
                  isHide: false,
                ),
              ],
            ),
          ),),
          Positioned(
              right: 10,
              top: 0,
              bottom: 0,
              child: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  height: 70,
                  width: 70,
                  decoration: const BoxDecoration(
                    color: whiteCl,
                    shape: BoxShape.circle,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Center(
                        child: Container(
                          height: 44,
                          width: 44,
                          decoration: const BoxDecoration(
                            color: mainColor,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                              child: Image.asset(
                            iosBackIc,
                            height: 24,
                            width: 24,
                          )),
                        ),
                      ),
                      SizedBox(width: 4.w)
                    ],
                  ),
                ),
              ))
        ],
      ),
    );
  }

  Widget contColumn({required Function() function, required String assetImg, required String tittle, required bool isHide}) {
    return Column(
      children: [
        GestureDetector(
          onTap: function,
          child: Container(
            margin: EdgeInsets.only(right: 70.w),
            padding: EdgeInsets.all(10.h),
            decoration: BoxDecoration(color: whiteCl, borderRadius: BorderRadius.circular(6.dm), border: Border.all(color: mainColor)),
            child: Row(
              children: [
                Image.asset(
                  assetImg,
                  height: 24.h,
                  width: 24.w,
                ),
                SizedBox(width: 10.w),
                Text(
                  tittle,
                  style: TextStyle(
                    color: blackCl,
                    fontStyle: FontStyle.normal,
                    fontSize: 12.sp,
                    fontFamily: semiBold,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                isHide
                    ? const SizedBox()
                    : Image.asset(
                        arrowLeftIc,
                        height: 24.h,
                        width: 24.w,
                      ),
              ],
            ),
          ),
        ),
        SizedBox(height: 18.h),
      ],
    );
  }

  void logoutDialog() {
    showDialog(
      context: context,
      builder: (_) {
        return Dialog(
          elevation: 0,
          insetPadding: const EdgeInsets.symmetric(horizontal: 10),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: whiteCl,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 30,
                      width: MediaQuery.of(context).size.width,
                    ),
                    Image.asset(
                      offIc,
                      height: 80,
                      width: 80,
                    ),
                    const SizedBox(height: 60),
                    const Text(
                      "Are you sure you want to log out ?",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: semiBold,
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 60),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              fixedSize: const Size(278, 47),
                              backgroundColor: const Color(0xFFB7B7B7),
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(6),
                                ),
                              ),
                            ),
                            child: const Text(
                              "Yes",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontFamily: regular,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            onPressed: () async {
                              SharedPreferences preferences = await SharedPreferences.getInstance();
                              await preferences.clear();
                              Get.offAll(() => const LoginScreen());
                            },
                          ),
                        ),
                        const SizedBox(width: 11),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              fixedSize: const Size(278, 47),
                              backgroundColor: mainColor,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(6),
                                ),
                              ),
                            ),
                            child: const Text(
                              "No",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontFamily: regular,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            onPressed: () {
                              Get.back();
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void deleteAccount() {
    showDialog(
      context: context,
      builder: (_) {
        return Dialog(
          elevation: 0,
          insetPadding: const EdgeInsets.symmetric(horizontal: 10),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: whiteCl,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 30,
                      width: MediaQuery.of(context).size.width,
                    ),
                    Image.asset(
                      deleteIcNew,
                      height: 90,
                      width: 90,
                    ),
                    const SizedBox(height: 60),
                    const Text(
                      "Do You Want to Delete the Account ?",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: semiBold,
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 60),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              fixedSize: const Size(278, 47),
                              backgroundColor: const Color(0xFFB7B7B7),
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(6),
                                ),
                              ),
                            ),
                            child: const Text(
                              "Yes",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontFamily: regular,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            onPressed: () {
                              controller.vendorVendorDelete();
                            },
                          ),
                        ),
                        const SizedBox(width: 11),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              fixedSize: const Size(278, 47),
                              backgroundColor: mainColor,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(6),
                                ),
                              ),
                            ),
                            child: const Text(
                              "No",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontFamily: regular,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            onPressed: () {
                              Get.back();
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> shareApp() async {
    String packageName = 'com.at_your_home';
    String appStoreUrl = 'https://apps.apple.com/app/$packageName';
    String playStoreUrl = 'https://play.google.com/store/apps/details?id=$packageName';
    if (!Platform.isAndroid) {
      await Share.share('At Your Home App Download From App Store:-'
          '\n $appStoreUrl"');
    } else if (Platform.isAndroid) {
      await Share.share('At Your Home  App Download From Play Store:-'
          '\n $playStoreUrl"');
    } else {
      throw 'Could not launch store';
    }
  }
}
