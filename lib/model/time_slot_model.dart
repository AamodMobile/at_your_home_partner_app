class TimeSlotData {
  int? id;
  String? title;

  TimeSlotData({this.id, this.title});

  TimeSlotData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['timeslots'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['timeslots'] = title;
    return data;
  }
}