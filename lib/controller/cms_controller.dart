import 'dart:convert';


import 'package:at_your_home_partner/service/api_logs.dart';
import 'package:at_your_home_partner/service/api_service.dart';

import 'package:at_your_home_partner/constants/constants.dart';

class CmsController extends GetxController implements GetxService {
  bool isLoading = false;
  var content = "";

  Future<void> cmsGet(String type) async {
    isLoading = true;
    try {
      var result = await ApiService.cms(type);
      var json = jsonDecode(result.body);
      if (json["status"] == true) {
        isLoading = false;
        content = json["data"]["description"].toString();
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
