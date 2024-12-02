import 'dart:convert';

class CurriculumsModelRequest {
  int semesterId;
  int classId;

  CurriculumsModelRequest({
    required this.semesterId,
    required this.classId,
  });

  CurriculumsModelRequest copyWith({
    int? semesterId,
    int? classId,
  }) =>
      CurriculumsModelRequest(
        semesterId: semesterId ?? this.semesterId,
        classId: classId ?? this.classId,
      );

  factory CurriculumsModelRequest.fromRawJson(String str) => CurriculumsModelRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CurriculumsModelRequest.fromJson(Map<String, dynamic> json) => CurriculumsModelRequest(
    semesterId: json["SemesterID"],
    classId: json["ClassID"],
  );

  Map<String, dynamic> toJson() => {
    "SemesterID": semesterId,
    "ClassID": classId,
  };
}
