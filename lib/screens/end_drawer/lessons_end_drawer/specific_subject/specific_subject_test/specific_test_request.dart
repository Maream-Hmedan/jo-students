import 'dart:convert';

class BooksTestRequest {
  int subjectId;
  int semesterId;
  int classId;

  BooksTestRequest({
    required this.subjectId,
    required this.semesterId,
    required this.classId,
  });

  BooksTestRequest copyWith({
    int? subjectId,
    int? semesterId,
    int? classId,
  }) =>
      BooksTestRequest(
        subjectId: subjectId ?? this.subjectId,
        semesterId: semesterId ?? this.semesterId,
        classId: classId ?? this.classId,
      );

  factory BooksTestRequest.fromRawJson(String str) => BooksTestRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BooksTestRequest.fromJson(Map<String, dynamic> json) => BooksTestRequest(
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
