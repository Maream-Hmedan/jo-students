import 'dart:convert';

class UpdateClassRequest {
  int userid;
  int classid;

  UpdateClassRequest({
    required this.userid,
    required this.classid,
  });

  UpdateClassRequest copyWith({
    int? userid,
    int? classid,
  }) =>
      UpdateClassRequest(
        userid: userid ?? this.userid,
        classid: classid ?? this.classid,
      );

  factory UpdateClassRequest.fromRawJson(String str) => UpdateClassRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UpdateClassRequest.fromJson(Map<String, dynamic> json) => UpdateClassRequest(
    userid: json["userid"],
    classid: json["classid"],
  );

  Map<String, dynamic> toJson() => {
    "userid": userid,
    "classid": classid,
  };
}
