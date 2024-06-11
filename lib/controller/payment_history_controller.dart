import 'dart:convert';

import 'package:at_your_home_partner/constants/constants.dart';
import 'package:at_your_home_partner/model/payment_history_model.dart';
import 'package:at_your_home_partner/service/api_logs.dart';
import 'package:at_your_home_partner/service/api_service.dart';

class PaymentHistoryController extends GetxController implements GetxService {
  bool isLoading = false;
  var paymentModel = PaymentModel();
  var paymentHistoryList = List<PaymentHistoryModel>.empty(growable: true);

  Future<void> paymentHistoryGet() async {
    isLoading = true;
   // try {
      paymentHistoryList.clear();
      var result = await ApiService.paymentHistory();
      var json = jsonDecode(result.body);
      if (json["status"] == true) {
        paymentModel = PaymentModel.fromJson(json);
        paymentHistoryList = List<PaymentHistoryModel>.from(json['data'].map((i) => PaymentHistoryModel.fromJson(i))).toList(growable: true);
      } else {
        errorToast(json["status"].toString());
      }
      isLoading = false;
  //  } catch (e) {
   //   isLoading = false;
   //   Log.console(e.toString());
  //  }
    update();
  }
}
