import 'dart:convert';
import 'dart:io';

import 'package:at_your_home_partner/constants/constants.dart';
import 'package:at_your_home_partner/model/city_model.dart';
import 'package:at_your_home_partner/model/state_model.dart';
import 'package:at_your_home_partner/model/user_model.dart';
import 'package:at_your_home_partner/screens/create_new_password_screen.dart';
import 'package:at_your_home_partner/screens/login_screen.dart';
import 'package:at_your_home_partner/screens/otp_screen.dart';
import 'package:at_your_home_partner/screens/successfully_screen.dart';
import 'package:at_your_home_partner/service/api_logs.dart';
import 'package:at_your_home_partner/service/api_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController implements GetxService {
  TextEditingController vendorId = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController registerName = TextEditingController();
  TextEditingController registerMobile = TextEditingController();
  TextEditingController registerPassword = TextEditingController();
  TextEditingController businessName = TextEditingController();
  TextEditingController alternateMobile = TextEditingController();
  TextEditingController experience = TextEditingController();
  TextEditingController addressLine = TextEditingController();
  TextEditingController pinCode = TextEditingController();
  TextEditingController aboutVendor = TextEditingController();
  TextEditingController email = TextEditingController();
  var otp = "";
  TextEditingController passwordNew = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  TextEditingController aadharNo = TextEditingController();
  TextEditingController panNo = TextEditingController();
  TextEditingController medicalRNo = TextEditingController();
  TextEditingController educationRNo = TextEditingController();
  var cityList = <CityModel>[].obs;
  var stateList = <StateModel>[].obs;
  var cityModel;
  var stateModel;
  var stateId = "".obs;
  var cityId = "".obs;
  Rx<File> panCard = File("").obs;
  Rx<File> medicalRImage = File("").obs;
  Rx<File> educationRImage = File("").obs;
  Rx<File> aadhaarFrontImg = File("").obs;
  Rx<File> aadhaarBackImg = File("").obs;

  Future<void> login() async {
    try {
      showProgress();
      var result = await ApiService.loginApi( mobile.text, password.text, "");
      var json = jsonDecode(result.body);
      final apiResponse = UserModel.fromJson(json);
      if (apiResponse.status == true) {
        closeProgress();
        if(apiResponse.data?.status=="1"){
          var pref = await SharedPreferences.getInstance();
          await pref.setString('currentUser', jsonEncode(apiResponse.toJson()));
          await pref.setString('name', apiResponse.data!.name.toString());
          await pref.setString('profile', apiResponse.data!.profileImage.toString());
          await pref.setString('email', apiResponse.data!.email.toString());
          await pref.setString('mobile', apiResponse.data!.mobile.toString());
          await pref.setString('currentToken', apiResponse.data!.token.toString());
          await pref.setString('isAvailability', apiResponse.data!.isAvaibility.toString());
          successToast(apiResponse.message!);
          Get.off(() => SuccessfullyScreen(
            userName: apiResponse.data!.name.toString(),
            user: apiResponse.data!,
            type: 'Your Account has been login',
          ));
        }else{
          errorToast(apiResponse.message.toString());
        }

      } else {
        closeProgress();
        errorToast(apiResponse.message.toString());
      }
    } catch (e) {
      closeProgress();
      Log.console(e.toString());
    }
  }


  Future<void> uploadDocumentsVendor() async {
    try {
      showProgress();
      var result = await ApiService.registerApi(
        aadharNo.text,
        panNo.text,
        medicalRNo.text,
        educationRNo.text,
        aadhaarFrontImg.value.path,
        aadhaarBackImg.value.path,
        panCard.value.path,
        medicalRImage.value.path,
        educationRImage.value.path,
        registerName.text,
        registerMobile.text,
        registerPassword.text,
        businessName.text,
        alternateMobile.text,
        "",
        experience.text,
        addressLine.text,
        pinCode.text,
        stateId.value.toString(),
        cityId.value.toString(),
        aboutVendor.text,
        email.text,
      );
      if (result["status"] == true) {
       // final apiResponse = UserModel.fromJson(result);
        closeProgress();
        Get.offAll(() => const LoginScreen());
        successToast(result["message"].toString());
      } else {
        closeProgress();
        errorToast(result["message"].toString());
      }
    } catch (e) {
      closeProgress();
      Log.console(e.toString());
    }
  }

  Future<void> forgotPassword() async {
    try {
      showProgress();
      var result = await ApiService.forgotPassword(mobile.text);
      var json = jsonDecode(result.body);
      if (json["status"] == true) {
        closeProgress();
        var mobileNo = mobile.text;
        Get.to(() => OTPScreen(
              mobileNo: mobileNo,
            ));
        successToast(json["message"].toString());
      } else {
        closeProgress();
        errorToast(json["message"].toString());
      }
    } catch (e) {
      closeProgress();
      Log.console(e.toString());
    }
  }

  Future<void> verifyOtp() async {
    try {
      showProgress();
      var result = await ApiService.verifyOtpApi(mobile.text, otp);
      var json = jsonDecode(result.body);
      final apiResponse = UserModel.fromJson(json);
      if (apiResponse.status == true) {
        closeProgress();
        Get.to(() => const CreateNewPasswordScreen());
      } else {
        closeProgress();
        errorToast(apiResponse.message.toString());
      }
    } catch (e) {
      closeProgress();
      Log.console(e.toString());
    }
  }

  Future<void> updatePassword() async {
    try {
      showProgress();
      var result = await ApiService.vendorPasswordUpdate(mobile.text, passwordNew.text, confirmPassword.text);
      var json = jsonDecode(result.body);
      if (json["status"] == true) {
        closeProgress();
        Get.offAll(() => const LoginScreen());
        successToast(json["message"].toString());
      } else {
        closeProgress();
        errorToast(json["message"].toString());
      }
    } catch (e) {
      closeProgress();
      Log.console(e.toString());
    }
  }

  Future<void> statesList() async {
    try {
      stateModel = null;
      stateList.clear();
      var result = await ApiService.statesList();
      var json = jsonDecode(result.body);
      if (json["status"] == true) {
        stateList.value = List<StateModel>.from(json['data'].map((i) => StateModel.fromJson(i))).toList(growable: true);
      } else {
        //errorToast(json["message"].toString());
      }
    } catch (e) {
      Log.console(e.toString());
    }
    update();
  }

  Future<void> cityListGet(String stateID) async {
    try {
      cityModel = null;
      cityList.clear();
      var result = await ApiService.cityListGet(stateID);
      var json = jsonDecode(result.body);
      if (json["status"] == true) {
        cityList.value = List<CityModel>.from(json['data'].map((i) => CityModel.fromJson(i))).toList(growable: true);
      } else {
        //errorToast(json["message"].toString());
      }
    } catch (e) {
      Log.console(e.toString());
    }
    update();
  }

  Future<ImageSource?> imagePickerSheet(context) async {
    ImageSource? source = await showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(bottom: 16, top: 16),
            color: Colors.white,
            height: 120,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context, ImageSource.camera);
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(12),
                    child: Column(
                      children: [
                        Icon(
                          Icons.camera_rounded,
                          color: mainColor,
                          size: 40,
                        ),
                        Text(
                          'Camera',
                          style: TextStyle(color: mainColor),
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context, ImageSource.gallery);
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(12),
                    child: Column(
                      children: [
                        Icon(
                          Icons.photo_rounded,
                          color: mainColor,
                          size: 40,
                        ),
                        Text('Gallery', style: TextStyle(color: mainColor)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
    return source;
  }

  void pickImage(BuildContext context, String type) async {
    var source = await imagePickerSheet(context);
    if (source != null) {
      // ignore: invalid_use_of_visible_for_testing_member
      var picker = ImagePicker.platform;
      // ignore: deprecated_member_use
      var file = await picker.pickImage(
        source: source,
        maxHeight: 1080,
        maxWidth: 1080,
        imageQuality: 90,
      );
      if (type == "pan_card") {
        panCard.value = File(file!.path);
      } else if (type == "aadhaar_card") {
        aadhaarFrontImg.value = File(file!.path);
      } else if (type == "aadhaar_card_back") {
        aadhaarBackImg.value = File(file!.path);
      } else if (type == "medical_registration_doc") {
        medicalRImage.value = File(file!.path);
      } else if (type == "education_doc") {
        educationRImage.value = File(file!.path);
      }
    }
  }

  bool validatePAN(String pan) {
    String pattern = r'^[A-Z]{5}[0-9]{4}[A-Z]$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(pan);
  }

  bool validateDrivingLicense(String license) {
    String pattern = r'^[A-Z]{2}[0-9]{2}[0-9]{4}[0-9A-Z]{7}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(license);
  }

  bool validateAadhaar(String str) {
    String regex = r'^[2-9]{1}[0-9]{3}\s[0-9]{4}\s[0-9]{4}$';

    final p = RegExp(regex);
    if (str == null) {
      return false;
    }

    final m = p.hasMatch(str);
    return m;
  }

  String? emailValidator(value) {
    const pattern = r'(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)';
    final regExp = RegExp(pattern);

    if (value!.isEmpty) {
      return 'Enter an email';
    } else if (!regExp.hasMatch(
      value.toString().trim(),
    )) {
      return 'Enter a valid email';
    } else {
      return null;
    }
  }
}
