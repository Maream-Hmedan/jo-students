import 'dart:convert';

class BooksVideoRequest {
  int subjectId;
  int semesterId;
  int classId;

  BooksVideoRequest({
    required this.subjectId,
    required this.semesterId,
    required this.classId,
  });

  BooksVideoRequest copyWith({
    int? subjectId,
    int? semesterId,
    int? classId,
  }) =>
      BooksVideoRequest(
        subjectId: subjectId ?? this.subjectId,
        semesterId: semesterId ?? this.semesterId,
        classId: classId ?? this.classId,
      );

  factory BooksVideoRequest.fromRawJson(String str) => BooksVideoRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BooksVideoRequest.fromJson(Map<String, dynamic> json) => BooksVideoRequest(
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
