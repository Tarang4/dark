class UserModel {
  int? id;
  String? title;
  String? note;
  String? date;
  String? startTime;
  String? endTime;
  int? color;
  int? remind;
  String? repeat;

  UserModel({this.id,
    this.title,
    this.note,
    this.date,
    this.startTime,
    this.endTime,
    this.color,
    this.remind,
    this.repeat});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    note = json['note'];
    date = json['date'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    color = json['color'];
    remind = json['remind'];
    repeat = json['repeat'];
  }

  Map<String, dynamic> toJson() =>
      {
        "id": id,
        "title": title,
        "note": note,
        "date":date,
        "startTime": startTime,
        "endTime": endTime,
        "color": color,
        "remind": remind,
        "repeat": repeat
      };

//   Map<String, dynamic> toJson() {
//   final Map<String, dynamic> data = <String, dynamic>{};
//   data['id'] = this.id;
//   data['title'] = this.title;
//   data['note'] = this.note;
//   data['date'] = this.date;
//   data['startTime'] = this.startTime;
//   data['endTime'] = this.endTime;
//   data['color'] = this.color;
//   data['remind'] = this.remind;
//   data['repeat'] = this.repeat;
//
//   return data;
// }
}

