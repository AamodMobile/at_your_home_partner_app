import 'dart:convert';

import 'package:at_your_home_partner/constants/constants.dart';
import 'package:at_your_home_partner/model/all_category_list_model.dart';
import 'package:at_your_home_partner/model/service_list_model.dart';
import 'package:at_your_home_partner/model/sub_category_list_model.dart';
import 'package:at_your_home_partner/model/time_slot_model.dart';
import 'package:at_your_home_partner/service/api_logs.dart';
import 'package:at_your_home_partner/service/api_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class AddServiceController extends GetxController implements GetxService {
  bool isLoading = false;
  var allCategoryList = <AllCategoryListModel>[];
  var allCategoryListModel;
  var subCategoryList = <SubCategoryListModel>[];
  var subCategoryListModel;
  var serviceList = List<ServiceListModel>.empty(growable: true);
  var serviceListModel;
  var patientImages = [].obs;
  var selectedDateValue = "0".obs;
  var selectedTimeSlot = [];
  List<String> selectedService = List<String>.empty(growable: true);
  List<ServiceListModel> selectedServiceList = List<ServiceListModel>.empty(growable: true);
  var timeSlotList = <TimeSlotData>[];
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

  void dateChange(var value) {
    selectedDateValue.value = DateFormat('yyyy-MM-dd').format(value);
    //getTimeSlot(selectedDateValue.value);
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
    isLoading = true;
    try {
      allCategoryListModel = null;
      allCategoryList.clear();
      var result = await ApiService.allCategoryList();
      var json = jsonDecode(result.body);
      if (json["status"] == true) {
        allCategoryList = List<AllCategoryListModel>.from(json['data'].map((i) => AllCategoryListModel.fromJson(i))).toList(growable: true);
      } else {
        errorToast("Category List not found");
      }

      isLoading = false;
    } catch (e) {
      isLoading = false;
      Log.console(e.toString());
    }
    update();
  }

  Future<void> subCategoryListGet(String categoryId) async {
    isLoading = true;
    try {
      subCategoryListModel = null;
      subCategoryList.clear();
      var result = await ApiService.subCategoryList(categoryId);
      var json = jsonDecode(result.body);
      if (json["status"] == true) {
        subCategoryList = List<SubCategoryListModel>.from(json['data'].map((i) => SubCategoryListModel.fromJson(i))).toList(growable: true);
      } else {
        errorToast("SubCategory List not found");
      }

      isLoading = false;
    } catch (e) {
      isLoading = false;
      Log.console(e.toString());
    }
    update();
  }

  Future<void> serviceListGet(String categoryId, String subcategoryId) async {
    isLoading = true;
    try {
      serviceListModel = null;
      serviceList.clear();
      selectedService.clear();
      selectedServiceList.clear();
      var result = await ApiService.serviceList(categoryId, subcategoryId);
      var json = jsonDecode(result.body);
      if (json["status"] == true) {
        var serviceLists = List<ServiceListModel>.from(json['data'].map((i) => ServiceListModel.fromJson(i))).toList(growable: true);
        serviceList.addAll(serviceLists);
      } else {
        errorToast("Service List not found");
      }

      isLoading = false;
    } catch (e) {
      isLoading = false;
      Log.console(e.toString());
    }
    update();
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
    isLoading = true;
    try {
      timeSlotList.clear();
      timeSlotListModel = null;
      var result = await ApiService.timeSlotsList();
      var json = jsonDecode(result.body);
      if (json["status"] == true) {
        timeSlotList = List<TimeSlotData>.from(json['data'].map((i) => TimeSlotData.fromJson(i))).toList(growable: true);
      } else {
        errorToast("Category List not found");
      }

      isLoading = false;
    } catch (e) {
      isLoading = false;
      Log.console(e.toString());
    }
    update();
  }

  Future<void> createTimeslots(String day, String timeSlot) async {
    try {
      showProgress();
      var result = await ApiService.createTimeslots(day, timeSlot);
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
    update();
  }
}
