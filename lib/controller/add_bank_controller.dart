import 'dart:convert';

import 'package:at_your_home_partner/constants/constants.dart';
import 'package:at_your_home_partner/model/bank_list_model.dart';
import 'package:at_your_home_partner/service/api_logs.dart';
import 'package:at_your_home_partner/service/api_service.dart';

class AddBankController extends GetxController implements GetxService {
  TextEditingController bankName = TextEditingController();
  TextEditingController ifscCode = TextEditingController();
  TextEditingController accountNo = TextEditingController();
  TextEditingController accountCNo = TextEditingController();
  TextEditingController branch = TextEditingController();
  TextEditingController holderName = TextEditingController();
  bool isLoading = false;
  var bankList = <BankListModel>[];

  Future<void> bankListGet() async {
    isLoading = true;
    try {
      bankList.clear();
      var result = await ApiService.vendorListBank();
      var json = jsonDecode(result.body);
      if (json["status"] == true) {
        bankList = List<BankListModel>.from(json['data'].map((i) => BankListModel.fromJson(i))).toList(growable: true);
      } else {
        errorToast("Bank List not found");
      }

      isLoading = false;
    } catch (e) {
      isLoading = false;
      Log.console(e.toString());
    }
    update();
  }

  Future<void> vendorAddBank() async {
    try {
      showProgress();
      var result = await ApiService.vendorAddBank(
        bankName.text,
        ifscCode.text,
        accountNo.text,
        branch.text,
        holderName.text,
      );
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
}
