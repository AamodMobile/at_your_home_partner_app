import 'dart:convert';

import 'package:at_your_home_partner/constants/constants.dart';
import 'package:at_your_home_partner/model/my_service_list_model.dart';
import 'package:at_your_home_partner/model/service_details_model.dart';
import 'package:at_your_home_partner/service/api_logs.dart';
import 'package:at_your_home_partner/service/api_service.dart';

class MyServiceController extends GetxController implements GetxService {
  bool isLoading = false;
  var myServiceList = <MyServiceListModel>[];
  var serviceDetailsModel = ServiceDetailsModel();

  Future<void> myServiceGet() async {
    isLoading = true;
    myServiceList.clear();
    try {
      var result = await ApiService.myService();
      var json = jsonDecode(result.body);
      if (json["status"] == true) {
        isLoading = false;
        myServiceList = List<MyServiceListModel>.from(json["data"]['services'].map((i) => MyServiceListModel.fromJson(i))).toList(growable: true);
      } else {
        isLoading = false;
        errorToast(json["message"].toString());
      }
    } catch (e) {
      isLoading = false;
      Log.console(e.toString());
    }
    update();
  }

  Future<void> serviceDeleteApi(String serviceId) async {
    try {
      showProgress();
      var result = await ApiService.serviceDelete(serviceId);
      var json = jsonDecode(result.body);
      if (json["status"] == true) {
        closeProgress();
        myServiceGet();
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

  Future<void> serviceDetailsApi(String serviceId) async {
    try {
      isLoading = true;
      var result = await ApiService.serviceDetails(serviceId);
      var json = jsonDecode(result.body);
      if (json["status"] == true) {
        isLoading = false;
        serviceDetailsModel=ServiceDetailsModel.fromJson(json["data"]);
      } else {
        isLoading = false;
        errorToast(json["message"].toString());
      }
    } catch (e) {
      isLoading = false;
      Log.console(e.toString());
    }
    update();
  }
}
