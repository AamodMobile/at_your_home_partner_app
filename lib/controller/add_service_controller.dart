import 'dart:convert';

import 'package:at_your_home_partner/constants/constants.dart';
import 'package:at_your_home_partner/model/all_category_list_model.dart';
import 'package:at_your_home_partner/model/service_list_model.dart';
import 'package:at_your_home_partner/model/sub_category_list_model.dart';
import 'package:at_your_home_partner/model/time_slot_model.dart';
import 'package:at_your_home_partner/screens/home_screen.dart';
import 'package:at_your_home_partner/service/api_logs.dart';
import 'package:at_your_home_partner/service/api_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class AddServiceController extends GetxController {
  var isLoading = false.obs;
  var allCategoryList = <AllCategoryListModel>[].obs;
  var allCategoryListModel;
  var subCategoryList = <SubCategoryListModel>[].obs;
  var subCategoryListModel;
  var serviceList = <ServiceListModel>[].obs;
  var serviceListModel;
  var patientImages = [].obs;
  var selectedDateValue = "0".obs;
  var selectedTimeSlot = <String>[].obs;
  var selectedService = <String>[].obs;
  var selectedServiceList = <ServiceListModel>[].obs;
  var timeSlotList = <TimeSlotData>[].obs;
  var timeSlotListModel;

  void reset() {
    allCategoryListModel = null;
    allCategoryList.clear();
    subCategoryListModel = null;
    subCategoryList.clear();
    serviceListModel = null;
    serviceList.clear();
    selectedService.clear();
    selectedServiceList.clear();
  }

  void dateChange(DateTime value) {
    selectedDateValue.value = DateFormat('yyyy-MM-dd').format(value);
    update();
  }

  final ImagePicker imagePicker = ImagePicker();

  Future<void> selectImages() async {
    final List<XFile> selectedImages = await imagePicker.pickMultiImage();
    if (selectedImages.length > 10) {
      errorToast("Max ScreenShot Image limit is 10");
    } else {
      if (selectedImages.isNotEmpty) {
        if (selectedImages.length + patientImages.length > 10) {
          errorToast("Max ScreenShot Image limit is 10");
        } else {
          patientImages.addAll(selectedImages);
        }
      }
    }
    update();
  }

  Future<void> allCategoryListGet() async {
    isLoading.value = true;
    try {
      allCategoryListModel = null;
      allCategoryList.clear();
      var result = await ApiService.allCategoryList();
      var json = jsonDecode(result.body);
      if (json["status"] == true) {
        allCategoryList.assignAll(List<AllCategoryListModel>.from(json['data'].map((i) => AllCategoryListModel.fromJson(i))));
      } else {
        errorToast("Category List not found");
      }
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      Log.console(e.toString());
    }
  }

  Future<void> subCategoryListGet(String categoryId) async {
    isLoading.value = true;
    try {
      subCategoryListModel = null;
      subCategoryList.clear();
      var result = await ApiService.subCategoryList(categoryId);
      var json = jsonDecode(result.body);
      if (json["status"] == true) {
        subCategoryList.assignAll(List<SubCategoryListModel>.from(json['data'].map((i) => SubCategoryListModel.fromJson(i))));
      } else {
        errorToast("SubCategory List not found");
      }
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      Log.console(e.toString());
    }
  }

  Future<void> serviceListGet(String categoryId, String subcategoryId) async {
    isLoading.value = true;
    try {
      serviceListModel = null;
      serviceList.clear();
      selectedService.clear();
      selectedServiceList.clear();
      var result = await ApiService.serviceList(categoryId, subcategoryId);
      var json = jsonDecode(result.body);
      if (json["status"] == true) {
        var serviceLists = List<ServiceListModel>.from(json['data'].map((i) => ServiceListModel.fromJson(i)));
        serviceList.assignAll(serviceLists);
      } else {
        errorToast("Service List not found");
      }
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      Log.console(e.toString());
    }
  }

  Future<List<dynamic>> createService(String categoryId, String subcategoryId) async {
    try {
      showProgress();
      var result = await ApiService.createService(patientImages, categoryId, subcategoryId, selectedService);
      if (result["status"] == true) {
        closeProgress();
        update();
        return [true, result["message"].toString()];
      } else {
        closeProgress();
        update();
        return [false, result["message"].toString()];
      }
    } catch (e) {
      closeProgress();
      Log.console(e.toString());
      update();
      return [false, "An error occurred: $e"];
    }
  }

  Future<void> timeSlotsListGet() async {
    isLoading.value = true;
    try {
      timeSlotList.clear();
      timeSlotListModel = null;
      var result = await ApiService.timeSlotsList();
      var json = jsonDecode(result.body);
      if (json["status"] == true) {
        timeSlotList.assignAll(List<TimeSlotData>.from(json['data'].map((i) => TimeSlotData.fromJson(i))));
      } else {
        errorToast("Category List not found");
      }
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      Log.console(e.toString());
    }
  }

  Future<void> createTimeslots(String day, String timeSlot) async {
    try {
      showProgress();
      var result = await ApiService.createTimeslots(day, timeSlot);
      var json = jsonDecode(result.body);
      if (json["status"] == true) {
        closeProgress();
        Get.off(() => const HomeScreen());
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
