import 'dart:convert';

class LiveClassRequest {
  int semesterId;
  int classId;

  LiveClassRequest({
    required this.semesterId,
    required this.classId,
  });

  LiveClassRequest copyWith({
    int? semesterId,
    int? classId,
  }) =>
      LiveClassRequest(
        semesterId: semesterId ?? this.semesterId,
        classId: classId ?? this.classId,
      );

  factory LiveClassRequest.fromRawJson(String str) => LiveClassRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LiveClassRequest.fromJson(Map<String, dynamic> json) => LiveClassRequest(
    semesterId: json["SemesterID"],
    classId: json["ClassID"],
  );

  Map<String, dynamic> toJson() => {
    "SemesterID": semesterId,
    "ClassID": classId,
  };
}
