
class BankListModel {
  int? id;
  String? vendorId;
  String? bankName;
  String? ifscCode;
  String? accountNo;
  String? micrNo;
  String? branch;

  BankListModel({
    this.id,
    this.vendorId,
    this.bankName,
    this.ifscCode,
    this.accountNo,
    this.micrNo,
    this.branch,
  });

  factory BankListModel.fromJson(Map<String, dynamic> json) => BankListModel(
    id: json["id"],
    vendorId: json["vendor_id"],
    bankName: json["bank_name"],
    ifscCode: json["ifsc_code"],
    accountNo: json["account_no"],
    micrNo: json["micr_no"],
    branch: json["branch"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "vendor_id": vendorId,
    "bank_name": bankName,
    "ifsc_code": ifscCode,
    "account_no": accountNo,
    "micr_no": micrNo,
    "branch": branch,
  };
}
