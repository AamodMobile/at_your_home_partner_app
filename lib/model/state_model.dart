class StateModel {
  String? label;
  String? value;

  StateModel({
    this.label,
    this.value,
  });

  factory StateModel.fromJson(Map<String, dynamic> json) => StateModel(
    label: json["label"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "label": label,
    "value": value,
  };
}
