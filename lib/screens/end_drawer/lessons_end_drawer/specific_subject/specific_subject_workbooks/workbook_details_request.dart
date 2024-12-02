import 'dart:convert';

class WorkBookDetailsRequest {
  int bookId;
  int semesterId;
  int classId;
  int subjectId;

  WorkBookDetailsRequest({
    required this.bookId,
    required this.semesterId,
    required this.classId,
    required this.subjectId,
  });

  WorkBookDetailsRequest copyWith({
    int? bookId,
    int? semesterId,
    int? classId,
    int? subjectId,
  }) =>
      WorkBookDetailsRequest(
        bookId: bookId ?? this.bookId,
        semesterId: semesterId ?? this.semesterId,
        classId: classId ?? this.classId,
        subjectId: subjectId ?? this.subjectId,
      );

  factory WorkBookDetailsRequest.fromRawJson(String str) => WorkBookDetailsRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory WorkBookDetailsRequest.fromJson(Map<String, dynamic> json) => WorkBookDetailsRequest(
    bookId: json["BookID"],
    semesterId: json["SemesterID"],
    classId: json["ClassID"],
    subjectId: json["SubjectID"],
  );

  Map<String, dynamic> toJson() => {
    "BookID": bookId,
    "SemesterID": semesterId,
    "ClassID": classId,
    "SubjectID": subjectId,
  };
}
