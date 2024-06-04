import 'dart:convert';
import 'dart:io';

import 'package:at_your_home_partner/constants/constants.dart';
import 'package:at_your_home_partner/model/city_model.dart';
import 'package:at_your_home_partner/model/state_model.dart';
import 'package:at_your_home_partner/model/user_model.dart';
import 'package:at_your_home_partner/screens/login_screen.dart';
import 'package:at_your_home_partner/service/api_logs.dart';
import 'package:at_your_home_partner/service/api_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserController extends GetxController implements GetxService {
  TextEditingController oldPassword = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  Rx<File> profileImage = File("").obs;
  var userData = UserData().obs;
  var cityList = <CityModel>[].obs;
  var stateList = <StateModel>[].obs;
  var cityModel;
  var stateModel;
  String stateId = "0";
  String cityId = "0";

  Future<void> vendorChangePassword() async {
    try {
      showProgress();
      var result = await ApiService.vendorChangePassword(oldPassword.text, password.text, confirmPassword.text);
      var json = jsonDecode(result.body);
      if (json["status"] == true) {
        closeProgress();
        Get.back();
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

  Future<void> updateProfileImage() async {
    try {
      showProgress();
      var result = await ApiService.profileImage(profileImage.value.path);
      if (result["status"] == true) {
        closeProgress();
        Get.back();
        vendorGetProfile();
        successToast(result["message"].toString());
      } else {
        closeProgress();
        errorToast(result["message"].toString());
      }
    } catch (e) {
      closeProgress();
      Log.console(e.toString());
    }
    update();
  }

  Future<void> updateProfile(
    String name,
    String addressLine1,
    String pincode,
    String experience,
    String businessName,
    String alternateMobile,
  ) async {
    try {
      showProgress();
      var result = await ApiService.updateProfile(name, addressLine1, pincode, experience, businessName, alternateMobile, stateModel.label.toString(),
        cityModel.label.toString(),);
      var json = jsonDecode(result.body);
      final apiResponse = UserModel.fromJson(json);
      if (apiResponse.status == true) {
        closeProgress();
        Get.back();
        Get.back();
        vendorGetProfile();
        successToast(apiResponse.message!);
      } else {
        closeProgress();
        errorToast(apiResponse.message.toString());
      }
    } catch (e) {
      closeProgress();
      Log.console(e);
    }
    update();
  }

  Future<void> vendorVendorDelete() async {
    try {
      showProgress();
      var result = await ApiService.vendorVendorDelete();
      var json = jsonDecode(result.body);
      if (json["status"] == true) {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        await preferences.clear();
        Get.offAll(() => const LoginScreen());
        closeProgress();
        successToast(json['message'].toString());
      } else {
        closeProgress();
        errorToast(json["message"].toString());
      }
    } catch (e) {
      closeProgress();
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

  void pickImage(BuildContext context) async {
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
      profileImage.value = File(file!.path);
      if (profileImage.value.path != "") {
        updateProfileImage();
      }
    }
  }

  Future<void> vendorGetProfile() async {
    try {
      showProgress();
      var result = await ApiService.vendorGetProfile();
      var json = jsonDecode(result.body);
      if (json["status"] == true) {
        closeProgress();
        var model = UserData.fromJson(json["data"]);
        userData.value = model;
        stateId = userData.value.state.toString();
        cityId = userData.value.city.toString();
        statesList();
      } else {
        closeProgress();
        errorToast(json["message"].toString());
      }
    } catch (e) {
      closeProgress();
      Log.console(e.toString());
    }
    update();
  }

  Future<void> statesList() async {
    try {
      stateModel = null;
      cityModel = null;
      stateList.clear();
      var result = await ApiService.statesList();
      var json = jsonDecode(result.body);
      if (json["status"] == true) {
        stateList.value = List<StateModel>.from(json['data'].map((i) => StateModel.fromJson(i))).toList(growable: true);
        for (var c in stateList) {
          if (c.value == stateId) {
            stateModel = c;
            cityListGet(stateModel.value.toString());
            break;
          }
        }
      } else {
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
        for (var c in cityList) {
          if (c.value == cityId) {
            cityModel = c;
            break;
          }
        }
      } else {
      }
    } catch (e) {
      Log.console(e.toString());
    }
    update();
  }
}
