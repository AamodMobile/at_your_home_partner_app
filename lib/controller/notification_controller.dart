import 'dart:convert';

import 'package:at_your_home_partner/constants/constants.dart';
import 'package:at_your_home_partner/model/notification_list_model.dart';
import 'package:at_your_home_partner/service/api_logs.dart';
import 'package:at_your_home_partner/service/api_service.dart';



class NotificationController extends GetxController implements GetxService {
  bool isLoading = false;
  var notificationList = <NotificationListModel>[];

  Future<void> notificationsGet() async {
    isLoading = true;
    notificationList.clear();
    try {
      var result = await ApiService.vendorNotificationList();
      var json = jsonDecode(result.body);
      if (json["status"] == true) {
        isLoading = false;
        notificationList = List<NotificationListModel>.from(json['data'].map((i) => NotificationListModel.fromJson(i))).toList(growable: true);
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
