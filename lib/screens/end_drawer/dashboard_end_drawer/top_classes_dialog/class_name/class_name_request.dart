import 'dart:convert';

class ClassNameRequest {
  int classid;

  ClassNameRequest({
    required this.classid,
  });

  ClassNameRequest copyWith({
    int? classid,
  }) =>
      ClassNameRequest(
        classid: classid ?? this.classid,
      );

  factory ClassNameRequest.fromRawJson(String str) => ClassNameRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ClassNameRequest.fromJson(Map<String, dynamic> json) => ClassNameRequest(
    classid: json["classid"],
  );

  Map<String, dynamic> toJson() => {
    "classid": classid,
  };
}
