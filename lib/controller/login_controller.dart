import 'dart:convert';

import 'package:at_your_home_partner/constants/constants.dart';
import 'package:at_your_home_partner/model/user_model.dart';
import 'package:at_your_home_partner/screens/create_new_password_screen.dart';
import 'package:at_your_home_partner/screens/login_screen.dart';
import 'package:at_your_home_partner/screens/otp_screen.dart';

import 'package:at_your_home_partner/screens/successfully_screen.dart';
import 'package:at_your_home_partner/service/api_logs.dart';
import 'package:at_your_home_partner/service/api_service.dart';
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
  var otp = "";
  TextEditingController passwordNew = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  Future<void> login() async {
    try {
      showProgress();
      var result = await ApiService.loginApi(vendorId.text, mobile.text, password.text, "");
      var json = jsonDecode(result.body);
      final apiResponse = UserModel.fromJson(json);
      if (apiResponse.status == true) {
        closeProgress();
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
      } else {
        closeProgress();
        errorToast(apiResponse.message.toString());
      }
    } catch (e) {
      closeProgress();
      Log.console(e.toString());
    }
  }

  Future<void> registerApi() async {
    try {
      showProgress();
      var result = await ApiService.registerApi(
        registerName.text,
        registerMobile.text,
        registerPassword.text,
        businessName.text,
        alternateMobile.text,
        "",
        experience.text,
        addressLine.text,
        pinCode.text,
      );
      var json = jsonDecode(result.body);
      final apiResponse = UserModel.fromJson(json);
      if (apiResponse.status == true) {
        closeProgress();
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
              type: 'Your Account has been Register',
            ));
      } else {
        closeProgress();
        errorToast(apiResponse.message.toString());
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
        Get.to(() => const CreateNewPasswordScreen(
        ));

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
}
