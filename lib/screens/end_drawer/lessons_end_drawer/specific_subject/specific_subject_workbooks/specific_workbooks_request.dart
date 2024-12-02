import 'dart:convert';

class WorkBooksRequest {
  int subjectId;
  int semesterId;
  int classId;

  WorkBooksRequest({
    required this.subjectId,
    required this.semesterId,
    required this.classId,
  });

  WorkBooksRequest copyWith({
    int? subjectId,
    int? semesterId,
    int? classId,
  }) =>
      WorkBooksRequest(
        subjectId: subjectId ?? this.subjectId,
        semesterId: semesterId ?? this.semesterId,
        classId: classId ?? this.classId,
      );

  factory WorkBooksRequest.fromRawJson(String str) => WorkBooksRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory WorkBooksRequest.fromJson(Map<String, dynamic> json) => WorkBooksRequest(
    subjectId: json["SubjectID"],
    semesterId: json["SemesterID"],
    classId: json["ClassID"],
  );

  Map<String, dynamic> toJson() => {
    "SubjectID": subjectId,
    "SemesterID": semesterId,
    "ClassID": classId,
  };
}
