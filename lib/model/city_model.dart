class CityModel {
  String? label;
  String? value;

  CityModel({
    this.label,
    this.value,
  });

  factory CityModel.fromJson(Map<String, dynamic> json) => CityModel(
    label: json["label"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "label": label,
    "value": value,
  };
}
