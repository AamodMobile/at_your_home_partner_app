import 'dart:io';

import 'package:at_your_home_partner/constants/constants.dart';
import 'package:at_your_home_partner/controller/login_controller.dart';
import 'package:at_your_home_partner/core/common_widgets/custom_buttons.dart';
import 'package:at_your_home_partner/core/common_widgets/custom_input_fields.dart';
import 'package:at_your_home_partner/core/upper_case_text_formatter.dart';
import 'package:at_your_home_partner/core/white_spacer_after_four.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UploadDocScreen extends StatefulWidget {
  const UploadDocScreen({super.key,});

  @override
  State<UploadDocScreen> createState() => _UploadDocScreenState();
}

class _UploadDocScreenState extends State<UploadDocScreen> {
  LoginController controller = Get.put(LoginController());
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: Get.find<LoginController>(),
      initState: (state) {
      },
      builder: (contextCtr) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: lightFillCl,
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
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
                      const SizedBox(height: 10),
                      const Text(
                        "Upload Document",
                        style: TextStyle(
                          color: blueCl,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w600,
                          fontFamily: semiBold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: borderColorCont),
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: Column(
                          children: [
                            const Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "PAN Card",
                                      style: TextStyle(
                                        color: greyColorTxt1,
                                        fontFamily: regular,
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FontStyle.normal,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            CustomTextField(
                              hintText: 'Enter Pan Number',
                              controller: controller.panNo,
                              validator: (v) {
                                return contextCtr.validatePAN(v!) ? null : "Enter Valid Pan Number";
                              },
                              obscureText: false,
                              inputFormatters: [
                                UpperCaseTextFormatter(),
                              ],
                              readOnly: false,
                              txKeyboardType: TextInputType.name,
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      contextCtr.pickImage(context, "pan_card");
                                    },
                                    child: Obx(
                                      () => Container(
                                        height: 120,
                                        padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                                        decoration: BoxDecoration(color: lightFillCl, border: Border.all(color: borderColorCont), borderRadius: BorderRadius.circular(9)),
                                        child: contextCtr.panCard.value.path != ""
                                            ? ClipRRect(
                                                borderRadius: BorderRadius.circular(9),
                                                child: Image.file(
                                                  File(contextCtr.panCard.value.path),
                                                  height: 120,
                                                  fit: BoxFit.fill,
                                                ))
                                            : Row(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Image.asset(
                                                    galleryIc,
                                                    height: 15,
                                                    width: 18,
                                                    color: mainColor,
                                                  ),
                                                  const SizedBox(width: 15),
                                                  const Text(
                                                    "Pan Card Upload",
                                                    style: TextStyle(
                                                      color: greyColorTxt1,
                                                      fontFamily: regular,
                                                      fontWeight: FontWeight.w500,
                                                      fontStyle: FontStyle.normal,
                                                      fontSize: 12,
                                                    ),
                                                  )
                                                ],
                                              ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: borderColorCont),
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: Column(
                          children: [
                            const Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(width: 11),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 10),
                                      Text(
                                        "Aadhaar Card",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: greyColorTxt1,
                                          fontFamily: regular,
                                          fontWeight: FontWeight.w500,
                                          fontStyle: FontStyle.normal,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            CustomTextField(
                              hintText: 'Enter Aadhaar Number',
                              controller: controller.aadharNo,
                              maxLength: 14,
                              inputFormatters: [FilteringTextInputFormatter.digitsOnly, WhiteSpacerAfter4()],
                              validator: (v) {
                                return contextCtr.validateAadhaar(v!) ? null : "Enter Valid Aadhaar Number";
                              },
                              obscureText: false,
                              readOnly: false,
                              txKeyboardType: TextInputType.name,
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      contextCtr.pickImage(context, "aadhaar_card");
                                    },
                                    child: Obx(
                                      () => Container(
                                        height: 120,
                                        padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: lightFillCl,
                                          border: Border.all(color: borderColorCont),
                                          borderRadius: BorderRadius.circular(9),
                                        ),
                                        child: contextCtr.aadhaarFrontImg.value.path != ""
                                            ? ClipRRect(
                                                borderRadius: BorderRadius.circular(9),
                                                child: Image.file(
                                                  File(contextCtr.aadhaarFrontImg.value.path),
                                                  height: 120,
                                                  fit: BoxFit.fill,
                                                ))
                                            : Row(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Image.asset(
                                                    galleryIc,
                                                    height: 15,
                                                    width: 18,
                                                    color: mainColor,
                                                  ),
                                                  const SizedBox(width: 5),
                                                  const Text(
                                                    "Aadhaar Front Image ",
                                                    style: TextStyle(
                                                      color: greyColorTxt1,
                                                      fontFamily: regular,
                                                      fontWeight: FontWeight.w500,
                                                      fontStyle: FontStyle.normal,
                                                      fontSize: 12,
                                                    ),
                                                  )
                                                ],
                                              ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      contextCtr.pickImage(context, "aadhaar_card_back");
                                    },
                                    child: Obx(
                                      () => Container(
                                        height: 120,
                                        padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: lightFillCl,
                                          border: Border.all(color: borderColorCont),
                                          borderRadius: BorderRadius.circular(9),
                                        ),
                                        child: contextCtr.aadhaarBackImg.value.path != ""
                                            ? ClipRRect(
                                                borderRadius: BorderRadius.circular(9),
                                                child: Image.file(
                                                  File(contextCtr.aadhaarBackImg.value.path),
                                                  height: 120,
                                                  fit: BoxFit.fill,
                                                ))
                                            : Row(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Image.asset(
                                                    galleryIc,
                                                    height: 15,
                                                    width: 18,
                                                    color: mainColor,
                                                  ),
                                                  const SizedBox(width: 5),
                                                  const Text(
                                                    "Aadhaar Back Image ",
                                                    style: TextStyle(
                                                      color: greyColorTxt1,
                                                      fontFamily: regular,
                                                      fontWeight: FontWeight.w500,
                                                      fontStyle: FontStyle.normal,
                                                      fontSize: 12,
                                                    ),
                                                  )
                                                ],
                                              ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: borderColorCont),
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: Column(
                          children: [
                            const Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Medical Registration Doc",
                                      style: TextStyle(
                                        color: greyColorTxt1,
                                        fontFamily: regular,
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FontStyle.normal,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            CustomTextField(
                              hintText: 'Enter Medical Registration No.',
                              controller: controller.medicalRNo,
                              validator: (v) {
                                if (v!.isEmpty) {
                                  return "Enter Medical Registration No";
                                }
                                return null;
                              },
                              obscureText: false,
                              readOnly: false,
                              txKeyboardType: TextInputType.name,
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      contextCtr.pickImage(context, "medical_registration_doc");
                                    },
                                    child: Obx(
                                      () => Container(
                                        height: 120,
                                        padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                                        decoration: BoxDecoration(color: lightFillCl, border: Border.all(color: borderColorCont), borderRadius: BorderRadius.circular(9)),
                                        child: contextCtr.medicalRImage.value.path != ""
                                            ? ClipRRect(
                                                borderRadius: BorderRadius.circular(9),
                                                child: Image.file(
                                                  File(contextCtr.medicalRImage.value.path),
                                                  height: 120,
                                                  fit: BoxFit.fill,
                                                ))
                                            : Row(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Image.asset(
                                                    galleryIc,
                                                    height: 15,
                                                    width: 18,
                                                    color: mainColor,
                                                  ),
                                                  const SizedBox(width: 15),
                                                  const Text(
                                                    "Medical Registration Upload",
                                                    style: TextStyle(
                                                      color: greyColorTxt1,
                                                      fontFamily: regular,
                                                      fontWeight: FontWeight.w500,
                                                      fontStyle: FontStyle.normal,
                                                      fontSize: 12,
                                                    ),
                                                  )
                                                ],
                                              ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: borderColorCont),
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: Column(
                          children: [
                            const Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Education Doc",
                                      style: TextStyle(
                                        color: greyColorTxt1,
                                        fontFamily: regular,
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FontStyle.normal,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            CustomTextField(
                              hintText: 'Enter Education Registration No.',
                              controller: controller.educationRNo,
                              validator: (v) {
                                if (v!.isEmpty) {
                                  return "Enter Education Registration No";
                                }
                                return null;
                              },
                              obscureText: false,
                              readOnly: false,
                              txKeyboardType: TextInputType.name,
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      contextCtr.pickImage(context, "education_doc");
                                    },
                                    child: Obx(
                                      () => Container(
                                        height: 120,
                                        padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                                        decoration: BoxDecoration(color: lightFillCl, border: Border.all(color: borderColorCont), borderRadius: BorderRadius.circular(9)),
                                        child: contextCtr.educationRImage.value.path != ""
                                            ? ClipRRect(
                                                borderRadius: BorderRadius.circular(9),
                                                child: Image.file(
                                                  File(contextCtr.educationRImage.value.path),
                                                  height: 120,
                                                  fit: BoxFit.fill,
                                                ))
                                            : Row(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Image.asset(
                                                    galleryIc,
                                                    height: 15,
                                                    width: 18,
                                                    color: mainColor,
                                                  ),
                                                  const SizedBox(width: 15),
                                                  const Text(
                                                    "Education Registration Upload",
                                                    style: TextStyle(
                                                      color: greyColorTxt1,
                                                      fontFamily: regular,
                                                      fontWeight: FontWeight.w500,
                                                      fontStyle: FontStyle.normal,
                                                      fontSize: 12,
                                                    ),
                                                  )
                                                ],
                                              ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 40.h),
                      Container(
                        height: 44,
                        padding: const EdgeInsets.symmetric(horizontal: 17),
                        child: CustomButtonWidget(
                          padding: EdgeInsets.zero,
                          style: CustomButtonStyle.style2,
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              FocusScope.of(context).requestFocus(FocusNode());
                              if (contextCtr.panCard.value.path == "") {
                                errorToast("Add Pan card Image ");
                              } else if (contextCtr.aadhaarFrontImg.value.path == "") {
                                errorToast("Add Aadhaar Front Image ");
                              } else if (contextCtr.aadhaarBackImg.value.path == "") {
                                errorToast("Add Aadhaar Back Image");
                              } else if (contextCtr.medicalRImage.value.path == "") {
                                errorToast("Add Medical Registration Image");
                              } else if (contextCtr.educationRImage.value.path == "") {
                                errorToast("Add Education  Registration Image");
                              } else {
                                contextCtr.uploadDocumentsVendor();
                              }
                            }
                          },
                          text: 'Upload',
                        ),
                      ),
                      SizedBox(height: 40.h),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
