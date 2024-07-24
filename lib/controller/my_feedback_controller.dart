import 'dart:convert';

import 'package:at_your_home_partner/constants/constants.dart';
import 'package:at_your_home_partner/model/my_feedback_list_model.dart';
import 'package:at_your_home_partner/service/api_logs.dart';
import 'package:at_your_home_partner/service/api_service.dart';

class MyFeedbackController extends GetxController implements GetxService {
  bool isLoading = false;
  var myFeedbackList = <RatingModelModel>[];

  Future<void> myFeedbackGet() async {
    isLoading = true;
    myFeedbackList.clear();
    try {
      var result = await ApiService.myRatings();
      var json = jsonDecode(result.body);
      if (json["status"] == true) {
        isLoading = false;
        myFeedbackList = List<RatingModelModel>.from(json["data"].map((i) => RatingModelModel.fromJson(i))).toList(growable: true);
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
